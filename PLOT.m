function line_handle = PLOT(axes_arry, axis_N, f_arry, onset, offset, sample_rate, stimuli, figure_n, Legend, line_handle)
%PLOT Summary of this function goes here    
% axes_arry多个元素表示要heat plot;    
% 当为单个mouse时axis_N 用来控制subplot的位置，0表示不变化，2表示是2个图，对应onset事件，4表示4个subplot，对应onset-offset事件
% line_handle 用于存储线条的handle，便于更新legend    figure_n用于更新组别的线条和legend
    x=(floor(onset*sample_rate):floor(offset*sample_rate))/sample_rate;
    if ~exist('figure_n', 'var')    % 单只mouse的情况
        hold(axes_arry(1));
        for i=1:size(f_arry,1)
        plot(axes_arry(1),x,f_arry(i,:),'color',[179,199,255]/255,'LineWidth',1.5);
        end
    end
    ErrorBar=std(f_arry,1)/sqrt(size(f_arry,1));
    if ~exist('figure_n', 'var') |  figure_n==1   %用来判断是第几个图
%        H1=shadedErrorBar(x,mean(f_arry,1),ErrorBar,{'color','r','LineWidth',2.5},1);
%        set(H1.edge(1,1),'color','w','LineWidth',0.1)
%        set(H1.edge(1,2),'color','w','LineWidth',0.1)
           [hl,hp]=boundedline(axes_arry(1),x,mean(f_arry,1),ErrorBar);
           set(hl,'color','r','LineWidth',3);
           set(hp,'facecolor','r','FaceAlpha',0.15);
           if exist('line_handle', 'var')
               line_handle=[line_handle,hl];
           end
    else
        hold on
        switch figure_n
            case 2
%             H2=shadedErrorBar(x,mean(f_arry,1),ErrorBar,{'color','b','LineWidth',2.5},1);
%             set(H2.edge(1,1),'color','w')
%             set(H2.edge(1,2),'color','w')
           [hl,hp]=boundedline(axes_arry, x,mean(f_arry,1),ErrorBar);
           set(hl,'color','b','LineWidth',3);
           set(hp,'facecolor','b','FaceAlpha',0.15);
           line_handle=[line_handle,hl];
            case 3
            [hl,hp]=boundedline(axes_arry, x,mean(f_arry,1),ErrorBar);
            set(hl,'color','g','LineWidth',3);
            set(hp,'facecolor','g','FaceAlpha',0.15);
            line_handle=[line_handle,hl];
            case 4
            [hl,hp]=boundedline(axes_arry, x,mean(f_arry,1),ErrorBar);
            set(hl,'color','k','LineWidth',3);
            set(hp,'facecolor','k','FaceAlpha',0.15); 
            line_handle=[line_handle,hl];
        end
    end
%     [hl,hp]=boundedline(x,mean(f_arry,1),ErrorBar);
%     set(hl,'color','r','LineWidth',3);
%     set(hp,'facecolor',[255,182,178]/255);
     if ~exist('figure_n', 'var') |  figure_n==1
            M=ceil(max(max(f_arry))/5)*5;
            N=floor(min(min(f_arry))/5)*5;
            plot(axes_arry(1),[0,0],[N,M],'k--','Linewidth',1.5);
            plot(axes_arry(1),[onset,offset],[0,0],'k--','Linewidth',1.5);
            axis(axes_arry(1),[onset,offset,N,M]);
            if strcmp(stimuli,'Onset')
               xlabel(axes_arry(1),'Time from event onset (s)', 'fontsize', 30);
            elseif strcmp(stimuli,'Offset')
               xlabel(axes_arry(1),'Time from event offset (s)', 'fontsize', 30); 
            elseif strcmp(stimuli,'T_moving')
               xlabel(axes_arry(1),'Time from moving onset (s)', 'fontsize', 30); 
            elseif strcmp(stimuli,'Normalization')  
               plot(axes_arry(1),[50,50],[N,M],'k--','Linewidth',1.5);
               xlabel(axes_arry(1),'Normalization time (%)', 'fontsize', 30); 
               set(axes_arry(1),'XTickLabel',{'Onset','Offset'},'XTick',[0 50])
            end
            ylabel(axes_arry(1),'ΔF/F (%)', 'fontsize', 30);
            if axis_N==4  % two subplots
                if strcmp(stimuli,'Onset')
                    set(axes_arry(1),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.11 0.61 0.34 0.36]); 
                elseif strcmp(stimuli,'Offset')
                    set(axes_arry(1),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.58 0.61 0.34 0.36]); 
                end
            elseif  axis_N==2  % two subplots
                set(axes_arry(1),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.115 0.3 0.33 0.48]);              
            elseif  axis_N==0
                set(axes_arry(1),'position',[0.25,0.2,0.5,0.75],'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025]);  %4:
            end
            box off
            set(gcf,'color',[1,1,1]);
            set(axes_arry(1),'Fontsize',30);
     end
if length(axes_arry)>1 % heatplot
    axes(axes_arry(2))
    imagesc(x,1:size(f_arry,1),f_arry);  
    set(axes_arry(2),'YDir','normal');  %上下翻转，这样trial 1在最下方
    hold on
    plot(axes_arry(2),[0,0],[0,size(f_arry,1)+0.5],'k--','LineWidth',1.5);
    if strcmp(stimuli,'Onset')
       xlabel(axes_arry(2),'Time from event onset (s)','fontsize',30);
    elseif strcmp(stimuli,'Offset')
        xlabel(axes_arry(2),'Time from event offset (s)','fontsize',30);
    end
    ylabel(axes_arry(2),'Trials','fontsize',30);
    set(axes_arry(2),'fontsize', 30,'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025]);  %4:3
     if axis_N==4  % two subplots
            if strcmp(stimuli,'Onset')
                set(axes_arry(2),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.11 0.12 0.34 0.36]); 
                colorbar('peer',axes_arry(2),[0.46 0.12 0.011 0.36],'LineWidth',2,'FontSize',20);
                box off
            elseif strcmp(stimuli,'Offset')
                set(axes_arry(2),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.58 0.12 0.34 0.36]); 
                colorbar('peer',axes_arry(2),[0.93 0.12 0.011 0.36],'LineWidth',2,'FontSize',20);
                box off
            end
      elseif  axis_N==2  % two subplots
           set(axes_arry(2),'LineWidth',3,'TickDir','out','TickLength',[0.02 0.025],'Position',[0.55 0.3 0.33 0.48]); 
           colorbar('peer',axes_arry(2),[0.89 0.3 0.014 0.48],'LineWidth',2,'FontSize',20);
           box off                % need to write
      end
%     axis(axes_arry(2),[onset,offset,0.5,size(f_arry,1)+0.5]);
end
    

    
    if exist('figure_n', 'var')
        switch figure_n
                case 1
                  legend(line_handle,Legend{1,:});
                case 2
                  legend(line_handle,Legend{1,:},Legend{2,:});
                case 3
                  legend(line_handle,Legend{1,:},Legend{2,:},Legend{3,:});
                case 4
                  legend(line_handle,Legend{1,:},Legend{2,:},Legend{3,:},Legend{4,:});
        end
        legend('boxoff')
    end
end

