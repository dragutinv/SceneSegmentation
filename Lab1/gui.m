function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 01-Mar-2015 17:52:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.imgLogo);
imagesc()
imshow('logo.jpg');

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnRunSegmentation.
function btnRunSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to btnRunSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im = imread([handles.ImgPathName,handles.ImgFileName]);

%do preprocessing
preprocessing = get(handles.chkSmoothing,'Value');

if preprocessing == 1
    tic; %start measering execution time
    windowSize = str2num(get(handles.txtSmoothingSize,'String'));
    
    G = fspecial('gaussian',[windowSize windowSize], 2);
    im = imfilter(im,G,'same');
    T = toc; %measure elapsed time
    logEvent(strcat('Applying gaussian filter', ', window size:',{' '}, num2str(windowSize), {' '}, '(', num2str(T,2), {' '}, 's)'));
end

connectivity = 4;
connectivityFour = get(handles.rbFourNeigbours,'Value');
if (connectivityFour == 0)
    connectivity = 8;
end

threshold = str2double(get(handles.txtThreshold,'String'));

[regions, numOfRegions, T] = growingRegion(im, connectivity, threshold);

logEvent(strcat('Region growing',', threshold:',{' '}, num2str(threshold),', connectivity:',{' '}, num2str(connectivity), ', number of regions:',{' '}, num2str(numOfRegions), {' '}, '(', num2str(T,2), {' '}, 's)'));

axes(handles.imgOriginal);
imshow(uint8(im));

axes(handles.imgGrowingRegions);
imshow(regions);

numberClusters = str2double(get(handles.txtNumberCMeansClusters,'String'));
maxIterations = str2double(get(handles.txtMaxIterations,'String'));
[fRegions, T] = fuzzyCMeans(im, numberClusters, maxIterations);

axes(handles.imgFuzzyCMeans);
imshow(fRegions);

logEvent(strcat('Fuzzy C-Means', {' '}, '(', num2str(T,2), {' '}, 's)'));
logEvent('--');


% --- Executes during object creation, after setting all properties.
function txtNumberCMeansClusters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNumberCMeansClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnChooseImage.
function btnChooseImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnChooseImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.ImgFileName, handles.ImgPathName] = uigetfile('*.png;*.jpg;*.jpeg;*.tif;*.gif', 'Image Files (*.jpg, *.png, *.tif, *.gif)');

if (length(handles.ImgFileName) > 3)
    tic; %start measuring execution time
    
    axes(handles.imgOriginal);
    imshow([handles.ImgPathName,handles.ImgFileName]);
    
    axes(handles.imgGrowingRegions);
    imshow([]);
    
    axes(handles.imgFuzzyCMeans);
    imshow([]);
    
    guidata(gui, handles);
    T = toc; %measure elapsed time
    logEvent(strcat('Load ', {' '}, handles.ImgFileName, {' '}, '(', num2str(T,2), {' '}, 's)'));
end



% --- Executes during object creation, after setting all properties.
function txtThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function txtMaxIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMaxIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function logEvent(message)

handles = guidata(gui);
previousValue = get(handles.txtLog,'String');

if (size(previousValue, 1) > 1)
    tmp = '';
    for i = 1:size(previousValue)
        if i > 1
            tmp = sprintf('%s\n%s',tmp, previousValue(i,:)');
        else
            tmp = previousValue(i,:)';
        end
        
    end
    previousValue = tmp;
end

if (length(previousValue) > 1)
    set(handles.txtLog,'String',sprintf('%s\n%s',previousValue, char(message)));
else
    set(handles.txtLog,'String',char(message));
end
