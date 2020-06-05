function [Even_start,Even_stop, H_figure] = VIDEO(Event_file, photometry_start, event_start, event_stop, stimuli_type)
% video score后提取事件的开始和结束
H_figure=[];
a=load(Event_file);
Even_start=a.rawlogframe(char(a.rawlog)==event_start)/a.info.vfpsoi-a.rawlogframe(char(a.rawlog)==photometry_start)/a.info.vfpsoi;  % biting/licking 开始的时间,单位为秒
H_figure=[H_figure,figure]; 
plot(Even_start,ones(size(Even_start)),'ro');
hold on
if  strcmp(stimuli_type,'Onset-offset')
    even_stop=a.rawlogframe(char(a.rawlog)==event_stop)/a.info.vfpsoi-a.rawlogframe(char(a.rawlog)==photometry_start)/a.info.vfpsoi; 
    if length(Even_start)==length(even_stop)
        Even_stop=even_stop;
        plot(Even_stop,ones(size(Even_stop)),'r*');
    else 
        warndlg('Score video开始和结束时间不匹配!!!');
    end
else
    temp{1}='-';
    Even_stop=repmat(temp,size(Even_start));
end
set(gca,'FontSize',40);
xlabel('Time (s)','FontSize',40);
ylabel('Event label','FontSize',40);
box off
set(gca,'position',[0.2,0.2,0.5,0.75],'LineWidth',1.5);
set(gcf,'color',[1,1,1]);

% if ischar(Filename1)
%     [a,b,c]=fileparts(Filename1);
%     a=load(Filename1);
%     data=a.data;
%     clear a
% end
% sample_rate=1000;
% Ca_signal=data(:,Ca_channel)-baseline;                 %system noise
% [z,p,k]=butter(4,2/500);                  %low-pass filtered at 2 Hz using a 4th order Butterworth filter with zero-phase distortion
% [sos_var,g]=zp2sos(z,p,k);
% Hd=dfilt.df2sos(sos_var,g);
% Ca_signal=filter(Hd,Ca_signal);
% 
% Baseline_window=5*sample_rate+1:25*sample_rate;   % 5-25s after recording start
% Event_window=floor(Even_start*sample_rate)-2*sample_rate+1:floor(Even_start*sample_rate)+20*sample_rate;  % event window (-2~20 s)
% drink_window=floor(drink_start*sample_rate)-2*sample_rate+1:floor(drink_start*sample_rate)+20*sample_rate;  % event window (-2~20 s)
% F=(Ca_signal-median(Ca_signal(Baseline_window)))/median(Ca_signal(Baseline_window))*100; %整个trace变成反应百分比
% F_base=F(Baseline_window);
% F_onset=F(Event_window);
% F_drink=F(drink_window);
% figure
% plot((1:length(Ca_signal))/sample_rate,F,'k-');                   %该信号太大，作图时可以降低值
% hold on
% plot(Even_start,F(floor(Even_start*sample_rate)),'ro','Markersize',5);
% plot(drink_start,F(floor(drink_start*sample_rate)),'go','Markersize',5);
% hold off
% train_onset_window=3001:3501;





