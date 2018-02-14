function ratio=dratio(m)
iavg=mean([m(1,2),m(3,4),m(5,6)]);%average_within_class_distance
oavg=mean([m(1,3:6),m(2,3:6),m(3,5:6),m(4,5:6)]);%average_between_class_distance
ratio=iavg/oavg;
end