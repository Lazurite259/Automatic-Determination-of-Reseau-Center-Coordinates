function varargout = EnterRC(varargin)
% ENTERRC MATLAB code for EnterRC.fig
%      ENTERRC, by itself, creates a new ENTERRC or raises the existing
%      singleton*.
%
%      H = ENTERRC returns the handle to a new ENTERRC or the handle to
%      the existing singleton*.
%
%      ENTERRC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTERRC.M with the given input arguments.
%
%      ENTERRC('Property','Value',...) creates a new ENTERRC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EnterRC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EnterRC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnterRC

% Last Modified by GUIDE v2.5 07-Nov-2020 20:53:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnterRC_OpeningFcn, ...
                   'gui_OutputFcn',  @EnterRC_OutputFcn, ...
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


% --- Executes just before EnterRC is made visible.
function EnterRC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EnterRC (see VARARGIN)

% Choose default command line output for EnterRC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EnterRC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnterRC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function col_Callback(hObject, eventdata, handles)
% hObject    handle to col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of col as text
%        str2double(get(hObject,'String')) returns contents of col as a double


% --- Executes during object creation, after setting all properties.
function col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function row_Callback(hObject, eventdata, handles)
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of row as text
%        str2double(get(hObject,'String')) returns contents of row as a double


% --- Executes during object creation, after setting all properties.
function row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonEnter.
function pushbuttonEnter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEnter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%輸入行列值
colValue=str2double(get(handles.col,'String'));
rowValue=str2double(get(handles.row,'String'));
%將行列值設定回HW.m
mainGui = findobj('Name','HW');
setappdata(mainGui,'col',colValue);
setappdata(mainGui,'row',rowValue);
closereq() %關閉視窗
