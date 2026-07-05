# Achieving Robust Channel Estimation Neural Networks by Designed Training Data

Code for Luan, Dianxin, and John Thompson. "Achieving Robust Channel Estimation Neural Networks by Designed Training Data." IEEE Transactions on Cognitive Communications and Networking (2025). 

This work is featured by MIT technique review China at https://www.mittrchina.com/news/detail/15271. 

Cite as: 

	@article{luan2025achieving,
  	title={Achieving Robust Channel Estimation Neural Networks by Designed Training Data},
  	author={Luan, Dianxin and Thompson, John},
  	journal={IEEE Transactions on Cognitive Communications and Networking},
  	year={2025},
  	publisher={IEEE}
	}

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

%%% Acknowledgement

This research is supported by EPSRC projects EP/X04047X/2 and EP/Y037243/1 (TITAN project). 

%%% Previous submission 

To Tcom and some very interesting comments as: 
It is funny enough, especially for reviewer 3. 

Reviewer: 1

Comments to the Author
The authors proposed design criteria to generate training datasets which will ensure neural networks robustly generalize to different channels. The idea is timely and interesting. The reviewer has the following comments:

1) The title of the paper uses "channel estimation". However, the input of the designed network is the LS estimation. In other words, the authors assumed that the channel has been estimated by the LS estimator. In the view of the reviewer, the author's work is about channel denoising rather than channel estimation.

2) In section I-A, the second contribution, what does "a CE channel design" mean? Do you mean "channel estimation channel design"? The phase is confusing.

3) The authors considered a single-input-single-output system. Is the proposed method suitable for MIMO systems?

4) Eq (8) and Eq (9) describe the function of LS estimation. What is the difference between Eq(8-9) and Eq(6)?

5) In section IV-A, why did the authors utilize AWGN noise? In practice, the noise may not be AWGN noise. Can the proposed algorithm generalized to other noise?

6) In section IV-B, the authors said "We find that by being trained on a channel with high-eigenvalue and high-rank auto-correlation (by setting a higher delay spread and path gain), the trained neural networks will generalize well to a wide range of channels.". Can you explain the reason and the insight or provide proof of such a phenomenon?

7) In section IV-B, "The first several elements of λ are expected to contain the main channel power, which will ensure only a small performance loss when the designed estimator is simulated with mismatched channel statistics.". The reviewer thinks that if the estimator encounters the channel whose first several elements of λ can not contain the main channel power, then the performance loss will be large. Hence, such an assumption is a little confusing.

8) What does ", the size Nf inverse Fourier transform" mean?

9) The reviewer thinks that NMSE may be a more proper performance metric.

10) Section II and Section III introduce the 5G NR and existing algorithms. However, the reviewer thinks that these two parts take up too much space. The proposed algorithms should take up more space.


Reviewer: 2

Comments to the Author
In this manuscript, authors propose a dataset generation method to improve generalization capabilities of DNN solutions for channel estimation. Furthermore, the generalization ability is tested by using different DNNs with varying complexity.

I have some comments and questions for the paper.

1)In the main contributions, it is first proposed that NNs can achieve both time and frequency interpolation better for unseen data. Then, to test the generalization the trained DNNs are tested on different delay spread values. In this case, time interpolation which depends on Doppler spread is missing. Can you elaborate more on this contradiction?

2)Abbreviations such as SNR should be given at the first use.

3)Can you elaborate more on the relation with high-eigenvalue and high-rank channel?

4)The results are actually similar with "Robust MMSE Channel Estimation in OFDM Systems with Practical Timing Synchronization" paper. Can you comment on this common solution.

5) In the numerical results, how do you construct MMSE filter? Does it use the exact PDP?

5)What if the actual channel delay spread is too small? Then, would there be any performance improvement if we shorten maximum delay spread in the train dataset? Maybe, you can have numerical results with varying desired channel lengths.

6)It would be helpful, if you also compare channel estimation performance with MMSE CE over AWGH channel in addition to the designed channel.

Reviewer: 3

Comments to the Author
In this paper, the authors provided some empirical study about how to design training data to optimize the generalization performance of neural network based OFDM channel estimators. However, the reviewer has serious concerns on many aspects of the paper. After careful reading of the manuscript, the reviewer believes it cannot be accepted based on the following reasons:  

1) The motivation is questionable. It seems to the reviewer that it is not a good idea to ‘design’ training data to enhance the generalization performance, at least for the channel estimation problem, as it is not easy to collect clean channel data to perform training in real-world systems. For academic research, of course you can easily generate some synthetic data. However, in the real world, channel data can only be obtained through channel estimation itself (based on some traditional algorithms, say LS). To obtain training data as required by your study, long pilot sequences and large transmit power are needed to ensure the quality of the estimated channel. Worse still, the mobility, blockage, and hardware imperfection will make the data collection process even more costly and difficult. The collected data can be quickly outdated due to mobility. Hence, it seems strange to ‘design’ the data for training, given the fact the collecting them is already extremely challenging.

The reviewer agrees that generalization is a critical problem. However, evaluating the generalization of algorithms is meaningful only when they are operating under the [SAME] dataset. This is a common sense in evaluating domain generalization and adaptation algorithms. Artificially designing the dataset is like changing the rule of the game, which makes the comparison impractical and is hence not appreciated.
2) The technical quality does not meet the standard of TCOM. Literally, the authors did not propose anything that is mathematically serious. Almost every so-called principle is completely empirical, and some of the claims are even wrong. For example, in Section IV.A, the authors argue that training in high SNR will deteriorate the performance in low SNR, and vice versa. However, this is supported by neither mathematical analysis nor empirical simulations. One can easily find a counter example for the claims on SNR. Back in 2017, in the seminal paper of DnCNN authored by Kai Zhang et al., the authors have already proposed a denoising network that can handle arbitrary and unknown AWGN noise level. Follow-up works in their group further extend to the blind denoising of other non-Gaussian type of noise. In the wireless community, it has also been reported that channel estimators based on DnCNN can readily generalize to different noise levels. The claim is hence not valid. For other claims, similar problems exist. The paper seriously lacks mathematical rigor.
3) Most conclusions over-claiming and cannot be supported by the presented results. The paper is written in a very ambitious tone, but the true contributions significantly mismatch the claimed contributions. For example, in the conclusion, the authors argue that ‘Moreover, the proposed design criteria is applicable for nearly arbitrary neural networks because no specific neural architecture is required.’ However, the experimental results on a very limited set of neural networks are only a necessary condition of this claim, but far from the sufficient condition. The ambitious claim is not supported by any rigorous analysis or measurement campaign.

To really offer some insight, the authors are suggested to start form some simple neural network structures, e.g., reservoir computing or extreme learning machine, and perform some analysis that has solid theoretical foundations.
4) The presentation needs careful improvement. There are many typos, inconsistencies in notations, and sentences that are hard to understand. Please use a factual tone in your writing and avoid exaggeration.

Presentation Issues:

1) Some sentences in the paper seems over-claiming the contributions and should be avoided. For example, in the abstract, ‘This paper indicates one step towards artificial general intelligence (AGI) from new perspectives.’ Also, please try to avoid the frequent use of absolute words, e.g., ‘impossible’, ‘never’, ‘completely’, ‘maximum’, etc.
2) In Section I (1), please include relevant references to support your claim: ‘For example, the slot length is usually from 0.0625 milliseconds to 1 millisecond defined in the 3GPP 38.211 document. Therefore, the receiver will require at least 62.5-1,000 milliseconds to collect 1,000 complete sets of channel examples.’ Also, in Section I.B, please cite the relevant documents for the 5G NR, 3GPP TS 36.101 and 3GPP TR 38.901 standards. Please also cite the standards in other parts when you mention them.
3) In Section I.A, second bullet point, it seems that the term ‘Bit Error Ratio’ should be ‘Bit Error *Rate*’ instead. The bit error rate is the number of bit errors per unit time. The bit error ratio is the number of bit errors divided by the total number of transferred bits during a studied time interval, often expressed as a percentage.
4) In Section II.A(1), the sentence ‘For each pilot OFDM symbol, the second subcarriers of each indices of L s = 2 subcarriers is reserved for pilot subcarriers.’ reads quite confusing, please improve the sentence.
5) In Section III.A, the sentence ‘To minimize the square of Euclidean distance between the actual channel matrix and the LS estimate for the pilot signals,’ seems not logical.
6) Please check for typos, e.g., Section I.A, ‘AI-assist’ should be ‘AI-assisted’, etc. Also, in the last paragraph of Section I, ‘we extend this’ and ‘criteria works’, ‘state of the art’ – ‘state-of-the-art’, ‘existing in the training data’ – ‘of the training data’ etc. In addition, there is no need to add a period after ‘Section’, ‘Table’, ‘Figure’, etc.
7) Please use vector graph formats, i.e., either .pdf or .eps, for the figures. Many of the figures are vague and not easily readable.

Notation Issues:

8) The notation system can be greatly improved. The authors used similar notations to denote vector, matrix, or even tensor in different places, which can cause great difficulty for readers. Please use capital boldface letters to represent matrices, and use lowercase boldface letters to represent vectors, and avoid inconsistencies. For example, in E.q. (7), I cannot even tell which vectors from matrices at a first glance. For clarity, please add a dedicated subsection at the end of Section I to explain the notation systems and the functions that will frequently appear.  
9) In Section II, please clearly explain the notations used. For example, the relationship between $h(t)$ in E.q. (1), $\mathbf{h}$ in E.q. (2), $\mathbf{H}(k)$ in E.q. (3), and $\mathbf{H}$ in E.q. (4) should be clearly explained right after the first time they appear.
10) In Section II, the authors mentioned matrices W, H, and X are the DFT of vectors w, x, and h. This looks very confusing. Why are the dimensions changed after the DFT?
11) In Section III.A, the notations are inconsistent. In (6), the authors used H_ls, Y_Pilot, and X_Pilot, but above the equation Y, H, and X are used instead.
12) Please provide the dimension for every vector and matrix mentioned in the manuscript.
