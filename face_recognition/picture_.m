function picture_(net, image)
    if ~ischar(image)
        error('The input must be a filepath or URL as a string')
    end
    I = imread(image);
    if isempty(I)
        error('The input is not a valid image file, please check the filepath or URL')
    end
    [h,w,c] = size(I);
    if h~= 224 || w~= 224
        G = imresize(I, [224, 224]);
    else
        G = I;
    end
    [Label, Prob] = classify(net, G);
    imshow(G);
    title({char(Label), num2str(max(Prob)*100)});
end


%  picture_(net,'C:\Users\BURAK_\Desktop\MATLAB FİNAL\arda.jpg')