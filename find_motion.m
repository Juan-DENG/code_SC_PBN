function motion_T = find_motion( sample_rate,current,scratch_train_start,scratch_train_end )
%FIND_MOTION Summary of this function goes here
%   sample_rate 为Hz
%   current,scratch_train_start,scratch_train_end 单位应该为点，未转化成s等
pre_duration=3.5;
thresh=mean(double(current))+std(double(current))*3;
scratch_train_start=floor(scratch_train_start);
scratch_train_end=floor(scratch_train_end);
[pks,peak_T]=findpeaks(double(current),'minpeakheight',thresh);
for i=1:length(scratch_train_start)
    peak_T(peak_T >= scratch_train_start(i)-pre_duration*sample_rate & peak_T <= scratch_train_end(i)+pre_duration*sample_rate)=[];         % get rid of scratching event
end
if length(peak_T)<120
 motion_T=sort(peak_T(randperm(length(peak_T),floor(length(peak_T)/2))));                % randomly select 1/2 peak_T 
else
 motion_T=sort(peak_T(randperm(length(peak_T),60))); 
end
motion_T(motion_T<5*sample_rate | motion_T>length(current)-5*sample_rate)=[];       % get rid of moving starts too early or late
% figure
% plot((1:length(current))/sample_rate,current,scratch_train_start/sample_rate,current(scratch_train_start)+0.2,'gs',scratch_train_end/sample_rate,current(scratch_train_end)+0.2,'gs',motion_T/sample_rate,current(motion_T),'ro');
