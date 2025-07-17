lgraph = [
    imageInputLayer(Input_Layer_Size,"Name","imageinput")
    convolution2dLayer([3 3],8,"Name","conv_1","Padding","same")
    reluLayer("Name","relu_1")
    convolution2dLayer([3 3],8,"Name","conv_2","Padding","same")
    reluLayer("Name","relu_2")
    resize2dLayer("Name","resize-output-size","GeometricTransformMode","half-pixel","Method","nearest","NearestRoundingMode","round","OutputSize", size(YTrain_RSRP, [1, 2]))
    convolution2dLayer([3 3],2,"Name","conv_3","Padding","same")
    regressionLayer("Name","regressionoutput")];
