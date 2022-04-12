function varargout = HW(varargin)
% HW MATLAB code for HW.fig
%      HW, by itself, creates a new HW or raises the existing
%      singleton*.
%
%      H = HW returns the handle to a new HW or the handle to
%      the existing singleton*.
%
%      HW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW.M with the given input arguments.
%
%      HW('Property','Value',...) creates a new HW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HW

% Last Modified by GUIDE v2.5 09-Nov-2020 09:46:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HW_OpeningFcn, ...
                   'gui_OutputFcn',  @HW_OutputFcn, ...
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


% --- Executes just before HW is made visible.
function HW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HW (see VARARGIN)

% Choose default command line output for HW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in inputImage.
function inputImage_Callback(hObject, eventdata, handles)
% hObject    handle to inputImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img col row;
%�I�sEnterRC.m
EnterRC;
waitfor(EnterRC);
%���oEnterRC.m�]�w����C��
mainGui = findobj('Name','HW');
col=getappdata(mainGui,'col');
row=getappdata(mainGui,'row');
%�פJraw�v��
[imagefile,imagepath]=uigetfile('*.*');
fid=fopen([imagepath,imagefile],'rb');
imgOrigin=fread(fid,[col,row]);
img=imgOrigin';
fclose(fid);
imshow(img,[],'Parent',handles.axes1);
set(handles.text1,'string',imagefile);
set(handles.textOrigin,'string',col+"��"+row);

% --- Executes on button press in model.
function model_Callback(hObject, eventdata, handles)
% hObject    handle to model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img col row;
%ø�s3D�ҫ�
Z=img;
[X,Y]=meshgrid(1:col,1:row);
axes(handles.axes2);
surf(X,Y,Z);
xlabel("x axis");
ylabel("y axis");
zlabel("gray value");

% --- Executes on button press in calculateCenter.
function calculateCenter_Callback(hObject, eventdata, handles)
% hObject    handle to calculateCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img x y;
%�p��ǫ׭Ȫ��̤p�ȡB�����ȡB�{�ɭ�
gmin=roundn(min(min(img)),-2);
set(handles.txt_g_min,'string',gmin);
gmean=roundn(mean(mean(img)),-2);
set(handles.txt_g_mean,'string',gmean);
gS=roundn((gmin+gmean)/2,-2);
set(handles.txt_g_s,'string',gS);
%���o�v���j�p
[img1r,img1c]=size(img);
%�ǫ׭Ȥj���{�ɭȮɬ�1�A�p��h��0
img1(img<=gS)=0;
img1(img>gS)=1;
%�p��ǫ׭Ȥj���{�ɭȱo������
num1=sum(img1==1);
set(handles.txt_num_thre,'string',num1);
%�p���`������
sumPixels1=numel(img1);
set(handles.txt_pixels,'string',sumPixels1);
%�p��ǫ׭���x�By�y��
img1=reshape(img1,[img1r,img1c]);
sub1=img-gS;
M1=sum(sum(img1.*sub1));
x=roundn((1/M1)*sum(sum([1:img1c].*img1.*sub1)),-3);
set(handles.txt_x,'string',x);
y=roundn((1/M1)*sum(sum([1:img1r]'.*img1.*sub1)),-3);
set(handles.txt_y,'string',y);
%�b�ϤWø�s����Q�r
axes(handles.axes1);
hold on;
plot(x,y,'r+','LineWidth',1,'MarkerSize',12);
hold off;


% --- Executes on button press in cutImage.
function cutImage_Callback(hObject, eventdata, handles)
% hObject    handle to cutImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgCut colCut rowCut ;
%������v��
axes(handles.axes1);
imgCut=imcrop;
%��X������v��
imshow(imgCut,[],'Parent',handles.axes3);
[rowCut,colCut]=size(imgCut);
set(handles.textCut,'string',colCut+"��"+rowCut);

% --- Executes on button press in calculateCutCenter.
function calculateCutCenter_Callback(hObject, eventdata, handles)
% hObject    handle to calculateCutCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgCut colCut rowCut;
%�p�������v���ǫ׭Ȫ��̤p�ȡB�����ȡB�{�ɭ�
gminCut=roundn(min(min(imgCut)),-2);
set(handles.txt_g_min,'string',gminCut);
gmeanCut=roundn(mean(mean(imgCut)),-2);
set(handles.txt_g_mean,'string',gmeanCut);
gSCut=roundn((gminCut+gmeanCut)/2,-2);
set(handles.txt_g_s,'string',gSCut);
%�ǫ׭Ȥj���{�ɭȮɬ�1�A�p��h��0
img2(imgCut<=gSCut)=0;
img2(imgCut>gSCut)=1;
%�p�������ǫ׭Ȥj���{�ɭȱo������
num2=sum(img2==1);
set(handles.txt_num_thre,'string',num2);
%�p��������`������
sumPixels2=numel(img2);
set(handles.txt_pixels,'string',sumPixels2);
%�p�������v���ǫ׭���x�By�y��
img2=reshape(img2,[rowCut,colCut]);
sub2=imgCut-gSCut;
M2=sum(sum(img2.*sub2));
xCut=roundn((1/M2)*sum(sum([1:colCut].*img2.*sub2)),-3);
set(handles.txt_x,'string',xCut);
yCut=roundn((1/M2)*sum(sum([1:rowCut]'.*img2.*sub2)),-3);
set(handles.txt_y,'string',yCut);
%�b�ϤWø�s����Q�r
axes(handles.axes3);
hold on;
plot(xCut,yCut,'y+','LineWidth',1,'MarkerSize',12);
hold off;


% --- Executes on button press in resizeImage.
function resizeImage_Callback(hObject, eventdata, handles)
% hObject    handle to resizeImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img imgResized colResized rowResized;
%�I�sEnterRC.m
EnterRC;
waitfor(EnterRC);
%���oEnterRC.m�]�w���b���˪���C��
mainGui = findobj('Name','HW');
colResized=getappdata(mainGui,'col');
rowResized=getappdata(mainGui,'row');
%��X�A���˼v��
imgResized=imresize(img,[rowResized colResized]);
imshow(imgResized,[],'Parent',handles.axes4);
set(handles.textResized,'string',colResized+"��"+rowResized);

% --- Executes on button press in calculateResizeCenter.
function calculateResizeCenter_Callback(hObject, eventdata, handles)
% hObject    handle to calculateResizeCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgResized colResized rowResized;
%�p��A���˫�v���ǫ׭Ȫ��̤p�ȡB�����ȡB�{�ɭ�
gminResized=roundn(min(min(imgResized)),-2);
set(handles.txt_g_min,'string',gminResized);
gmeanResized=roundn(mean(mean(imgResized)),-2);
set(handles.txt_g_mean,'string',gmeanResized);
gSResized=roundn((gminResized+gmeanResized)/2,-2);
set(handles.txt_g_s,'string',gSResized);
%�ǫ׭Ȥj���{�ɭȮɬ�1�A�p��h��0
img3(imgResized<=gSResized)=0;
img3(imgResized>gSResized)=1;
%�p��A���˫�ǫ׭Ȥj���{�ɭȱo������
num3=sum(img3==1);
set(handles.txt_num_thre,'string',num3);
%�p��A���˫��`������
sumPixels3=numel(img3);
set(handles.txt_pixels,'string',sumPixels3);
%�p��A���˫�v���ǫ׭���x�By�y��
img3=reshape(img3,[rowResized,colResized]);
sub3=imgResized-gSResized;
M3=sum(sum(img3.*sub3));
xResized=roundn((1/M3)*sum(sum([1:colResized].*img3.*sub3)),-3);
set(handles.txt_x,'string',xResized);
yResized=roundn((1/M3)*sum(sum([1:rowResized]'.*img3.*sub3)),-3);
set(handles.txt_y,'string',yResized);
%�b�ϤWø�s���Q�r
axes(handles.axes4);
hold on;
plot(xResized,yResized,'g+','LineWidth',1,'MarkerSize',12);
hold off;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
clear global;
