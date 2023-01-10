%% StreetLearn dataset: Panorama to perspective images
clear all
add_path;

% set dataset file path
panoids = importdata('../metadata/streetlearn_panoid.txt');
fid_index=fopen('../metadata/streetlearn_index.txt'); 
fid_x=fopen('../metadata/streetlearn_x.txt'); 
fid_y=fopen('../metadata/streetlearn_y.txt'); 
% from pano to perspective image
for i = 1:length(panoids)
    pano_id = panoids(i);
    pano_id = pano_id{1};
    index = textscan(fid_index,'%s',1,'delimiter','\n', 'headerlines',0);
    index = str2num(index{1,1}{1,1});
    x = textscan(fid_x,'%s',1,'delimiter','\n', 'headerlines',0);
    x = str2num(x{1,1}{1,1});
    y = textscan(fid_y,'%s',1,'delimiter','\n', 'headerlines',0);
    y = str2num(y{1,1}{1,1});
    
    % set save path
    saveDir = sprintf('../data/streetlearn/%s', pano_id); 
    fprintf("img %d/%d pano_id %s ", i, length(panoids), pano_id);

    %%% Project to perspective views
    % read image
    panoImg = im2double(imread(sprintf(...
                        '../data/jpegs_manhattan_2019/%s.jpg',...
                        pano_id)));

    % project it to multiple perspective views
    cutSize = 256; % size of perspective views
    fov = pi/2; % horizontal field of view of perspective views
    
    
    [sepScene] = separatePano_v2( panoImg, fov, x, y, cutSize, saveDir, index);
end