%% StreetLearn dataset: Panorama to perspective images
clear all
add_path;
             
file_list = dir("../jpegs_manhattan_2019/") % path to streetlearn dataset panorama
% from pano to perspective image
for i = 1 : length(file_list)                
    field = char(file_list(i).name);
    if strcmp(field,'.') | strcmp(field, '..') | ~contains(field, '.jpg')
        % check image file
        fprintf('field %s', field);
        continue;                
    end            
    pano_id = field(1:end-4);
    saveDir = sprintf('../jpegs_manhattan_2019_pers/%s', pano_id);            
    fprintf("img %d/%d pano_id %s ", i, length(file_list), pano_id);

    %%% Project to perspective views
    % read image
    panoImg = im2double(imread(sprintf(...
                        '../jpegs_manhattan_2019/%s.jpg',...
                        pano_id)));

    % project it to multiple perspective views
    cutSize = 256; % size of perspective views
    fov = pi/2; % horizontal field of view of perspective views
    x = (rand(1, 200) - 0.5) * 2 * pi; % random yaw angles in range [-pi, pi]
    y = (rand(1,100)-0.5)*pi/2; % random pitch angles in range [-pi/4, pi/4]
    
    [sepScene] = separatePano_v2( panoImg, fov, x, y, cutSize, saveDir);
end