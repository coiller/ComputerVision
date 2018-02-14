function bow_repr=computeBOWRepr(features, means)
bow=zeros(1,size(means,1));
%each feature
for i=1:size(features,1)
    min=inf;
    index=0;
    %find min distance cluster
    for j=1:size(means,1)
        dist=norm(features(i,:)-means(j,:));
        if(min>dist)
            min=dist;
            index=j;
        end
    end
    bow(1,index)=bow(1,index)+1;
end
bow_repr=bow/norm(bow);
end