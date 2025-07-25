# Achieving Robust Channel Estimation Neural Networks by Designed Training Data

Code for Luan, Dianxin, and John Thompson. "Achieving Robust Channel Estimation Neural Networks by Designed Training Data." IEEE Transactions on Cognitive Communications and Networking (2025). 

Cite as: 

	@ARTICLE{11096086,
  	author={Luan, Dianxin and Thompson, John},
  	journal={IEEE Transactions on Cognitive Communications and Networking}, 
  	title={Achieving Robust Channel Estimation Neural Networks by Designed Training Data}, 
  	year={2025},
  	volume={},
  	number={},
  	pages={1-1},
  	keywords={Neural networks;Channel estimation;Training;OFDM;Symbols;Time-domain analysis;Delays;Matrix converters;Fast Fourier transforms;Estimation;Channel estimation;generalization;neural network;orthogonal frequency division multiplexing (OFDM)},
  	doi={10.1109/TCCN.2025.3592299}}

%%%

Abstract:
Channel estimation is crucial in wireless communications. However, in many papers neural networks are frequently tested by training and testing on one example channel or similar channels. This is because data-driven methods often degrade on new data which they are not trained on, as they cannot extrapolate their training knowledge. This is despite the fact physical channels are often assumed to be time-variant. However, due to the low latency requirements and limited computing resources, neural networks may not have enough time and computing resources to execute online training to fine-tune the parameters. This motivates us to design offline-trained neural networks that can perform robustly over wireless channels, but without any actual channel information being known at design time. In this paper, we propose design criteria to generate synthetic training datasets for neural networks, which guarantee that after training the resulting networks achieve a certain mean squared error (MSE) on new and previously unseen channels. Therefore, trained neural networks require no prior channel information or parameters update for real-world implementations. Based on the proposed design criteria, we further propose a benchmark design which ensures intelligent operation for different channel profiles. To demonstrate general applicability, we use neural networks with different levels of complexity to show that the generalization achieved appears to be independent of neural network architecture. From simulations, neural networks achieve robust generalization to wireless channels with both fixed channel profiles and variable delay spreads. 

%%%

	Run Demonstration_of_H_Rayleigh_Propogation_Channel, Demonstration_of_H_Rayleigh_Propogation_Channel_Alternative and Demonstration_of_H_Rayleigh_Propogation_Channel_batch files to test for sub-6 band results. 

 	Run Demonstration_of_H files to test for Millimeter-wave band results. 

  	Run Demonstration_of_H_Appendix to get the first three figures of Simulation Section. 

%% File +Training has 

		ResNN_pilot_regression to train the InterpolateNet and SimpleNet for default pilot pattern. 
  		ResNN_pilot_regression_Alternative to train the InterpolateNet and SimpleNet for alternative pilot pattern. 
		Training_hybrid_offline to train Channelformer. 
  		Training_hybrid_offline_Alternative to train Channelformer for alternative pilot pattern. 

%% File +parameter has 

		parameters contains the system parameters for generating the training data and testing on the default pilot pattern on sub-6 band. 
		parameters_alternative contains the system parameters for generating the training data and testing on the alternative pilot pattern on sub-6 band. 
		parameters_hybrid contains the hyperparameters for Channelformer. 
		parameters_Millimeterwave contains the hyperparameters for CDL/TDL channels operating on Millimeter-wave band (39GHz). 

%% File +Channel contains 

		Propagation_Channel_Model is a LTEfading channel developed by MATLAB specificed in https://uk.mathworks.com/help/lte/ref/ltefadingchannel.html. 
  		CDL_Channel contains 3GPP TS38.901 CDL channel - nrCDLChannel object. 
    		TDL_Channel contains 3GPP TS38.901 TDL channel - nrTDLChannel object. 

%% File +CSI has

		LS - It is the implementation of the LS method and the time interpolation method is bilinear method. 
		MMSE - It is the linear MMSE method and the time interpolation method is bilinear method. 

%% File +Data_Generation contains

		Data_Generation - used to generate the training data for online Channelformer offline
		Data_Generation_Online - used to generate the training data for online training
		Data_generation_offline_version - used to generate the training data for offline Channelformer and HA02. 
		Data_Generation_Residual - used to generate the training data for InterpolateNet and ReEsNet
		Data_Generation_Transformer - used to generate the training data for TR method. 

%% File +OFDM contains 

		OFDM_Receiver - OFDM receiver
		OFDM_Transmitter - OFDM transmitter
		Pilot_extract - extract the pilot 
		Pilot_Insert - insert the pilot 
		QPSK_Modualtor - generate QPSK symbols 
		QPSK_Demodulator - decode the received QPSK signals

%% File +Performance_plot contains

  		Plot_Alternative - plot function. 
    		Plot_Appendix - plot function. 
      		Plot_BER - plot function. 
		Plot_HA02 - plot function. 
  		Plot_InterpolateNet - plot function. 
    		Plot_N_f - plot function. 
      		Plot_SimpleNet - plot function. 
		Plot_batch - plot function. 
  		Plot_generalization - plot function. 

%% File Residual_NN contains 

		Interpolation_ResNet - Untrained InterpoalteNet (WSA paper)
		SimpleNet - 882 parameters neural networks
  
%% File +transformer contains Channelformer code 

		model - system model for Channelformer
		+HA03 - The encoder and decoder architecture of Channelformer
			Encoder_block - the encoder of Channelformer 
			Decoder_block - the decoder of Channelformer
		+layer contains the layer modules for attanetion mechanism and residual convolutional neural network
			normalization - layer normalization
			FC1 - fully-connected layer
			gelu - Activation function of GeLu
			multiheadAttention - multihead attention module, which calcualte the attention from Q, K and V
			attention - main control unite of the multiohead attention module, designed by tranformer encoder
			FeedforwardNN - feedforward neural network designed by tranformer encoder

%%% Comments 

Run with MATLAB, with fully-installed deep learning toolbox because it requires customized training. 
