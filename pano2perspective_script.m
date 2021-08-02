%% StreetLearn dataset: Panorama to perspective images
clear all
add_path;

% set dataset file path
panoids = importdata('../metadata/streetlearn_panoid.txt');
rota_x = importdata('../metadata/streetlearn_x.txt', ' ', 0);
rota_y = importdata('../metadata/streetlearn_y.txt', ' ', 0);
rota_index = importdata('../metadata/streetlearn_index.txt', ' ', 0);
% from pano to perspective image
for i = 1:length(panoids)
    pano_id = panoids(i);
    pano_id = pano_id{1};
    x = rota_x(i, :);
    y = rota_y(i, :);
    index = rota_index(i, :);
    
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