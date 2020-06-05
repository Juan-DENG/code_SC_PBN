function [ Train_onset, Train_offset, bout_T, train_T, bout_duration, train_duration, moving_T, H_figure] = SCRATCH(event_file, Scratch_channel, INFO_file, Analog_sample_rate )
%SCRATCH Summary of this function goes here
H_figure=[];
if ischar(INFO_file)
    a=load(INFO_file);
    Scratch_data=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
    scratch_spikeT=sort(Scratch_data.spike_time);    %单位为s
end
if ischar(event_file)
    a=load(event_file);
    Eevent_data=getfield(a,'data');           %得到原来的变量名和数据
%     data=a.DATA;
%     data=a.tempData;
%     data=data/10000000;
%     data=data(1:2:end,:);   % 把2KHz变为1KHz
    clear a
end

scratch_spikeT=scratch_spikeT*Analog_sample_rate;        
current=Eevent_data(:,Scratch_channel);
[z,p,k]=butter(4,40/500);                  %low-pass filtered at 40 Hz using a 4th order Butterworth filter with zero-phase distortion
[sos_var,g]=zp2sos(z,p,k);
Hd=dfilt.df2sos(sos_var,g);
% figure
% plot(current)
% hold on
% plot(filter(Hd,current)+0.5)
current=filter(Hd,current);

%%
event_interval=Analog_sample_rate*0.2;                       %% bout interval 约0.2s
% find time of spikes related to scratching
de=single(diff(scratch_spikeT));
scratchT_off=scratch_spikeT(de>=event_interval);
scratchT=scratch_spikeT(find(de>=event_interval)+1);
scratchT=[scratch_spikeT(1);scratchT]; % start of each event pulse
scratchT_off=[scratchT_off;scratch_spikeT(end)];
x=scratchT-scratchT_off==0;              %排除scratchT和scratchT_off为同一时间点的情况
scratchT(x)=[];
scratchT_off(x)=[];
scratchT=floor(scratchT);
scratchT_off=floor(scratchT_off);
bout_T=scratchT/Analog_sample_rate;
bout_duration=(scratchT_off-scratchT)/Analog_sample_rate;
 clear x
% scratch_bout_bin=zeros(1,8);
% for i=1:8
%     scratch_bout_bin(i)=numel(scratchT(scratchT>=(i-1)*5*60*sample_rate & scratchT<i*5*60*sample_rate));
% end

% find scratching train
scratch_train_interval=Analog_sample_rate*3.5;
scratch_train_start=[];
scratch_train_end=[];
for i=2:length(scratchT)
   if scratchT(i)-scratchT_off(i-1)>scratch_train_interval
        scratch_train_start=[scratch_train_start,scratchT(i)];
        scratch_train_end=[scratch_train_end,scratchT_off(i-1)];
   end
end
scratch_train_start=[scratchT(1),scratch_train_start];
scratch_train_end=[scratch_train_end,scratchT_off(end)];
train_T=scratch_train_start/Analog_sample_rate;
train_duration=(scratch_train_end-scratch_train_start)/Analog_sample_rate;
% scratch_train_start=scratch_train_start([1,2,4,5,8,9,10,12,14,15,17,18,19,20,21]);
% plot((1:length(current))/Analog_sample_rate,current,'k-');                   %该信号太大，作图时可以降低值
% hold on
% for i=1:length(scratchT)
%     plot([scratchT(i)/Analog_sample_rate,scratchT(i)/Analog_sample_rate],[0,0.1],'r-',[scratchT_off(i)/Analog_sample_rate,scratchT_off(i)/Analog_sample_rate],[0.1,0.2],'g-')
% end
% for i=1:length(scratch_train_start)
%        plot(scratch_train_start(i)/Analog_sample_rate,current(scratch_train_start(i)),'ro');
%        plot(scratch_train_end(i)/Analog_sample_rate,current(scratch_train_end(i)),'r*');
% end
% hold off

% pre_scratchbout=0.2*sample_rate;
% post_scratchbout=0.25*sample_rate;
% Baseline_window=1301:2500;   % -2.2s-1s before train onset 
% % train_onset_window=3001:3501;
% post_train_onset_window=4101:4700;       % 0.6-1.2s after train onset
% post_train_offset_window=5801:6800;     % 0.8-1.8s post train
pre_scratchtrain=3.5*Analog_sample_rate;      
post_scratchtrain=5*Analog_sample_rate;
if scratch_train_start(1)<pre_scratchtrain | scratch_train_end(1)<post_scratchtrain               % 排除抓挠开始过快的情况
    scratch_train_start=scratch_train_start(2:end);
    scratch_train_end=scratch_train_end(2:end);
end
if length(current)-scratch_train_end(end)<post_scratchtrain | length(current)-scratch_train_end(end)<(scratch_train_end(end)-scratch_train_start(end))/2              % 排除抓挠结束过快早的情况
    scratch_train_start=scratch_train_start(1:end-1);
    scratch_train_end=scratch_train_end(1:end-1);
end
% motion_T = find_motion( sample_rate,current,scratch_train_start,scratch_train_end );
% motion_Ca=get_motion_Ca(sample_rate,Ca_signal,motion_T,current);
moving_T = find_motion( Analog_sample_rate,current,scratch_train_start,scratch_train_end );
moving_T=moving_T/Analog_sample_rate;

%% scratching train raster plot
if length(scratchT)>1          
  h_figure=figure;
  H_figure=[H_figure, h_figure];
  h1=subplot(1,2,1);
    % current1=current*(max(Ca_signal)-min(Ca_signal))/(max(current)-min(current));
    A=(max(current)-min(current))*0.85;  %用来控制每行间距,越小间隔越近
    for i=1:length(scratch_train_start)
        plot(h1,(-pre_scratchtrain:post_scratchtrain)/Analog_sample_rate,current((scratch_train_start(i)-pre_scratchtrain):(scratch_train_start(i)+post_scratchtrain))+(i-1)*1.1*A,'b-','Linewidth',3);
        hold on
    end
    xlabel(h1,'Scratching train onset (s)', 'fontsize', 30);
    ylabel(h1,'Trains', 'fontsize', 30);
    if i > 10
       YTicklabel=[1,num2cell(10:10:(floor(i/10))*10)];
       YTick=([1,10:10:(floor(i/10))*10]-1)*1.1*A;
    else
        YTicklabel=num2cell(1:i);
        YTick=((1:i)-1)*1.1*A;
    end
%     set(gca,'Fontsize',60,'XTick',[-3.5,0,5],'YTickLabel',{'1','20','40','60'},'YTick',[0 17.38 34.62 52.81]);
    set(h1,'Fontsize',30,'XTick',[-3.5,0,5],'YTickLabel',YTicklabel,'YTick',YTick);
    set(h1,'Linewidth',2.5,'TickDir','out','Ticklength',[0.02,0.025]);
%     set(h1,'position',[0.25,0.2,0.5,0.75]);
    xlim(h1,[-3.5,5]);
    ylim(h1,[1.2*min(current),1.1*A*i]);
    plot(h1,[0,0],[1.2*min(current),1.1*A*i],'k--','Linewidth',2.5);
    box off
%   h_figure;
  h2=subplot(1,2,2);
    for i=1:length(scratch_train_end)
        plot(h2,(-post_scratchtrain:pre_scratchtrain)/Analog_sample_rate,current((scratch_train_end(i)-post_scratchtrain):(scratch_train_end(i)+pre_scratchtrain))+(i-1)*1.1*A,'b-','Linewidth',3);
        hold on
    end
    xlabel('Scratching train offset (s)', 'fontsize', 30);
    ylabel('Trains', 'fontsize', 30);
    set(h2,'Fontsize',30,'XTick',[-5,0,3.5],'YTickLabel',YTicklabel,'YTick',YTick);
    set(h2,'Linewidth',2.5,'TickDir','out','Ticklength',[0.02,0.025]);
    xlim(h2,[-5,3.5]);
    ylim(h2,[1.2*min(current),1.1*A*i]);
    plot(h2,[0,0],[1.2*min(current),1.1*A*i],'k--','Linewidth',2.5);
    box off
    set(h_figure,'color',[1,1,1]);
end

if ~isempty(scratch_train_start)
    Train_onset=scratch_train_start/Analog_sample_rate;
    Train_offset=scratch_train_end/Analog_sample_rate;
else
    Train_onset='-';
    Train_offset='-';
end
