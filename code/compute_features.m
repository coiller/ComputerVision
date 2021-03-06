function features=compute_features(x, y,img)
Ix=img;Iy=img;
features=zeros(size(x,1),8);
row=size(Ix,1);
col=size(Ix,2);
mx=zeros(row,col);
cx=zeros(row,col);
%calculate gradient magnitude m(x, y) and gradient angle ?(x, y)
for i=2:row-1
    for j=2:col-1
        mx(i,j)=sqrt(cast((Ix(i+1,j)-Ix(i-1,j))^2+(Iy(i,j+1)-Iy(i,j-1))^2,'double'));
        if(mx(i,j)==0)
            cx(i,j) =NaN;
        else
            cx(i,j)=atand(cast((Ix(i+1,j)-Ix(i-1,j))/(Iy(i,j+1)-Iy(i,j-1)),'double'));
        end
    end
end
%Quantize the gradient orientations in 8 bins
%each key point
for i=1:size(x)
    %board set to zero vector
    if(x(i)<6 || x(i)>row-5 || y(i)<6 || y(i)>col-5)
        features(i,:)=zeros(1,8);
    else
        %each bin
        for j=1:8
            %each 11*11
            for m=-5:5
                for n=-5:5
                    if(cx(y(i)+m,x(i)+n)>=-90+(j-1)*22.5 && cx(y(i)+m,x(i)+n)<-90+j*22.5)
                        features(i,j)=features(i,j)+mx(y(i)+m,x(i)+n);
                    end
                end
            end
        end
        %each 11*11 find ==90
        for m=-5:5
            for n=-5:5
                if(cx(y(i)+m,x(i)+n)==90)
                    features(i,8)=features(i,8)+mx(y(i)+m,x(i)+n);
                end
            end
        end
        %normalize
        p=features(i,:);
        p=p/norm(p);
        %clipping
        p(p>0.2)=0.2;
        %normalize
        p=p/norm(p);
        features(i,:)=p;
    end
end

end