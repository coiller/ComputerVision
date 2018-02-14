# Image description  

- ## Description  

    This is a computer vision course assignment aim to implement filters on images and use SIFT BOW & texture to discripte images. Compare the classifictaion ability of different algorithm.

- ## Input

    Three pairs of images, each pair is about same animal.

- ## Algorithm 

    - ### SIFT + BOW

        Implemented feature extraction using the Harris corner detector and a feature description pipeline. Computed a bag-of-words histogram representation of an image.  
    ![](https://github.com/coiller/ComputerVision/blob/master/vis11.jpg)

    - ### Texture Description

        Computed two image representations based on the filter responses. The first simply be a concatenation of the filter responses for all pixels and all filters. The second contains the mean of filter reponses (averaged across all pixels) for each image. 

    [Course Info](http://people.cs.pitt.edu/~kovashka/cs2770_sp18/)
