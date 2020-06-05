

function varargout = Photometry_event(varargin)
% PHOTOMETRY_EVENT MATLAB code for Photometry_event.fig
%      PHOTOMETRY_EVENT, by itself, creates a new PHOTOMETRY_EVENT or raises the existing
%      singleton*.
%
%      H = PHOTOMETRY_EVENT returns the handle to a new PHOTOMETRY_EVENT or the handle to
%      the existing singleton*.
%
%      PHOTOMETRY_EVENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHOTOMETRY_EVENT.M with the given input arguments.
%
%      PHOTOMETRY_EVENT('Property','Value',...) creates a new PHOTOMETRY_EVENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Photometry_event_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Photometry_event_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Photometry_event

% Last Modified by GUIDE v2.5 24-Nov-2018 17:11:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Photometry_event_OpeningFcn, ...
                   'gui_OutputFcn',  @Photometry_event_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Photometry_event is made visible.
function Photometry_event_OpeningFcn(hObject, eventdata, handles, varargin)
% try to load previous GUI parameter
handles.output = hObject;
tic
try
    load SETUP.mat
    set(handles.F_sample_rate,'string',DATA.Sample_rate);
    set(handles.base_ch,'string',DATA.base_ch);
    set(handles.F_noise,'string',DATA.F_base);
    set(handles.event_type,'value',DATA.event_type);
    set(handles.stimuli_type,'value',DATA.stimuli_type);
    set(handles.Ca_ch,'string',DATA.Ca_ch);
    set(handles.Ca_folder,'string',DATA.Ca_folder);
    set(handles.event_folder,'string',DATA.event_folder);
    set(handles.analog_ch,'string',DATA.analog_ch);
    set(handles.Record_start,'string',DATA.Record_start);
    set(handles.event_start,'string',DATA.event_start);
    set(handles.event_stop,'string',DATA.event_stop);
    set(handles.scratch_ch,'string',DATA.scratch_ch);
    set(handles.Base_Cal,'value',DATA.Base_Cal);
    set(handles.Base_start,'string',DATA.Base_start);
    set(handles.Base_stop,'string',DATA.Base_stop);
    set(handles.Onset_start,'string',DATA.Onset_start);
    set(handles.Onset_stop,'string',DATA.Onset_stop);
    set(handles.Offset_start,'string',DATA.Offset_start);
    set(handles.Offset_stop,'string',DATA.Offset_stop);
catch
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Photometry_event wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Photometry_event_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function Ca_folder_Callback(hObject, eventdata, handles)
% hObject    handle to Ca_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ca_folder as text
%        str2double(get(hObject,'String')) returns contents of Ca_folder as a double


% --- Executes during object creation, after setting all properties.
function Ca_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ca_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stimuli_type.
function stimuli_type_Callback(hObject, eventdata, handles)
% hObject    handle to stimuli_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.stimuli_type,'value')
    case 1
        set(handles.Offset_start,'Enable','off')
        set(handles.Offset_stop,'Enable','off')
    case 2
        set(handles.Offset_start,'Enable','on')
        set(handles.Offset_stop,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function stimuli_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimuli_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Base_Cal.
function Base_Cal_Callback(hObject, eventdata, handles)
% hObject    handle to Base_Cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.Base_Cal,'value')
    case 2
      warndlg('You set the same F0 for all events!!!')  
end


% --- Executes during object creation, after setting all properties.
function Base_Cal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Base_Cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Base_start_Callback(hObject, eventdata, handles)
% hObject    handle to Base_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Base_start as text
%        str2double(get(hObject,'String')) returns contents of Base_start as a double


% --- Executes during object creation, after setting all properties.
function Base_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Base_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Base_stop_Callback(hObject, eventdata, handles)
% hObject    handle to Base_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Base_stop as text
%        str2double(get(hObject,'String')) returns contents of Base_stop as a double


% --- Executes during object creation, after setting all properties.
function Base_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Base_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Onset_start_Callback(hObject, eventdata, handles)
% hObject    handle to Onset_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Onset_start as text
%        str2double(get(hObject,'String')) returns contents of Onset_start as a double


% --- Executes during object creation, after setting all properties.
function Onset_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Onset_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Onset_stop_Callback(hObject, eventdata, handles)
% hObject    handle to Onset_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Onset_stop as text
%        str2double(get(hObject,'String')) returns contents of Onset_stop as a double


% --- Executes during object creation, after setting all properties.
function Onset_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Onset_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RUN.
function RUN_Callback(hObject, eventdata, handles)
% hObject    handle to RUN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cal_FILE Result_FILE H_figure
if ~exist('H_figure','var')
    H_figure=[];
end
if isempty(Cal_FILE)
   [cal_file, cal_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
   a=load([cal_path, cal_file]);
   Cal_FILE=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
end
if ~isempty(Cal_FILE)
    Result_FILE=Cal_FILE;
    Result_FILE{1,size(Cal_FILE,2)+1}='F_onset';  % 存储onset的平均反应
    Result_FILE{1,size(Cal_FILE,2)+2}='F_offset'; % 存储offset的平均反应
    Result_FILE{1,size(Cal_FILE,2)+3}='F_normalization'; % 存储onset-offset事件中的平均反应
     if strfind('Scratch',Cal_FILE{2,4})
        Result_FILE{1,size(Cal_FILE,2)+4}='F_moving'; 
        Result_FILE{1,size(Cal_FILE,2)+5}='Bout_time'; 
        Result_FILE{1,size(Cal_FILE,2)+6}='Train_time'; 
        Result_FILE{1,size(Cal_FILE,2)+7}='Bout_duration'; 
        Result_FILE{1,size(Cal_FILE,2)+8}='Train_duration'; 
     end
     for i=2:size(Cal_FILE,1)
            if exist('H_temp','var')
               close(H_temp)
            end
            temp=Extract_cell_unit( Cal_FILE,'Event_type',2,2);
            switch temp{1}  %计算时间的开始和结束
                case 'Analog'
                   [T_onset, T_offset, h_figure1]=ANALOG(Cal_FILE{i,2},Cal_FILE{i,6},Cal_FILE{i,4},Cal_FILE{i,16},'SHOCK',i-1);   %返回事件的开始和（或）结束点，单位为s
%                     [T_onset, T_offset, h_figure1]=ANALOG(Cal_FILE{i,2},Cal_FILE{i,6},Cal_FILE{i,4},Cal_FILE{i,16});   %返回事件的开始和（或）结束点，单位为s
                case 'Video'
                    [T_onset, T_offset, h_figure1]=VIDEO(Cal_FILE{i,2},Cal_FILE{i,6},Cal_FILE{i,7},Cal_FILE{i,8},Cal_FILE{i,4});
                case 'Scratch'
                    [T_onset, T_offset, bout_T, train_T, bout_duration, train_duration, moving_T, h_figure1]=SCRATCH(Cal_FILE{i,2},Cal_FILE{i,7},Cal_FILE{i,3},Cal_FILE{i,17});  %返回scratcing train的开始和（或）结束点，单位为s
            end
            H_temp=h_figure1;
          if get(handles.check_behavior,'value')==0         % 不是仅仅看行为
                if ~isempty(T_onset)
                    switch temp{1} 
                        case 'Analog' 
                            [F_onset, F_offset, F_normalization, h_figure2]=CORRELATE(Cal_FILE{i,1},Cal_FILE{i,5},Cal_FILE{i,2},Cal_FILE{i,6},Cal_FILE{i,15},T_onset,T_offset,Cal_FILE{i,7},Cal_FILE{i,8},Cal_FILE{i,9},Cal_FILE{i,10},Cal_FILE{i,11},Cal_FILE{i,12},Cal_FILE{i,13},Cal_FILE{i,14},Cal_FILE{i,16});  %计算事件开始和结束时的反应
                        case 'Scratch'
                            [F_onset, F_offset, F_normalization, h_figure2, F_moving]=CORRELATE(Cal_FILE{i,1},Cal_FILE{i,6},Cal_FILE{i,2},Cal_FILE{i,7},Cal_FILE{i,16},T_onset,T_offset,Cal_FILE{i,8},Cal_FILE{i,9},Cal_FILE{i,10},Cal_FILE{i,11},Cal_FILE{i,12},Cal_FILE{i,13},Cal_FILE{i,14},Cal_FILE{i,15},Cal_FILE{i,17},moving_T);
                        case 'Video'
                            [F_onset, F_offset, F_normalization, h_figure2]=CORRELATE(Cal_FILE{i,1},Cal_FILE{i,5},Cal_FILE{i,2},'-',Cal_FILE{i,17},T_onset,T_offset,Cal_FILE{i,9},Cal_FILE{i,10},Cal_FILE{i,11},Cal_FILE{i,12},Cal_FILE{i,13},Cal_FILE{i,14},Cal_FILE{i,15},Cal_FILE{i,16});
                    end
                        Result_FILE{i,size(Cal_FILE,2)+1}=F_onset;  
                        Result_FILE{i,size(Cal_FILE,2)+2}=F_offset;  
                        Result_FILE{i,size(Cal_FILE,2)+3}=F_normalization; 
                        if strfind('Scratch',Cal_FILE{2,4})
                             Result_FILE{i,size(Cal_FILE,2)+4}=F_moving; 
                             Result_FILE{i,size(Cal_FILE,2)+5}=bout_T; 
                             Result_FILE{i,size(Cal_FILE,2)+6}=train_T'; 
                             Result_FILE{i,size(Cal_FILE,2)+7}=bout_duration; 
                             Result_FILE{i,size(Cal_FILE,2)+8}=train_duration'; 
                        end
                        H_temp=[H_temp,h_figure2];
                end
          else
                  Result_FILE{i,size(Cal_FILE,2)+1}='-';  
                  Result_FILE{i,size(Cal_FILE,2)+2}='-';  
                  Result_FILE{i,size(Cal_FILE,2)+3}='-';
                  Result_FILE{i,size(Cal_FILE,2)+4}='-'; 
                  Result_FILE{i,size(Cal_FILE,2)+5}=bout_T; 
                  Result_FILE{i,size(Cal_FILE,2)+6}=train_T'; 
                  Result_FILE{i,size(Cal_FILE,2)+7}=bout_duration; 
                  Result_FILE{i,size(Cal_FILE,2)+8}=train_duration'; 
          end
     end 
      H_figure=[H_figure,H_temp];  
end

% --- Executes on button press in PLOT.
function PLOT_Callback(hObject, eventdata, handles)
% hObject    handle to PLOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Result_FILE 
if isempty(Result_FILE)
   [cal_file, cal_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
   a=load([cal_path, cal_file]);
   Result_FILE=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
end
f_onset=cell2mat(Extract_cell_unit( Result_FILE, 'F_onset', 2 ));   % 倒数第3列为onset response
onset_start=cell2mat(Extract_cell_unit( Result_FILE, 'onset_start', 2, 2 ));
onset_stop=cell2mat(Extract_cell_unit( Result_FILE, 'onset_stop', 2, 2 ));
sample_rate=cell2mat(Extract_cell_unit( Result_FILE, 'F_sample_rate', 2, 2 ));
figure_average=figure;
if strcmp(Extract_cell_unit( Result_FILE,'Stimuli_type',2),'Onset-offset') %是Onset-offset类型
    axes_onset_line=subplot(2,2,1);
    axes_onset_heat=subplot(2,2,3);
    PLOT([axes_onset_line, axes_onset_heat],4, f_onset, onset_start, onset_stop, sample_rate, 'Onset');
else
    axes_onset_line=subplot(1,2,1);
    axes_onset_heat=subplot(1,2,2);
    PLOT([axes_onset_line, axes_onset_heat],2, f_onset, onset_start, onset_stop, sample_rate, 'Onset');
end

if strcmp(Extract_cell_unit( Result_FILE,'Stimuli_type',2),'Onset-offset') %是Onset-offset类型
%    figure
   f_offset=cell2mat(Extract_cell_unit( Result_FILE, 'F_offset', 2));       % 倒数第2列为offset response
   f_normalization=cell2mat(Extract_cell_unit( Result_FILE, 'F_normalization', 2));       % 最后一列为normalization response
   offset_start=cell2mat(Extract_cell_unit( Result_FILE, 'offset_start', 2, 2 ));
   offset_stop=cell2mat(Extract_cell_unit( Result_FILE, 'offset_stop', 2, 2 ));
   figure_average;
   axes_offset_line=subplot(2,2,2);
   axes_offset_heat=subplot(2,2,4);
   PLOT([axes_offset_line, axes_offset_heat],4,f_offset, offset_start, offset_stop, sample_rate, 'Offset');
   figure
   axes_nor=axes;
   PLOT(axes_nor,0, f_normalization, -10, 60, 1, 'Normalization');
   
   if strcmp(Extract_cell_unit( Result_FILE,'Event_type',2,2),'Scratch')
       F_moving=cell2mat(Extract_cell_unit( Result_FILE, 'F_moving', 2 ));   % 倒数第3列为onset response
       figure
       axes_moving=axes;
       PLOT(axes_moving,0, F_moving, onset_start, onset_stop, sample_rate, 'T_moving');
   end
end

% --- Executes on button press in Save_result.
function Save_result_Callback(hObject, eventdata, handles)
% hObject    handle to Save_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Result_FILE
[FILENAME, PATHNAME] = uiputfile('.mat', 'Save as',char(get(handles.Ca_folder,'String')));
save([PATHNAME,FILENAME],'Result_FILE');


function Ca_ch_Callback(hObject, eventdata, handles)
% hObject    handle to Ca_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ca_ch as text
%        str2double(get(hObject,'String')) returns contents of Ca_ch as a double


% --- Executes during object creation, after setting all properties.
function Ca_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ca_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Event_ch_Callback(hObject, eventdata, handles)
% hObject    handle to Event_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Event_ch as text
%        str2double(get(hObject,'String')) returns contents of Event_ch as a double


% --- Executes during object creation, after setting all properties.
function Event_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Event_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_noise_Callback(hObject, eventdata, handles)
% hObject    handle to F_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_noise as text
%        str2double(get(hObject,'String')) returns contents of F_noise as a double


% --- Executes during object creation, after setting all properties.
function F_noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to F_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of F_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function F_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% save GUI parameter before exit
DATA.Sample_rate = get(handles.F_sample_rate,'string');
DATA.base_ch = get(handles.base_ch,'string');
DATA.F_base = get(handles.F_noise,'string');
DATA.event_type = get(handles.event_type,'value');
DATA.stimuli_type = get(handles.stimuli_type,'value');
DATA.Ca_ch = get(handles.Ca_ch,'string');
DATA.Ca_folder = get(handles.Ca_folder,'string');
DATA.event_folder = get(handles.event_folder,'string');
DATA.analog_ch = get(handles.analog_ch,'string');
DATA.Record_start = get(handles.Record_start,'string');
DATA.event_start = get(handles.event_start,'string');
DATA.event_stop = get(handles.event_stop,'string');
DATA.scratch_ch = get(handles.scratch_ch,'string');
DATA.Base_Cal = get(handles.Base_Cal,'value');
DATA.Base_start = get(handles.Base_start,'string');
DATA.Base_stop = get(handles.Base_stop,'string');
DATA.Onset_start = get(handles.Onset_start,'string');
DATA.Onset_stop = get(handles.Onset_stop,'string');
DATA.Offset_start = get(handles.Offset_start,'string');
DATA.Offset_stop = get(handles.Offset_stop,'string');
save SETUP DATA;



function Offset_start_Callback(hObject, eventdata, handles)
% hObject    handle to Offset_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Offset_start as text
%        str2double(get(hObject,'String')) returns contents of Offset_start as a double


% --- Executes during object creation, after setting all properties.
function Offset_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Offset_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Offset_stop_Callback(hObject, eventdata, handles)
% hObject    handle to Offset_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Offset_stop as text
%        str2double(get(hObject,'String')) returns contents of Offset_stop as a double


% --- Executes during object creation, after setting all properties.
function Offset_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Offset_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Record_start_Callback(hObject, eventdata, handles)
% hObject    handle to Record_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Record_start as text
%        str2double(get(hObject,'String')) returns contents of Record_start as a double


% --- Executes during object creation, after setting all properties.
function Record_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Record_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function event_start_Callback(hObject, eventdata, handles)
% hObject    handle to event_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_start as text
%        str2double(get(hObject,'String')) returns contents of event_start as a double


% --- Executes during object creation, after setting all properties.
function event_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function event_stop_Callback(hObject, eventdata, handles)
% hObject    handle to event_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_stop as text
%        str2double(get(hObject,'String')) returns contents of event_stop as a double


% --- Executes during object creation, after setting all properties.
function event_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function event_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ca_file, ca_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
ca_file=[ca_path, ca_file];
if ischar(ca_file)
    a=load(ca_file);
    Ca_data=getfield(a,'data');           %得到原来的变量名和数据
    base=mean(Ca_data(:,str2num(get(handles.base_ch,'String'))));
    set(handles.F_noise,'String',base);
end

function base_ch_Callback(hObject, eventdata, handles)
% hObject    handle to base_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of base_ch as text
%        str2double(get(hObject,'String')) returns contents of base_ch as a double


% --- Executes during object creation, after setting all properties.
function base_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to base_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function event_folder_Callback(hObject, eventdata, handles)
% hObject    handle to event_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_folder as text
%        str2double(get(hObject,'String')) returns contents of event_folder as a double


% --- Executes during object creation, after setting all properties.
function event_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function analog_ch_Callback(hObject, eventdata, handles)
% hObject    handle to analog_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of analog_ch as text
%        str2double(get(hObject,'String')) returns contents of analog_ch as a double


% --- Executes during object creation, after setting all properties.
function analog_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to analog_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scratch_ch_Callback(hObject, eventdata, handles)
% hObject    handle to scratch_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scratch_ch as text
%        str2double(get(hObject,'String')) returns contents of scratch_ch as a double


% --- Executes during object creation, after setting all properties.
function scratch_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scratch_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_mouse.
function add_mouse_Callback(hObject, eventdata, handles)
% hObject    handle to add_mouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% input file for calcium and stimuli event
global Cal_FILE
if isempty(Cal_FILE)
  if ismember(get(handles.event_type,'value'),1)  % event is Analog
     Cal_FILE={'Ca_file','Event_file','Event_type','Stimuli_type','F_ch','Event_ch','F_noise','F_base_cal','base_start','base_stop','onset_start','onset_stop','offset_start','offset_stop','F_sample_rate','Analog_sample_rate'};  % 初始化
  elseif ismember(get(handles.event_type,'value'),2)  % event is Video 
     Cal_FILE={'Ca_file','Event_file','Event_type','Stimuli_type','F_ch','Record_onset_labe','Eve_onset_label','Eve_off_label','F_noise','F_base_cal','base_start','base_stop','onset_start','onset_stop','offset_start','offset_stop','F_sample_rate'}; % after video score
  else
     Cal_FILE={'Ca_file','Event_file','INFO_file','Event_type','Stimuli_type','F_ch','Event_ch','F_noise','F_base_cal','base_start','base_stop','onset_start','onset_stop','offset_start','offset_stop','F_sample_rate','Analog_sample_rate'};  % 初始化 
  end
end

% 获取共同参数
[ca_file, ca_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
if ischar(ca_file)
    ca_file=[ca_path, ca_file];
end
[event_file, event_path] = uigetfile('*.mat','Open Event file','MultiSelect','off',char(get(handles.event_folder,'String'))); %获取文件名
if ischar(event_file)
    event_file=[event_path, event_file];
end
event_type=get_popuvalue(get(handles.event_type,'String'),get(handles.event_type,'value'));
stimuli_type=get_popuvalue(get(handles.stimuli_type,'String'),get(handles.stimuli_type,'value'));
f_ch=str2num(get(handles.Ca_ch,'String'));
f_noise=str2num(get(handles.F_noise,'String'));
f_base_cal=get_popuvalue(get(handles.Base_Cal,'String'),get(handles.Base_Cal,'value'));
base_start=str2num(get(handles.Base_start,'String'));
base_stop=str2num(get(handles.Base_stop,'String'));
onset_start=str2num(get(handles.Onset_start,'String'));
onset_stop=str2num(get(handles.Onset_stop,'String'));
F_sample_rate=str2num(get(handles.F_sample_rate,'String'));
if strcmp(stimuli_type,'Onset')
            offset_start='-';
            offset_stop='-';
else
            offset_start=str2num(get(handles.Offset_start,'String'));
            offset_stop=str2num(get(handles.Offset_stop,'String'));
end

switch get(handles.event_type,'value')
    case 1
        event_ch=str2num(get(handles.analog_ch,'String'));
        Analog_sample_rate=str2num(get(handles.event_sample_rate,'String'));
        Cal_FILE=[Cal_FILE;[ca_file,event_file,event_type,stimuli_type,f_ch,event_ch,f_noise,f_base_cal,base_start,base_stop,onset_start,onset_stop,offset_start,offset_stop,F_sample_rate,Analog_sample_rate]];
    case 2
         record_onset_label=get(handles.Record_start,'String');
         eve_onset_label=get(handles.event_start,'String');
         if strcmp(stimuli_type,'Onset')
               eve_off_label='-';
         else
               eve_off_label=get(handles.event_stop,'String');
         end
         Cal_FILE=[Cal_FILE;[ca_file,event_file,event_type,stimuli_type,f_ch,record_onset_label,eve_onset_label,eve_off_label,f_noise,f_base_cal,base_start,base_stop,onset_start,onset_stop,offset_start,offset_stop,F_sample_rate]];
    case 3
        event_ch=str2num(get(handles.scratch_ch,'String'));
        Analog_sample_rate=str2num(get(handles.event_sample_rate,'String'));
        [INFO_file, INFO_path] = uigetfile('*.mat','Open Sratch_INFO file','MultiSelect','off',char(get(handles.Scratch_INFO_folder,'String'))); %获取文件名
        if ischar(INFO_file)
            INFO_file=[INFO_path, INFO_file];
        end
        Cal_FILE=[Cal_FILE;[ca_file,event_file,INFO_file,event_type,stimuli_type,f_ch,event_ch,f_noise,f_base_cal,base_start,base_stop,onset_start,onset_stop,offset_start,offset_stop,F_sample_rate,Analog_sample_rate]];
end


% --- Executes on button press in save_file.
function save_file_Callback(hObject, eventdata, handles)
% hObject    handle to save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cal_FILE
[FILENAME, PATHNAME] = uiputfile('.mat', 'Save as',char(get(handles.Ca_folder,'String')));
save([PATHNAME,FILENAME],'Cal_FILE');

% --- Executes on button press in clear_data.
function clear_data_Callback(hObject, eventdata, handles)
% hObject    handle to clear_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
clear all
clc



% --- Executes on selection change in event_type.
function event_type_Callback(hObject, eventdata, handles)
% hObject    handle to event_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.event_type,'value')
    case 1
        set(handles.stimuli_type,'Enable','on')
    case 2
        set(handles.stimuli_type,'Enable','on')
    case 3
        set(handles.stimuli_type,'value',2)
        set(handles.stimuli_type,'Enable','Off')
        set(handles.Offset_start,'Enable','On')
        set(handles.Offset_stop,'Enable','On')
        set(handles.event_folder,'Enable','on')
end
% Hints: contents = cellstr(get(hObject,'String')) returns event_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from event_type



function response_start_Callback(hObject, eventdata, handles)
% hObject    handle to response_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of response_start as text
%        str2double(get(hObject,'String')) returns contents of response_start as a double


% --- Executes during object creation, after setting all properties.
function response_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to response_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function response_stop_Callback(hObject, eventdata, handles)
% hObject    handle to response_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of response_stop as text
%        str2double(get(hObject,'String')) returns contents of response_stop as a double


% --- Executes during object creation, after setting all properties.
function response_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to response_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cal_period.
function cal_period_Callback(hObject, eventdata, handles)
% hObject    handle to cal_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cal_period contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cal_period


% --- Executes during object creation, after setting all properties.
function cal_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cal_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Quantify.
function Quantify_Callback(hObject, eventdata, handles)
% hObject    handle to Quantify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cal_file, cal_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
if ischar(cal_file)
    a=load([cal_path, cal_file]);
    Result_FILE=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
    t_start=str2num(get(handles.response_start,'String'));
    t_stop=str2num(get(handles.response_stop,'String'));
    Onset_start=cell2mat(Extract_cell_unit(Result_FILE,'onset_start',2,2));
    Onset_stop=cell2mat(Extract_cell_unit(Result_FILE,'onset_stop',2,2));
    Offset_start=cell2mat(Extract_cell_unit(Result_FILE,'offset_start',2,2));
    Offset_stop=cell2mat(Extract_cell_unit(Result_FILE,'offset_stop',2,2));
    Sample_rate=cell2mat(Extract_cell_unit(Result_FILE,'F_sample_rate',2,2));
    if ismember(get(handles.cal_period,'value'),[1,2])   % 计算b.s 或 onset window
        if t_stop>t_start  &  t_start>=Onset_start  &  t_stop<=Onset_stop
            f_onset=cell2mat(Extract_cell_unit( Result_FILE, 'F_onset', 2 ));
            response_period=floor((t_start-Onset_start)*Sample_rate)+1:floor((t_stop-Onset_start)*Sample_rate);
            sprintf('Averaged response for each mouse:\n')
            f_response=mean(f_onset(:,response_period),2)
            [cal_file1, cal_path] = uiputfile('*.mat','Save response',char(get(handles.Ca_folder,'String'))); %获取文件名
            if ischar(cal_file1)
                save([cal_path,cal_file1],'f_response');
            end
        else
            warndlg('Not inside onset period !!!')  
        end
    else
        if ~strcmp(Offset_start,'-')
           if t_stop>t_start  &  t_start>=Offset_start  &  t_stop<=Offset_stop
               f_offset=cell2mat(Extract_cell_unit( Result_FILE, 'F_offset', 2 ));
               response_period=floor((t_start-Offset_start)*Sample_rate):floor((t_stop-Offset_start)*Sample_rate);
               sprintf('Averaged offset response for each mouse:\n')
               f_response=mean(f_offset(:,response_period),2)
               [cal_file2, cal_path] = uiputfile('*.mat','Save response',char(get(handles.Ca_folder,'String'))); %获取文件名 
               if ischar(cal_file2)
                  save([cal_path,cal_file2],'f_response');
               end
           else
              warndlg('Not inside onset period !!!')   
           end
        else
           warndlg('Not Onset-offset stimuli type !!!')  
        end
    end
end


% --- Executes on button press in summary_plot.
function summary_plot_Callback(hObject, eventdata, handles)
% hObject    handle to summary_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global figure_n Legend line_handle_on line_handle_off line_handle_normal 
[cal_file, cal_path] = uigetfile('*.mat','Open Ca file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名 
if ischar(cal_file)
    if isempty(figure_n)
        figure_n=1;
        Legend={get(handles.Legend,'String')};
    else
        figure_n=figure_n+1;
        Legend=[Legend;get(handles.Legend,'String')];
    end
    a=load([cal_path, cal_file]);
    Result_FILE=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
    f_onset=cell2mat(Extract_cell_unit( Result_FILE, 'F_onset', 2 ));
    onset_start=cell2mat(Extract_cell_unit( Result_FILE, 'onset_start', 2,2 ));
    onset_stop=cell2mat(Extract_cell_unit( Result_FILE, 'onset_stop', 2,2 ));
    sample_rate=cell2mat(Extract_cell_unit( Result_FILE, 'F_sample_rate', 2,2 ));
    figure(1)
%     if ~exist('h1_axes','var')
%         h1_axes=axes;
%     end
    hold on
    line_handle_on=PLOT(gca,0, f_onset, onset_start, onset_stop, sample_rate, 'Onset',figure_n,Legend,line_handle_on);

    if strcmp(Extract_cell_unit( Result_FILE,'Stimuli_type',2),'Onset-offset') %是Onset-offset类型
       f_offset=cell2mat(Extract_cell_unit( Result_FILE, 'F_offset', 2 ));
       offset_start=cell2mat(Extract_cell_unit( Result_FILE, 'offset_start', 2,2 ));
       offset_stop=cell2mat(Extract_cell_unit( Result_FILE, 'offset_stop', 2,2 ));
       figure(2)
%        if ~exist('h2_axes','var')
%             h2_axes=axes;
%        end
       hold on
       line_handle_off=PLOT(gca,0, f_offset, offset_start, offset_stop, sample_rate, 'Offset',figure_n,Legend,line_handle_off);
       
       f_normalization=cell2mat(Extract_cell_unit( Result_FILE, 'F_normalization', 2 ));
       figure(3)
%        if ~exist('h3_axes','var')
%            h3_axes=axes;
%        end
       hold on
       line_handle_normal=PLOT(gca,0, f_normalization, -10, 60, 1, 'Normalization',figure_n,Legend,line_handle_normal);
    end
end


function Legend_Callback(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Legend as text
%        str2double(get(hObject,'String')) returns contents of Legend as a double


% --- Executes during object creation, after setting all properties.
function Legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function event_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to event_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of event_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of event_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function event_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to event_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_behavior.
function check_behavior_Callback(hObject, eventdata, handles)
% hObject    handle to check_behavior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_behavior


% --- Executes on button press in Scratch_analyze.
function Scratch_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to Scratch_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[scra_file, scra_path] = uigetfile('*.mat','Open result file','MultiSelect','off',char(get(handles.Ca_folder,'String'))); %获取文件名
if ischar(scra_file)
    a=load([scra_path, scra_file]);
    Result_FILE=getfield(a,char(fieldnames(a)));           %得到原来的变量名和数据
    Bout_duration=zeros(size(Result_FILE,1)-1,1);
    Train_duration=zeros(size(Result_FILE,1)-1,1);
    scratch_bins=zeros(size(Result_FILE,1)-1,60/5);   % 假设最长记录60min，bin长为5min
    for i=1:size(Result_FILE,1)-1
        Bout_duration(i)=mean(cell2mat(Extract_cell_unit( Result_FILE, 'Bout_duration',i+1,i+1)));
        Train_duration(i)=mean(cell2mat(Extract_cell_unit( Result_FILE, 'Train_duration',i+1,i+1)));
        Bout_time=cell2mat(Extract_cell_unit( Result_FILE, 'Bout_time',i+1,i+1));
        [scratch_bins(i,:),e]=hist(Bout_time/60,2.5:5:57.5);
    end
    
    [scra_file, scra_path] = uiputfile('*.mat','Save result',char(get(handles.Ca_folder,'String'))); %获取存储文件名 
    if ischar(scra_file)
        Scratching_result.Bout_duration=Bout_duration;
        Scratching_result.Train_duration=Train_duration;
        Scratching_result.scratch_bins=scratch_bins;
        save([scra_path,scra_file],'Scratching_result');
    end
end



function Scratch_INFO_folder_Callback(hObject, eventdata, handles)
% hObject    handle to Scratch_INFO_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Scratch_INFO_folder as text
%        str2double(get(hObject,'String')) returns contents of Scratch_INFO_folder as a double


% --- Executes during object creation, after setting all properties.
function Scratch_INFO_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scratch_INFO_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
