function [texture_repr_concat, texture_repr_mean]=computeTextureReprs (image, F)
responses =zeros([size(F,3),size(image)]);
texture_repr_mean=zeros(1,size(F,3));
for i=1:size(F,3)
    responses(i,:,:)=imfilter(image,F(:,:,i),'conv');
    %collapsing that information to a single value: the mean across all pixels
    texture_repr_mean(i)=mean2(responses(i,:,:));
end
%concatenating all pixels in the response images for all filters
    texture_repr_concat(1,:)=reshape(responses,1,[]);
end