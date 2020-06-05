function [T_onset, T_offset, H_figure] = ANALOG( Ca_file, event_ch, stimuli_type, sample_rate, water_type,I)
% 计算模拟信号通道记录的刺激事件，如电极、夹尾巴和hotplate等过程中打的点
%  n_file为可选参数，有输入时表示用来分选事件。事件类型可以自己定义
H_figure=[];
a=load(Ca_file);
data=a.data; 
analog=double(data(:,event_ch));
% Ca_signal=double(data(:,Ca_channel)-baseline);                 %system noise
% Ca_signal=Ca_signal';
% [z,p,k]=butter(4,2/500);                  %low-pass filtered at 2 Hz using a 4th order Butterworth filter with zero-phase distortion
% [sos_var,g]=zp2sos(z,p,k);
% Hd=dfilt.df2sos(sos_var,g);
% Ca_signal=filter(Hd,Ca_signal);
thresh=mean(analog)+std(analog)*1;
% [pks,peak_T]=findpeaks(analog,'minpeakheight',thresh);
x=double(analog>thresh);
analog_T_start=find(diff(x)==1)+1;
analog_T_end=find(diff(x)==-1);
% analog_T_start=[peak_T(1);peak_T(find(diff(peak_T)>1000)+1)];
% analog_T_end=[peak_T(find(diff(peak_T)>1000));peak_T(end)];
% analog_T_start([4])=[];   % 去掉无效的电极trial，即mice没有行为表现的trail
% analog_T_end([4])=[];
% M1=median(Ca_signal(2*sample_rate:20*sample_rate));
H_figure=[H_figure,figure];
plot((1:length(analog))/sample_rate,analog,'k-','LineWidth',1.5);
hold on
for i=1:length(analog_T_start)
plot([analog_T_start(i)/sample_rate,analog_T_end(i)/sample_rate],[max(analog)*1.1,max(analog)*1.1],'r-','LineWidth',2);
end
set(gca,'FontSize',40);
xlabel('Time (s)','FontSize',40);
ylabel('Analog signal','FontSize',40);
box off
set(gca,'position',[0.2,0.2,0.5,0.75],'LineWidth',1.5);
set(gcf,'color',[1,1,1]);

if strcmp(stimuli_type,'Onset')
    T_onset=analog_T_start/sample_rate;
    if exist ('water_type','var') & exist ('I','var')    % n_file 和 I 输入存在
        a=load('J:\DATA\NAc dopamine signal\core\20181109 WT DA sensor 4.4 NAc core water\stimuli_order.mat');
        a=a.stimuli_order;
        b=char(a(I,:));
        Index=strfind(b',water_type);   %第I只mouse，给水类型为‘water_type’
        T_onset=T_onset(Index);
    end
    temp{1}='-';
    T_offset=repmat(temp,size(T_onset));
    plot(T_onset,max(analog)*1.2,'ro','LineWidth',2);
elseif strcmp(stimuli_type,'Onset-offset')
  if exist ('water_type','var') & exist ('I','var')    % n_file 和 I 输入存在,认为onset和offset记录在同一个pulse中
      a=load('D:\行为\fiber photometry\CM_WT\20181207_hotwater\20181207_hotwater_52\fail.mat');
      event_fail=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
      Index=cell2mat(event_fail(I,:));
      analog_T_start(Index)=[];
      analog_T_end(Index)=[];
      T_onset=analog_T_start/sample_rate;
      T_offset=analog_T_end/sample_rate;
      plot(T_onset,max(analog)*1.2,'ro');
      plot(T_offset,max(analog)*1.2,'r*');
  else
   if (analog_T_end(1)-analog_T_start(1))/sample_rate>1.5        % pulse刺激长短大于1.5s,认为onset和offset记录在同一个pulse中
     T_onset=analog_T_start/sample_rate;
     T_offset=analog_T_end/sample_rate;
     plot(T_onset,max(analog)*1.2,'ro');
     plot(T_offset,max(analog)*1.2,'r*');
   else
      if mod(length(analog_T_start),2)==0
        T_onset=analog_T_start(1:2:end)/sample_rate;
        T_offset=analog_T_start(2:2:end)/sample_rate;
        plot(T_onset,max(analog)*1.2,'ro');
        plot(T_offset,max(analog)*1.2,'r*');
      else
        warndlg('刺激时间有误!!!') 
      end
   end
  end
end
% Ca_shock=[];
% figure
% for i=1:length(analog_T_start)
%     M=median(Ca_signal(analog_T_start(i)-5*sample_rate:analog_T_start(i)));
%     Ca_shock=[Ca_shock;(Ca_signal(analog_T_start(i)-5*sample_rate:analog_T_start(i)+5*sample_rate)-M)/M*100]; 
%     plot((-5*sample_rate:5*sample_rate)/sample_rate,Ca_shock(i,:));
%     hold on
% end
% plot((-5*sample_rate:5*sample_rate)/sample_rate,mean(Ca_shock,1));
% Ca_shock_average=mean(Ca_shock,1);


