function Z = FeedforwardNN(X, weights)

%   Inputs:
%       X           - A numFeatures-by-numInputSubwords input array.
%       weights     - The weights for the multi-layer perceptron stored in
%                     a struct. This includes:
%                       - mlp_c_fc_w_0: A weight matrix for the first fully
%                         connected layer.
%                       - mlp_c_fc_b_0: A bias vector for the first fully
%                         connected layer.
%                       - mlp_c_proj_w_0: A weight matrix for the second
%                         fully connected layer.
%                       - mlp_c_proj_b_0: A bias vector for the second
%                         fully connected layer.
%
%   Outputs:
%       Z           - A numFeatures-by-numInputSubwords output array.

Z = dlconv(X, weights.mlp_c_fc_w_0, weights.mlp_c_fc_b_0, 'Padding', 'same', 'Stride', [1, 1], 'DataFormat','SSCB');

Z = transformer.layer.gelu(Z);
%Z = relu(Z);

Z = dlconv(Z, weights.mlp_c_proj_w_0, weights.mlp_c_proj_b_0, 'Padding', 'same', 'Stride', [1, 1], 'DataFormat','SSCB');

end