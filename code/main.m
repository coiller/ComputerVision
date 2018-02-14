clear;clc;
ipath={'cardinal1.jpg';    'cardinal2.jpg';    'leopard1.jpg'  ;  'leopard2.jpg' ;   'panda1.jpg'  ;  'panda2.jpg'};
% 3.Preproceed images
images=cell(1,6);
gimages=cell(1,6);
rgimages=cell(1,6);
load('filters.mat');
load('means.mat');
bow_repr=zeros(6,size(means,1));
texture_repr_mean=zeros(6,size(F,3));
%process images
for i = 1:size(ipath)
    images{i}=imread(ipath{i});
    gimages{i}=rgb2gray(images{i});
    rgimages{i}=imresize(gimages{i},[100,100]);
end
for i = 1:size(ipath)
    %part2 Feature Detection
    [x, y, scores, Ix, Iy]=extract_keypoints(gimages{i},F);
    f=figure('Visible','off');
    imshow(images{i},'InitialMagnification',100,'Border','tight','Reduce',0);
    hold on;
    scatter(x,y,'r.');
    hold on;
    s=cast(scores,'double');
    sz=s/(max(s)-min(s))*1000;
    scatter(x,y,sz,'ro');
    saveas(f,['KImages/',ipath{i}]);
    %part6 Comparison of Image Descriptions
    [x, y, scores, Ix, Iy]=extract_keypoints(rgimages{i},F);
    features=compute_features(x, y,rgimages{i});
    bow_repr(i,:)=computeBOWRepr(features, means);
    [texture_repr_concat(i,:), texture_repr_mean(i,:)]=computeTextureReprs(rgimages{i}, F);
end
%calculate distance and ratio
bd=squareform(pdist(bow_repr));
trcd=squareform(pdist(texture_repr_concat));
trmd=squareform(pdist(texture_repr_mean));
br=dratio(bd);
cr=dratio(trcd);
mr=dratio(trmd);
[br,cr,mr]
%part1 filters
for i= 1:size(F,3)
    f=figure('Visible','off');
    subplot(2,4,1);
    imshow(mat2gray(F(:,:,i)),'Colormap',parula);
    axis on;
    for k=1:size(ipath)
        subplot(2,4,k+2);
        imshow(mat2gray(imfilter(rgimages{k},F(:,:,i),'conv')),'Colormap',parula);
        axis on;
        title(ipath{k});
    end
    saveas(f,sprintf('%s%d%s','FImages/Filter',i,'.jpg'));
end
