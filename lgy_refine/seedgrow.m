function osvos_seed_grow = seedgrow(osvosres,osvos_bbox,height_all,weight_all,station,break_num)
% %% 种子点生长
break_num = break_num+1;
if break_num >= 450
    osvos_seed_grow = osvosres;
else
osvos_bbox_pe = osvos_bbox;
seednum = length(height_all);
k = 0;
for seedIndex = 1:seednum
    if station(seedIndex) == 0
       [osvos_bbox,add] = eightfile(osvos_bbox,osvosres,height_all(seedIndex),weight_all(seedIndex));
    else
        add = 0;
    end
    if add > 0
        station(seedIndex) = 1;
    end
    k = k+add;
end
if k == 0
    osvos_seed_grow = osvos_bbox;
else
    osvos_bbox_new = osvos_bbox;
    osvos_bbox(find(osvos_bbox_pe==1)) = 0;
    [height_new,weight_new] = find(osvos_bbox==1);
    seednum_new = length(height_new);
%     station_new = [station,zeros(1,seednum_new)];
    station_new = zeros(1,seednum_new);
    osvos_seed_grow_second = seedgrow(osvosres,osvos_bbox_new,height_new,weight_new,station_new,break_num);
    osvos_seed_grow = osvos_seed_grow_second;
end
end

end

function [osvos_bbox,add] = eightfile(osvos_bbox,osvosres,height,weight)

add = 0;
[h,w] = size(osvosres);

%left
if weight>1&& osvosres(height,weight-1) == 1
    osvos_bbox(height,weight-1) = 1;
    add = add+1;
end

%upper left
if height>1&& weight>1 && osvosres(height-1,weight-1) == 1
    osvos_bbox(height-1,weight-1) = 1;
    add = add+1;
end

%bottom left
if height<h && weight>1 && osvosres(height+1,weight-1) == 1
    osvos_bbox(height+1,weight-1) = 1;
    add = add+1;
end

%upper
if height>1 && osvosres(height-1,weight) == 1
    osvos_bbox(height-1,weight) = 1;
    add = add+1;
end

%bottom
if height<h && osvosres(height+1,weight) == 1
    osvos_bbox(height+1,weight) = 1;
    add = add+1;
end

%right
if weight<w && osvosres(height,weight+1) == 1
    osvos_bbox(height,weight+1) = 1;
    add = add+1;
end

%upper right
if height>1&& weight<w && osvosres(height-1,weight+1) == 1
    osvos_bbox(height-1,weight+1) = 1;
    add = add+1;
end

%bottom right
if height<h && weight<w && osvosres(height+1,weight+1) == 1
    osvos_bbox(height+1,weight+1) = 1;
    add = add+1;
end

end