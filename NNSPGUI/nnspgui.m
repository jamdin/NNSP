function varargout = nnspgui(varargin)
% NNSPGUI M-file for nnspgui.fig
%      NNSPGUI, by itself, creates a new NNSPGUI or raises the existing
%      singleton*.
%
%      H = NNSPGUI returns the handle to a new NNSPGUI or the handle to
%      the existing singleton*.
%
%      NNSPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NNSPGUI.M with the given input arguments.
%
%      NNSPGUI('Property','Value',...) creates a new NNSPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nnspgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nnspgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nnspgui

% Last Modified by GUIDE v2.5 11-Apr-2013 16:57:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nnspgui_OpeningFcn, ...
                   'gui_OutputFcn',  @nnspgui_OutputFcn, ...
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


% --- Executes just before nnspgui is made visible.
function nnspgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nnspgui (see VARARGIN)

% Choose default command line output for nnspgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
paths=encontrarPaths;
% UIWAIT makes nnspgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nnspgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupLiga.
function popupLiga_Callback(hObject, eventdata, handles)
% hObject    handle to popupLiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupLiga contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupLiga


% --- Executes during object creation, after setting all properties.
function popupLiga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupLiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in equipoLocal.
function equipoLocal_Callback(hObject, eventdata, handles)
% hObject    handle to equipoLocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns equipoLocal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from equipoLocal


% --- Executes during object creation, after setting all properties.
function equipoLocal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equipoLocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in equipoVis.
function equipoVis_Callback(hObject, eventdata, handles)
% hObject    handle to equipoVis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns equipoVis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from equipoVis


% --- Executes during object creation, after setting all properties.
function equipoVis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equipoVis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in elegirEquipo.
function elegirEquipo_Callback(hObject, eventdata, handles)
% hObject    handle to elegirEquipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in elegirLiga.
function elegirLiga_Callback(hObject, eventdata, handles)
% hObject    handle to elegirLiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
