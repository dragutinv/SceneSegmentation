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

% Last Modified by GUIDE v2.5 23-Mar-2015 17:27:33

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

list = get(handles.lstProps, 'String');
props = list{get(handles.lstProps, 'value')};

[outputImageContrast, outputImageEnergy, outputImageHomogeneity, outputImageEntropy] = textureSegmentation([handles.ImgPathName,handles.ImgFileName], props, str2num(get(handles.txtWndSize, 'String')));
axes(handles.imgPattern);
imagesc();

set(hObject,'outputImageContrast',outputImageContrast);
set(hObject,'outputImageEnergy',outputImageEnergy);
set(hObject,'outputImageHomogeneity',outputImageHomogeneity);
set(hObject,'outputImageEntropy',outputImageEntropy);

if strcmp(props, 'Contrast') == 1
    imshow(uint8(outputImageContrast*255));
elseif strcmp(props, 'Energy') == 1
    imshow(uint8(outputImageEnergy*255));
elseif strcmp(props, 'Homogeneity') == 1
    imshow(uint8(outputImageHomogeneity*255));    
elseif strcmp(props, 'Entropy') == 1
    imshow(uint8(outputImageEntropy*255));    
end
