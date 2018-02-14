function [x,y,scores,Ix,Iy]=extract_keypoints(image,F)
k=0.05;%set the value of k (from the "Harris Detector: Algorithm" slide) to 0.05
% Compute the horizontal image gradient Ix and the vertical image gradient Iy.
Ix=imfilter(image,F(:,:,1),'conv');
Iy=imfilter(image,F(:,:,4),'conv');
% Finally, initialize with zeros a matrix R of the same size as the image that
% will store the "cornerness" scores for each pixel.
r=size(image,1);
c=size(image,2);
x=[];
y=[];
scores=[];
R=zeros(r,c,'uint32');
Ms=zeros(2,2,r,c,'uint32');
%calculate matrix M and R
for m=1:r
    for n=1:c
        Ms(:,:,m,n)=[Ix(m,n)^2,Ix(m,n)*Iy(m,n);Ix(m,n)*Iy(m,n),Iy(m,n)^2];
    end
end
for m=3:r-2
    for n=3:c-2
        M=sum(sum(Ms(:,:,m-2:m+2,n-2:n+2),3),4);
        R(m,n)=det(M)-k*trace(M);
    end
end
%use top 1% as threshold
top=round((size(R,1)-2)*(size(R,2)-2)*0.01);
sR=sort(R(:),'descend');
threshold=sR(top);
for m=4:r-3
    for n=4:c-3
        if R(m,n)>threshold && R(m,n)==max(max(R(m-1:m+1,n-1:n+1)))
                x=[x;n];y=[y;m];scores=[scores;R(m,n)];
        end
    end
end
end