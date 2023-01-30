% Create GUI window
f = figure('Name', 'Design by Burak Ülkü', 'Color', 'white');
ax = axes('Parent', f, 'Position', [0.1, 0.1, 0.8, 0.8]);
imshow('logo.png', 'Parent', ax);

% Create start button
start_button = uicontrol(f,'Style','pushbutton','String','Start',...
    'Position',[200 50 100 30],'Callback',@start_callback);
% Create stop button
stop_button = uicontrol(f,'Style','pushbutton','String','Stop',...
    'Position',[350 50 100 30],'Callback',@stop_callback);
%Input Button
edit_box = uicontrol(f, 'Style', 'edit', 'String', 'Enter your name',...
    'Position', [50 50 100 30], 'Callback', @edit_callback);
% Return function for start button
function edit_callback(hObject, ~)
    global aranacak_kisi;
    aranacak_kisi = get(hObject, 'String');
end
function start_callback(~,~)
    global net;
    disp('Camera started');
    global web;
    web=webcam();
    sensor =vision.CascadeObjectDetector();
    global aranacak_kisi;
    image =snapshot(web); 
    grey = rgb2gray(image);
    bbox = step(sensor,grey);
    picture = imresize(image, [224, 224]);
    [Label, Prob] = classify(net,picture);
    name=char(Label);
    value=num2str(max(Prob));
    detpic=insertObjectAnnotation(image,"rectangle",bbox,name+" "+value);
    if strcmp(name, aranacak_kisi)
    imshow(detpic);
    msgbox(['Welcome ', aranacak_kisi], 'Access granted');
else
    msgbox(['You are not ', aranacak_kisi],'Error');
    end
end
function stop_callback(~,~)
global web;
    disp('Camera stopped');
    delete(web);
end
