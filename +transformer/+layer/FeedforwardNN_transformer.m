function Z = FeedforwardNN_transformer(X, weights)

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

Z = transformer.layer.FC1( X, ...
    weights.mlp_c_fc_w_0, ...
    weights.mlp_c_fc_b_0 );
Z = transformer.layer.gelu(Z);
%Z = relu(Z);
Z = transformer.layer.FC1( Z, ...
    weights.mlp_c_proj_w_0, ...
    weights.mlp_c_proj_b_0 );

end