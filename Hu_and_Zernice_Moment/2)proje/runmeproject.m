close all; clear all; clc;
dbg = ~true;
db = '../_db/';
db_64x64_fg = strcat(db, '64x64/Our_Foreground/');

dip_initialise('silent');

%% Datastore
load(strcat(db, 'datastore_64x64.mat'));

%% Seperation Points
% Ground Truth'lari yukle ve uzerine hesaplananlari ekle
%load(strcat(db, 'seperation_points_ground_truth.mat'));

psz = size(etiket, 3);
for pi=1:psz
    if true, fprintf('%03d/%03d. kisi isleniyor...\n', pi, psz); end

    ssz = cellsize(etiket, pi);
    for si=1:ssz
        if true, fprintf('\t%1d/%1d. seq isleniyor...\n', si, ssz);  end

        clear seq_frms;
        fsz = cellsize(etiket, pi, si);
        for fi=1:fsz
            if true, fprintf('\t\t%03d/%03d. frame isleniyor...\n', fi, fsz);    end
            
            bw = imread(strcat(db_64x64_fg, db64x64_fnms{fi, si, pi}));
            seq_frms(:,:,fi) = bw
          
            features{fi, si, pi}.project = extract_features(bw, dbg)
        end
    end
end

%% Save
info = 'features{fi,si,pi}.project';
save(strcat(db, 'features.mat'), 'features', 'info');
