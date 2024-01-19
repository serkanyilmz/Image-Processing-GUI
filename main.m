
function main ()
  MainFrm = figure ( ...
    'position', [100, 100, 1500, 800],...
    "Name", "Image Processing with Octave - Serkan Yilmaz");

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  TitleFrm = axes ( ...
    'position', [0, 0.9, 1, 0.1], ...
    'color',    [0.8, 0.85, 0.9], ...
    'units',    'normalized', ...
    'xtick',    [], ...
    'ytick',    [], ...
    'xlim',     [0, 1], ...
    'ylim',     [0, 1] );

  Title = text (0.2, 0.5, 'Original Image', 'fontsize', 18);
  Title = text (0.7, 0.5, 'Processed Image', 'fontsize', 18);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ImgFrm = axes ( ...
    'position', [0, 0.3, 0.5, 0.6], ...
    'color',    [0.9, 0.95, 1], ...
    'xtick',    [], ...
    'ytick',    [], ...
    'xlim',     [0, 1], ...
    'ylim',     [0, 1]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ProcessedImgFrm = axes ( ...
    'position', [0.5, 0.3, 0.5, 0.6], ...
    'color',    [0.9, 0.95, 1], ...
    'xtick',    [], ...
    'ytick',    [], ...
    'xlim',     [0, 1], ...
    'ylim',     [0, 1]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ButtonsFrm = uipanel (MainFrm, ...
    'position', [0, 0, 1, 0.3], ...
    'BackgroundColor',    [0.8, 0.85, 0.9], ...
    'units', 'normalized');

  LoadButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Load', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.4, 0.8, 0.275, 0.18], ...
    'callback', {@load, ImgFrm});

    SaveButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Save', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.675, 0.8, 0.275, 0.18], ...
    'callback', {@save, ProcessedImgFrm});


  ThresholdLabel = uicontrol (ButtonsFrm, ...
            "style", "text",
           "units", "normalized",
            'BackgroundColor',    [0.8, 0.85, 0.9], ...
           "string", "Threshold: 128",
           "horizontalalignment", "left",
           "position", [0.41, 0.6, 0.5, 0.2]);

  ThresholdSlider = uicontrol(ButtonsFrm, ...
    'style', 'slider', ...
    'min', 0, 'max', 255, 'value', 128, ...
    'units', 'normalized', ...
    'position', [0.5, 0.6, 0.45, 0.2], ...
    'callback', {@threshold, ImgFrm, ProcessedImgFrm, ThresholdLabel});

     MinButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Min 3x3', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.4, 0.42, 0.18, 0.18], ...
    'callback', {@minn, ImgFrm, ProcessedImgFrm});

     MaxButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'string', 'Max 3x3', ...
    'units', 'normalized', ...
    'position', [0.58, 0.42, 0.18, 0.18], ...
    'callback', {@maxx, ImgFrm, ProcessedImgFrm});

    AvarageButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Avarage 3x3', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.76, 0.42, 0.19, 0.18], ...
    'callback', {@avarage, ImgFrm, ProcessedImgFrm});

     NegativeButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Negative', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.4, 0.22, 0.275, 0.18], ...
    'callback', {@negative, ImgFrm, ProcessedImgFrm});

     EqHistButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Equalize Histogram', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.675, 0.22, 0.275, 0.18], ...
    'callback', {@equalizeHistogram, ImgFrm, ProcessedImgFrm});


    LaplacianButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Laplacian', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.4, 0.02, 0.275, 0.18], ...
    'callback', {@ApplyFilter, ImgFrm, ProcessedImgFrm, [0 1 0 ; 1 -4 1; 0 1 0]});

    SharpenButton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Sharpen (Image - Laplacian)', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'units', 'normalized', ...
    'position', [0.675, 0.02, 0.275, 0.18], ...
    'callback', {@sharpen, ImgFrm, ProcessedImgFrm});



  aa = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "0",
               "horizontalalignment", "left",
               "position", [0.05, 0.7, 0.1, 0.2]);
  bb = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "1",
               "horizontalalignment", "left",
               "position", [0.15, 0.7, 0.1, 0.2]);
  cc = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "0",
               "horizontalalignment", "left",
               "position", [0.25, 0.7, 0.1, 0.2]);
  dd = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "1",
               "horizontalalignment", "left",
               "position", [0.05, 0.5, 0.1, 0.2]);
  ee = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "-4",
               "horizontalalignment", "left",
               "position", [0.15, 0.5, 0.1, 0.2]);
  ff = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "1",
               "horizontalalignment", "left",
               "position", [0.25, 0.5, 0.1, 0.2]);
  gg = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "0",
               "horizontalalignment", "left",
               "position", [0.05, 0.3, 0.1, 0.2]);
  hh = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "1",
               "horizontalalignment", "left",
               "position", [0.15, 0.3, 0.1, 0.2]);
  ii = uicontrol (ButtonsFrm, ...
                "style", "edit",
               "units", "normalized",
               "string", "0",
               "horizontalalignment", "left",
               "position", [0.25, 0.3, 0.1, 0.2]);

  applybutton = uicontrol(ButtonsFrm, ...
    'style', 'pushbutton', ...
    'string', 'Apply Filter', ...
    'units', 'normalized', ...
    'BackgroundColor', [1, 0.8, 0.6], ...
    'position', [0.05, 0.1, 0.3, 0.2], ...
    'callback', {@apply, ImgFrm, ProcessedImgFrm,aa,bb,cc,dd,ee,ff,gg,hh,ii});
end

function load (hObject, eventdata, ImageFrame)
  [fname, fpath] = uigetfile();
  Img = imread (fullfile(fpath, fname));
  axes(ImageFrame);
  imshow(Img, []);
  axis image off
end

function save(~, ~, ProcessedImgFrm)
    img = get(get(ProcessedImgFrm, 'Children'), 'CData');
    if isempty(img)
        disp('No processed image to save.');
        return;
    end
    [fname, fpath] = uiputfile({'*.png', 'PNG Files (*.png)'; '*.jpg', 'JPEG Files (*.jpg)'; '*.*', 'All Files (*.*)'}, 'Save Processed Image As');
    if isequal(fname, 0) || isequal(fpath, 0)
        disp('Save operation canceled.');
        return;
    end
    fullFilePath = fullfile(fpath, fname);
    imwrite(uint8(img), fullFilePath);
end


function img = getimage (ImageFrame)
  img = get(get(ImageFrame, 'Children'), 'CData');
end


function apply(hObject, eventdata, ImageFrame, ProcessedImgFrm,aa,bb,cc,dd,ee,ff,gg,hh,ii)
  a=str2double(get(aa, "String"));
  b=str2double(get(bb, "String"));
   c= str2double(get(cc, "String"));
   d=str2double(get(dd, "String"));
   e=str2double(get(ee, "String"));
    f=str2double(get(ff, "String"));
    g=str2double(get(gg, "String"));
    h=str2double(get(hh, "String"));
    i=str2double(get(ii, "String"));
     filt = [a, b, c; d, e, f; g, h, i];

    ApplyFilter(hObject, eventdata, ImageFrame, ProcessedImgFrm, filt);
 end

 function ApplyFilter(hObject, eventdata, ImageFrame, ProcessedImgFrm , filt)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
    [r,c]=size(img);
    paddedIm=zeros(r+2,c+2);
    paddedIm(2:r+1,2:c+1)=img;
    filteredImage=zeros(r,c);
    for i=2:r+1
        for j=2:c+1
            newPixelValue=floor(paddedIm(i,j)*filt(2,2))+floor(paddedIm(i-1,j)*filt(1,2))+...
            floor(paddedIm(i+1,j)*filt(3,2))+floor( paddedIm(i,j-1)*filt(2,1))+...
            floor(paddedIm(i,j+1)*filt(2,3))+floor(paddedIm(i-1,j-1)*filt(1,1))+floor(...
                paddedIm(i+1,j+1)*filt(3,3))+floor(paddedIm(i-1,j+1)*filt(1,3))+floor(...
                paddedIm(i+1,j-1)*filt(3,1));
            if newPixelValue < 0
              newPixelValue=0;
            endif
            if newPixelValue>255
              newPixelValue=255;
            endif
            filteredImage(i-1,j-1)=newPixelValue;
        end
    end
  axes(ProcessedImgFrm);
  imshow(filteredImage, []);
  axis image off
end


function threshold(hObject, eventdata, ImageFrame, ProcessedImgFrm, ThresholdLabel)
  img = getimage(ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
  threshold_value = get(hObject, 'Value');
  set (ThresholdLabel, "string", sprintf ("Threshold: %d", threshold_value));
  output = (img >= threshold_value)*255;
  axes(ProcessedImgFrm);
  imshow(output, []);
  colormap gray;
  axis image off
end


function minn(hObject, eventdata, ImageFrame, ProcessedImgFrm)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
  [r,c]=size(img);
paddedIm=zeros(r+2,c+2);
paddedIm(2:r+1,2:c+1)=img;
filteredImage=zeros(r,c);
for i=2:r+1
    for j=2:c+1
        temp=[paddedIm(i,j),paddedIm(i-1,j),paddedIm(i+1,j)...
            ,paddedIm(i,j-1),paddedIm(i,j+1)...
            ,paddedIm(i-1,j-1),paddedIm(i+1,j+1)...
            ,paddedIm(i-1,j+1),paddedIm(i+1,j-1)];
        newPixelValue=min(temp);
        filteredImage(i-1,j-1)=newPixelValue;
    end
end
  axes(ProcessedImgFrm);
  imshow(filteredImage, []);
  axis image off
end

function maxx(hObject, eventdata, ImageFrame, ProcessedImgFrm)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
  [r,c]=size(img);
paddedIm=zeros(r+2,c+2);
paddedIm(2:r+1,2:c+1)=img;
filteredImage=zeros(r,c);
for i=2:r+1
    for j=2:c+1
        temp=[paddedIm(i,j),paddedIm(i-1,j),paddedIm(i+1,j)...
            ,paddedIm(i,j-1),paddedIm(i,j+1)...
            ,paddedIm(i-1,j-1),paddedIm(i+1,j+1)...
            ,paddedIm(i-1,j+1),paddedIm(i+1,j-1)];
        newPixelValue=max(temp);
        filteredImage(i-1,j-1)=newPixelValue;
    end
end
  axes(ProcessedImgFrm);
  imshow(filteredImage, []);
  axis image off
end


function avarage(hObject, eventdata, ImageFrame, ProcessedImgFrm)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
  [r,c]=size(img);
paddedIm=zeros(r+2,c+2);
paddedIm(2:r+1,2:c+1)=img;
filteredImage=zeros(r,c);
for i=2:r+1
    for j=2:c+1
        temp=[paddedIm(i,j),paddedIm(i-1,j),paddedIm(i+1,j)...
            ,paddedIm(i,j-1),paddedIm(i,j+1)...
            ,paddedIm(i-1,j-1),paddedIm(i+1,j+1)...
            ,paddedIm(i-1,j+1),paddedIm(i+1,j-1)];
        newPixelValue=sum(temp)/9;
        filteredImage(i-1,j-1)=newPixelValue;
    end
end
  axes(ProcessedImgFrm);
  imshow(filteredImage, []);
  axis image off
end


function negative(hObject, eventdata, ImageFrame, ProcessedImgFrm)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
  output = 255 - img;
  axes(ProcessedImgFrm);
  imshow(output, []);
  axis image off
end


function equalizeHistogram(hObject, eventdata, ImageFrame, ProcessedImgFrm)
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
[r,c] = size(img);
output = zeros(r, c);
histogram=zeros(1,256);
	[r, c] = size(img);
	for i=1:r
		for j=1:c
			pixel=img(i,j);
			histogram(pixel+1) = histogram(pixel+1)+1;
     end
    end
step1 = histogram / (r*c);
step2 = zeros(1,256);
for i=1:256
	 step2(i)=sum(step1(1:i));
end
eq_histogram = round(255* step2);
for i=1:r
	for j=1:c
		output(i,j) = eq_histogram(img(i,j)+1);
	end
end
axes(ProcessedImgFrm);
  imshow(output, []);
  colormap gray;
  axis image off
end

function sharpen(hObject, eventdata, ImageFrame, ProcessedImgFrm )
  img = getimage (ImageFrame);
  if size(img, 3) == 3
        img = rgb2gray(img);
    end
    [r,c]=size(img);
    paddedIm=zeros(r+2,c+2);
    paddedIm(2:r+1,2:c+1)=img;
    filteredImage=zeros(r,c);
    filt = [0 1 0 ; 1 -4 1; 0 1 0];
    for i=2:r+1
        for j=2:c+1
            newPixelValue=floor(paddedIm(i,j)*filt(2,2))+floor(paddedIm(i-1,j)*filt(1,2))+...
            floor(paddedIm(i+1,j)*filt(3,2))+floor( paddedIm(i,j-1)*filt(2,1))+...
            floor(paddedIm(i,j+1)*filt(2,3))+floor(paddedIm(i-1,j-1)*filt(1,1))+floor(...
                paddedIm(i+1,j+1)*filt(3,3))+floor(paddedIm(i-1,j+1)*filt(1,3))+floor(...
                paddedIm(i+1,j-1)*filt(3,1));
            if newPixelValue < 0
              newPixelValue=0;
            endif
            if newPixelValue>255
              newPixelValue=255;
            endif
            filteredImage(i-1,j-1)=paddedIm(i,j)-newPixelValue;
        end
    end
  axes(ProcessedImgFrm);
  imshow(filteredImage, []);
  axis image off
end

