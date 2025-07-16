%% Training options

minibatch_size = 128;

Training_set_ratio = 0.995;
SNR_range = 5:5:25;
Num_of_frame_each_SNR = 25000; 

numEpochs = 100;
learnRate = 2e-3; 
Dropperiod = 30;
Droprate = 0.5;
Validation_frequency = 1000;

load_parameters = false;
parameter_file = 'parameters_EPA';

disp(gpuDeviceTable);

%% Data generation

[Training_X, Training_Y, Validation_X, Validation_Y] = Data_Generation.Data_generation_offline_version(Training_set_ratio, SNR_range, Num_of_frame_each_SNR);

%[Training_X, Training_Y, Validation_X, Validation_Y] = Data_Generation.Data_generation_offline_version_Appendix(Training_set_ratio, SNR_range, Num_of_frame_each_SNR);

X = arrayDatastore(reshape(Training_X, size(Training_X, 1), size(Training_X, 2), size(Training_X, 4)), 'IterationDimension', 3);
Y = arrayDatastore(reshape(Training_Y, size(Training_Y, 1), size(Training_Y, 2), size(Training_Y, 4)), 'IterationDimension', 3);
cdsTrain = combine(X, Y);

mbqTrain = minibatchqueue(cdsTrain, 2,...
    'MiniBatchSize', minibatch_size,...
    'MiniBatchFcn', @preprocessMiniBatch,...
    'MiniBatchFormat', {'',''},...
    "PartialMiniBatch", "discard");

cdsValidation = combine(arrayDatastore(reshape(Validation_X, size(Training_X, 1), size(Training_X, 2), size(Validation_X, 4)), 'IterationDimension', 3), arrayDatastore(reshape(Validation_Y, size(Validation_Y, 1), size(Validation_Y, 2), size(Validation_Y, 4)), 'IterationDimension', 3));

mbqValidation = minibatchqueue(cdsValidation, 2,...
    'MiniBatchSize', minibatch_size,...
    'MiniBatchFcn', @preprocessMiniBatch,...
    'MiniBatchFormat', {'',''},...
    "PartialMiniBatch", "discard");

shuffle(mbqValidation);

Feature_size = size(Training_X, 1);

%% Initialize

if load_parameters == true
    
    load(parameter_file);
    
else
    
    parameters.Hyperparameters.NumHeads = 2;
    parameters.Hyperparameters.Encoder_num_layers = 1;
    parameters.Hyperparameters.Decoder_num_layers = 1;
    
    Parameter.parameters_hybrid
    
end

%% Train the model using a custom training loop

% For each epoch, shuffle the mini-batch queue and loop over mini-batches
% of data. At the end of each iteration, update the training progress plot
%
% For each iteration:
% * Read a mini-batch of data from the mini-batch queue. 
% * Evaluate the model gradients and loss using the |dlfeval| and
%   |modelGradients| functions
% * Update the network parameters using the |adamupdate| function.
% * Update the training plot

% Initialize training progress plot
figure
lineLossTrain = animatedline("Color", [0.8500 0.3250 0.0980]);
lineLossValidation = animatedline("Color", [0 0.4470 0.7410]);

ylim([0 12]);
xlabel("Iteration");
ylabel("Loss");

% Initialize parameters for the Adam optimizer
trailingAvg = [];
trailingAvgSq = [];

iteration = 0;
start = tic;

% Loop over epochs
for epoch = 1 : numEpochs
    
    % Shuffle data
    shuffle(mbqTrain);
    
    % Loop over mini-batches
    while hasdata(mbqTrain)
        iteration = iteration + 1;
        
        % Read mini-batch of data
        [Training_X_minibatch, Training_Y_minibatch] = next(mbqTrain);
        
        if hasdata(mbqValidation)
            [Xvalidation_minibatch, Yvalidation_minibatch] = next(mbqValidation);
        else
            reset(mbqValidation);
        end
        
        % Evaluate loss and gradients
        [loss, gradients] = dlfeval(@modelGradients, Training_X_minibatch, Training_Y_minibatch, parameters);
        
        % Update model parameters
        if ismember(epoch, Dropperiod)
            learnRate = learnRate * Droprate;
        end
        
        [parameters.Weights, trailingAvg, trailingAvgSq] = adamupdate(parameters.Weights, gradients, ...
            trailingAvg, trailingAvgSq, iteration, learnRate);
        
        % Update training plot
        loss = double(gather(extractdata(loss)));
        addpoints(lineLossTrain, iteration, loss);
        
        if iteration == 1 || mod(iteration, Validation_frequency) == 0
            
            % Validation set
            Prediction_validation = transformer.model(Xvalidation_minibatch, parameters);
            %loss_validation = Myloss(Yvalidation_minibatch, Prediction_validation);
            loss_validation = huber(Yvalidation_minibatch, Prediction_validation, "DataFormat", "SSCB", 'TransitionPoint', 1);
            
            loss_validation = double(gather(extractdata(loss_validation)));
            addpoints(lineLossValidation, iteration, loss_validation);
            
        end
        
        disp("loss = " + loss)
        disp("Validation loss = " + loss_validation)
        
        D = duration(0,0,toc(start),'Format','hh:mm:ss');
        title("Epoch: " + epoch + ", Elapsed: " + string(D))
        drawnow
    end
end

%% Supporting Functions

function [loss, gradients] = modelGradients(X, Y, parameters)

Prediction = transformer.model(X, parameters);
loss = huber(Y, Prediction, "DataFormat", "SSCB", 'TransitionPoint', 1); % , "DataFormat", "SCB" huber change_dimension(Y)
gradients = dlgradient(loss, parameters.Weights);

end

function [X, Y] = preprocessMiniBatch(XCell, YCell)
    
    % Extract image data from cell and concatenate
    X = cat(4, XCell{:});
    % Extract label data from cell and concatenate
    Y = cat(4, YCell{:});
        
end
