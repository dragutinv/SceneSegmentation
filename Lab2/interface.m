function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 25-Mar-2015 17:22:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.imgLogo);
imagesc()
imshow('logo.jpg');



% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in getImage.
function getImage_Callback(hObject, eventdata, handles)
% hObject    handle to getImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.ImgFileName, handles.ImgPathName] = uigetfile('*.png;*.jpg;*.jpeg;*.tif;*.gif', 'Image Files (*.jpg, *.png, *.tif, *.gif)');

if (length(handles.ImgFileName) > 3)
    tic; %start measuring execution time
    
    axes(handles.imgOriginal);
    imagesc()
    imshow([handles.ImgPathName,handles.ImgFileName]);
    
    axes(handles.imgPattern);
    imagesc()
    imshow([]);
    
    axes(handles.imgGrowingRegion);
    imagesc()
    imshow([]);
    
    guidata(interface, handles);
    T = toc; %measure elapsed time    
end

% --- Executes during object creation, after setting all properties.
function txtWindowSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWindowSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWndSize_Callback(hObject, eventdata, handles)
% hObject    handle to txtWndSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWndSize as text
%        str2double(get(hObject,'String')) returns contents of txtWndSize as a double
global outputImageContrast;
global outputImageEnergy;
global outputImageHomogeneity;
global outputImageEntropy;

outputImageContrast = [];
outputImageEnergy = [];
outputImageHomogeneity = [];
outputImageEntropy = [];

% --- Executes during object creation, after setting all properties.
function txtWndSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWndSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstProps.
function lstProps_Callback(hObject, eventdata, handles)
% hObject    handle to lstProps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstProps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstProps


% --- Executes during object creation, after setting all properties.
function lstProps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstProps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnPerformSegmentation.
function btnPerformSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to btnPerformSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outputImageContrast;
global outputImageEnergy;
global outputImageHomogeneity;
global outputImageEntropy;

list = get(handles.lstProps, 'String');
props = list{get(handles.lstProps, 'value')};

if size(outputImageContrast) < 10
    [outputImageContrast, outputImageEnergy, outputImageHomogeneity, outputImageEntropy] = textureSegmentation([handles.ImgPathName,handles.ImgFileName], props, str2num(get(handles.txtWndSize, 'String')));
end
axes(handles.imgPattern);

if strcmp(props, 'Contrast') == 1
    im = uint8(outputImageContrast*255);
elseif strcmp(props, 'Energy') == 1
    im = uint8(outputImageEnergy*255);
elseif strcmp(props, 'Homogeneity') == 1
    im = uint8(outputImageHomogeneity*255);    
elseif strcmp(props, 'Entropy') == 1
    im = uint8(outputImageEntropy*255);    
end

imagesc();
imshow(im);

%perform region growing segmentation
connectivity = 4;
connectivityFour = get(handles.rb4Neigbours,'Value');
if (connectivityFour == 0)
    connectivity = 8;
end

threshold = str2double(get(handles.txtThreshold,'String'));

[regions] = growingRegion(im, connectivity, threshold);
axes(handles.imgGrowingRegion);
imagesc();
imshow(regions);


% --- Executes on button press in rb4Neigbours.
function rb4Neigbours_Callback(hObject, eventdata, handles)
% hObject    handle to rb4Neigbours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb4Neigbours
set(handles.rb8Neigbours, 'Value', 0);


% --- Executes on button press in rb8Neigbours.
function rb8Neigbours_Callback(hObject, eventdata, handles)
% hObject    handle to rb8Neigbours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb8Neigbours
set(handles.rb4Neigbours, 'Value', 0);



function txtThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to txtThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtThreshold as text
%        str2double(get(hObject,'String')) returns contents of txtThreshold as a double


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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chbContrast.
function chbContrast_Callback(hObject, eventdata, handles)
% hObject    handle to chbContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbContrast


% --- Executes on button press in chbEnergy.
function chbEnergy_Callback(hObject, eventdata, handles)
% hObject    handle to chbEnergy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbEnergy


% --- Executes on button press in chbHomogeneity.
function chbHomogeneity_Callback(hObject, eventdata, handles)
% hObject    handle to chbHomogeneity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbHomogeneity


% --- Executes on button press in chbEntropy.
function chbEntropy_Callback(hObject, eventdata, handles)
% hObject    handle to chbEntropy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbEntropy


% --- Executes on button press in btnClassification.
function btnClassification_Callback(hObject, eventdata, handles)
% hObject    handle to btnClassification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chbContrast = get(handles.chbContrast, 'Value');
chbEnergy = get(handles.chbEnergy, 'Value');
chbHomogeneity = get(handles.chbHomogeneity, 'Value');
chbEntropy = get(handles.chbEntropy, 'Value');

score = scr_classifyFunc([chbContrast chbEnergy chbHomogeneity chbEntropy]);
set(handles.txtScore, 'String', num2str(score));


% --- Executes on button press in btnAllFeatures.
function btnAllFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to btnAllFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outputImageContrast;
global outputImageEnergy;
global outputImageHomogeneity;
global outputImageEntropy;

if (size(outputImageContrast) > 10)
    figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(1, 4, 1); imshow(outputImageContrast); title('Contrast');
    subplot(1, 4, 2); imshow(outputImageEnergy); title('Energy');
    subplot(1, 4, 3); imshow(outputImageHomogeneity); title('Homogeneity');
    subplot(1, 4, 4); imshow(outputImageEntropy); title('Entropy');
end
