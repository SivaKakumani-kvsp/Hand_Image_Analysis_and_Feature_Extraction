%to get the comparison between fivw different images of hands I take one
%hand image at at time by reading the hand image as 'myhand1', 'myhand2',
%'myhand3', 'myhand4',, 'myhand5', at five different times. in 5th line of
%code.
%reading the image of hand
image = imread('myhand5.jpeg');
%converting rgb image to grayscale image
G_image=rgb2gray(image);
G_image=double(G_image);
G_image=G_image-min(G_image(:));
G_image=G_image./max(G_image(:));
figure
subplot(1, 2, 1);
imshow(G_image);



%for creating the axes on the hand w.r.t feature lines
for index = 1:14
    %creating coordinate matrices for two points for 14 lines
    p1 = zeros(14,2);
    p2 = zeros(14,2);
    %to point the coordinates of two points
    [p1(index, :), p2(index, :)] = ginput(2);
    
    %join the points with a line
    x = [p1(index, 1), p1(index, 2)];
    y = [p2(index, 1), p2(index, 2)];
    plot(x, y, '*g-', 'LineWidth', 2); 
   
    %searching for gray color through pixel profile
    pixel_pro = improfile(gray, p1(index, :), p2(index, :));
    subplot(1, 2, 2);
    plot(pixel_pro);
    
    line_points_diff = diff(pixel_pro);
    %
    minindex = zeros(14);
    maxindex = zeros(14);
    minVal = zeros(14);
    maxVal = zeros(14);
    minVal(index) = min(line_points_diff);
    maxVal(index) = max(line_points_diff);
    minindex(index) = find(line_points_diff==minVal(index), 1, 'last');
    maxindex(index) = find(line_points_diff==maxVal(index), 1);
    
    % finding slopes
    len = length(pixel_pro);

    m1x = (((norm(p1(index, :) - p2(index, :)))/len)*maxindex(index));
    m1y = (norm(p1(index, :) - p2(index, :)));

    m2x = ((norm(p1(index, :) - p2(index, :)))/len)*minindex(index);
    m2y = norm(p1(index, :) - p2(index, :));

    m1 = (m1x/m1y);
    m2 = (m2x/m2y);

    %intializing start and end pixel matrices for storing values
    start_pixel1 = zeros(14);
    start_pixel2 = zeros(14);
    start_pixel1(index) = ((m1*p1(index,2)) + (p1(index,1)*(1-m1)));
    start_pixel2(index) = ((m1*p2(index,2)) + (p2(index,1)*(1-m1)));
    end_pixel1 = zeros(14);
    end_pixel2 = zeros(14);
    end_pixel1(index) = ((m2*p1(index,2)) + (p1(index,1)*(1-m2)));
    end_pixel2(index) = ((m2*p2(index,2)) + (p2(index,1)*(1-m2)));
    %plotting the starting pixel and ending pixel
     

    x1 = [start_pixel1(index), end_pixel1(index)];
    y1 = [start_pixel2(index), end_pixel2(index)];
    plot(x1, y1, '^r-', 'LineWidth', 1.5);
    hold on;

end
   








