function [sepScene] = separatePano_v2( panoImg, fov, x, y, imgSize, saveDir, index)
%SEPARATEPANO project a panorama image into several perspective views
% panoImg: panorama image; fov: field of view;
% x,y: view direction of center of perspective views, in UV expression
% imgSize: size of perspective views
% saveDir: give if you want save result to disk

if length(x) ~= length(y)
    fprintf('x and y must be the same size.\n');
    return;
end
if length(fov)==1
    fov = fov * ones(length(x),1);
end
% if fov>pi
%     fprintf('I guess the fov is in deg, convert to rad :)\n');
%     fov = fov * pi / 180;
% end
% if ~isdouble('panoImg')
%     fprintf('Image is not double, convert to double and scale to 1 :)');
%     panoImg = double(panoImg)./255;
% end

numScene = length(x);
fprintf('%d\n', numScene)
% imgSize = 2*f*tan(fov/2);
% sepScene = zeros(imgSize, imgSize, 3, numScene);
sepScene(numScene) = struct('img',[],'vx',[],'vy',[],'fov',[],'sz',[]);
parfor i = 1:numScene
    if isfile(sprintf('%s/%03d.png', saveDir, index(i)))
        continue;
    end
    warped_image = imgLookAt(panoImg, x(i), y(i), imgSize, fov(i));
    sepScene(i).img = warped_image;
    sepScene(i).vx = x(i);
    sepScene(i).vy = y(i);
    sepScene(i).fov = fov(i);
    sepScene(i).sz = imgSize;
end

if exist('saveDir', 'var')
    if ~exist(saveDir, 'dir')
        mkdir(saveDir);
    end
    for i = 1:numScene
        if isnan(index(i))
            continue
        end
        if isfile(sprintf('%s/%03d.png', saveDir, index(i)))
            continue;
        end
        imwrite(sepScene(i).img, sprintf('%s/%03d.png', saveDir, index(i)), 'png');          
    end
    fprintf(' done\n');  
end


    