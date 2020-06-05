function [ F_onset, F_offset, F_normalization, H_figure, F_moving] = CORRELATE( Ca_file, Ca_ch, Event_file, Event_ch, F_sample_rate, T_onset, T_offset, F_noise, F_base_cal, base_start, base_stop, onset_start, onset_stop, offset_start, offset_stop, event_sample_rate, T_moving)
%�¼���ӫ��仯����Է���
H_figure=[];
%% load Ca file and Event file
a=load(Ca_file);
Ca_data=getfield(a,'data');           %�õ�ԭ���ı�����������
Ca_signal=Ca_data(:,Ca_ch)-F_noise;                 %��ȥsystem noise�� Ca file should be colunm
F_initia=Ca_signal(1:1000);
clear a
[z,p,k]=butter(4,2/500);                  %low-pass filtered at 2 Hz using a 4th order Butterworth filter with zero-phase distortion
[sos_var,g]=zp2sos(z,p,k);
Hd=dfilt.df2sos(sos_var,g);
Ca_signal=filter(Hd,Ca_signal);
Ca_signal(1:1000)=F_initia;   % filter ��ǰ��һ������������
if ~strcmp(Event_ch,'-')   % ����video�¼�
    b=load(Event_file);
    Event_data=getfield(b,'data');           %�õ�ԭ���ı�����������
    Event_data = Event_data(:,Event_ch);
    clear b 
end

% T_onset=T_onset(1);
% T_offset=T_offset(1);
if size(T_onset,2)>1
 T_onset=T_onset'; %Ӧ��Ϊ������
 T_offset=T_offset';
end

%% ��ԭʼ����
h1_figure=figure;
H_figure=[H_figure, h1_figure];
raw_axes=subplot(1,2,1);
if ~strcmp(Event_ch,'-')    % ����video�¼�
    x1 = (1:length(Ca_signal))/F_sample_rate;
    x2 = (1:length(Event_data))/event_sample_rate; 
    [AX,H1,H2] = plotyy(raw_axes,x1,Ca_signal,x2,Event_data,'plot');   
    set(get(AX(1),'Ylabel'),'String','F signal','FontSize',30) 
    set(AX(1),'FontSize',30,'Linewidth',2,'TickDir','out','Ticklength',[0.01 0.025],'XLim',[0,length(Ca_signal)/F_sample_rate],'YLim',[median(Ca_signal)*0.7,max(Ca_signal)*1.2])
%     set(get(AX(2),'Ylabel'),'String','Analog signal','FontSize',30) 
    set(AX(2),'YColor','r','FontSize',30,'Linewidth',2,'TickDir','out','Ticklength',[0.01 0.025],'XLim',[0,length(Event_data)/event_sample_rate],'YLim',[min(Event_data)-(max(Event_data)-min(Event_data))*4,max(Event_data)*1.2])
    set(H1,'LineWidth',1,'Color','b')
    set(H2,'LineWidth',1,'Color','r')
else
    plot((1:length(Ca_signal))/F_sample_rate,Ca_signal,'b-','LineWidth',1);   % video event
    set(raw_axes,'LineWidth',2.5,'TickDir','out','TickLength',[0.02 0.025]);  %4:3
end
hold on
set(raw_axes,'Fontsize',30);
xlabel(raw_axes,'Time (s)','Fontsize',30) 
box off
if strcmp(T_offset(1),'-')    % Onset �¼�
    plot(T_onset,repmat(max(Ca_signal)*1.02,size(T_onset)),'rsquare')   %����Ľ��
else
    t=[T_onset,T_offset,NaN(size(T_onset))];
    x1=reshape(t',1,[]);
    plot(x1,repmat(max(Ca_signal)*1.02,size(x1)),'r-','LineWidth',2.5);
end
xlim(raw_axes,[0,length(Ca_signal)/F_sample_rate]);
ylabel(raw_axes,'F', 'fontsize', 30);

%% example case
h1_figure;
Ca_axes=subplot(1,2,2);
Ca_signal1=Ca_signal;
Ca_signal1=(Ca_signal1-median(Ca_signal1))/median(Ca_signal1)*100;
if ~strcmp(Event_ch,'-')    % ����video�¼�
    x1 = (1:length(Ca_signal1))/F_sample_rate;
    plot(Ca_axes,x1,Ca_signal1,'k-','Linewidth',2.5); 
    set(Ca_axes,'FontSize',30,'TickDir','out','Ticklength',[0.01 0.025])
else
    plot(Ca_axes,(1:length(Ca_signal1))/F_sample_rate,Ca_signal1,'b-','LineWidth',1);   % video event
    set(Ca_axes,'LineWidth',2.5,'TickDir','out','TickLength',[0.02 0.025]);  %4:3
end
hold on
set(gcf,'color',[1,1,1]);
box off
if strcmp(T_offset(1),'-')
    plot(Ca_axes,T_onset,repmat(max(Ca_signal1)*0.8,size(T_onset)),'rsquare')   %����Ľ��
else
    t=[T_onset,T_offset,NaN(size(T_onset))];
    x1=reshape(t',1,[]);
    plot(Ca_axes,x1,repmat(max(Ca_signal1)*0.8,size(x1)),'r-','LineWidth',2.5);
end
set(Ca_axes,'Fontsize',30);
xlabel(Ca_axes,'Time (s)','Fontsize',30) 
ylabel(Ca_axes,'��F/F (%)', 'fontsize', 30);
xlim(Ca_axes,[0,length(Ca_signal1)/F_sample_rate]);

%% ����onsetƽ����Ӧ����ͼ
Ca_signal=Ca_signal';  %��Ϊ����������Ȼ���δ̼������ûᱨ�� why???!!!
T_onset=floor(T_onset*F_sample_rate);   
T_onset_arry=repmat(T_onset,size(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate))); %��T_onset���ƣ������ҳ�����event��ص�onset_window
onset_arry=repmat(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate),size(T_onset));  %��onset_window���ƣ������ҳ�����event��ص�onset_window
f_onset=Ca_signal(T_onset_arry+onset_arry);   % ÿ��onsetǰ���fֵ
if strcmp(F_base_cal,'single F')  % ������¼���ȡͬһ��F0
    if base_start>0 & base_stop>0   
        F0=median(Ca_signal(floor(base_start*F_sample_rate):floor(base_stop*F_sample_rate))); 
        F0_onset_arry=F0;
    else
        warndlg('Wrong baseline peirod!!!')  
    end
else
    T_base_arry=repmat(T_onset,size(floor(base_start*F_sample_rate):floor(base_stop*F_sample_rate))); %��T_onset���ƣ������ҳ�����event��ص�base_window
    base_arry=repmat(floor(base_start*F_sample_rate):floor(base_stop*F_sample_rate),size(T_onset));  %��onset_window���ƣ������ҳ�����event��ص�base_window
    f_base=Ca_signal(T_base_arry+base_arry);   % ÿ��baseline window��fֵ
    F0=median(f_base,2);   % ÿ�δ̼���F0
    F0_onset_arry=repmat(F0,size(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate)));
end
f_onset=(f_onset-F0_onset_arry)./F0_onset_arry*100;
F_onset=mean(f_onset,1); 
figure_average=figure;
H_figure=[H_figure, figure_average];
if ~(strcmp(T_offset(1),'-')) %��Onset-offset����
    axes_onset_line=subplot(2,2,1);
    axes_onset_heat=subplot(2,2,3);
    PLOT([axes_onset_line, axes_onset_heat],4,f_onset, onset_start, onset_stop, F_sample_rate, 'Onset')
else
    axes_onset_line=subplot(1,2,1);
    axes_onset_heat=subplot(1,2,2);
    PLOT([axes_onset_line, axes_onset_heat],2,f_onset, onset_start, onset_stop, F_sample_rate, 'Onset')
end


%% ����offsetƽ����Ӧ����ͼ
if ~(strcmp(T_offset(1),'-')) %��Onset-offset����
   T_offset=floor(T_offset*F_sample_rate);   %Ӧ��Ϊ������
   T_offset_arry=repmat(T_offset,size(floor(offset_start*F_sample_rate):floor(offset_stop*F_sample_rate))); %��T_offset���ƣ������ҳ�����event��ص�offset_window
   offset_arry=repmat(floor(offset_start*F_sample_rate):floor(offset_stop*F_sample_rate),size(T_offset));  %��offset_window���ƣ������ҳ�����event��ص�offset_window
   f_offset=Ca_signal(T_offset_arry+offset_arry);   % ÿ��offsetǰ���fֵ
   F0_offset_arry=repmat(F0,size(floor(offset_start*F_sample_rate):floor(offset_stop*F_sample_rate)));
   f_offset=(f_offset-F0_offset_arry)./F0_offset_arry*100;   % ÿ��trial��offset��Ӧ
   F_offset=mean(f_offset,1);   %���F_offset
   figure_average;
   axes_offset_line=subplot(2,2,2);
   axes_offset_heat=subplot(2,2,4);
   PLOT([axes_offset_line, axes_offset_heat],4,f_offset, offset_start, offset_stop, F_sample_rate, 'Offset')
%    PLOT( f_offset, offset_start, offset_stop, F_sample_rate, 'Offset')
  % normalization
  N_edege=10;  % ǰ����ȡ20%
  F_nor_array=zeros(length(T_onset),N_edege*2+50); 
  T_duration=T_offset-T_onset;
  for i=1:length(T_onset)
      time_bin=T_duration(i)/50;   %ÿ�ݵ�ʱ��
      for j=0:N_edege*2+50
         time_temp=floor(T_onset(i)+(j-N_edege-1)*time_bin):floor(T_onset(i)+(j-N_edege)*time_bin); % ÿ�����ľ���ʱ��
         F_nor_array(i,j+1)=(mean(Ca_signal(time_temp))-F0(i))/F0(i)*100;   % F0ʼ��Ϊbaseline window����λֵ
      end
  end
   F_normalization=mean(F_nor_array,1);   %F_normalization
   H_figure=[H_figure, figure];
   axes_nor=axes;
   PLOT(axes_nor,0,F_nor_array, -10, 60, 1, 'Normalization')
      if exist('T_moving','var')    % Scratching event
          if ~iscolumn(T_moving)
             T_moving=T_moving'; %Ӧ��Ϊ������
          end
          T_moving=floor(T_moving*F_sample_rate);   
          T_moving_arry=repmat(T_moving,size(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate))); 
          moving_onset_arry=repmat(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate),size(T_moving));  
          f_moving_onset=Ca_signal(T_moving_arry+moving_onset_arry);   % ÿ��onsetǰ���fֵ
          T_base_onset_arry=repmat(T_moving,size(floor(base_start*F_sample_rate):floor(base_stop*F_sample_rate))); 
          base_arry=repmat(floor(base_start*F_sample_rate):floor(base_stop*F_sample_rate),size(T_moving)); 
          f_base=Ca_signal(T_base_onset_arry+base_arry);   % ÿ��baseline window��fֵ
          F0=median(f_base,2);   % ÿ�δ̼���F0
          F0_arry=repmat(F0,size(floor(onset_start*F_sample_rate):floor(onset_stop*F_sample_rate)));
          f_moving_onset=(f_moving_onset-F0_arry)./F0_arry*100;
          H_figure=[H_figure, figure];
          axes_moving=axes;
          PLOT(axes_moving,0, f_moving_onset, onset_start, onset_stop, F_sample_rate, 'T_moving')
          F_moving=mean(f_moving_onset,1); 
      end
else
    temp{1}='-';
            F_offset=repmat(temp,size(F_onset));  %���F_offset
            F_normalization=repmat(temp,size(F_onset));  %F_normalization
end
