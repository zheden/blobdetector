% Master MVA
% Reconnaissance d'objets et Vision 
% Assignment 1 - Scale Invariant Blob Detection (SIBD)
% Jean-Baptiste FIOT


clear all;
clc;

display('========================================================================');
display('SIBD - Méthode LoG par augmentation de la taille du noyau de convolution');
display('========================================================================');

img = imread('../Data/butterfly.jpg');
BWimg = rgb2gray(img);
[h,w] = size(BWimg);


% Scale-space
% ===========
display('Creating scale-space...');
tic;
n=10; 
scale_space = zeros(h,w,n);
scale_space(:,:,1)=BWimg;

ratio_kernelsize_sigma = 4;

tmp=scale_space;

for i=2:n
     kernel=LoG_kernel(ratio_kernelsize_sigma*i,i);
     scale_space(:,:,i)=conv2(scale_space(:,:,i-1),kernel,'same');
end

for i=2:n
    scale_space(:,:,i) = scale_space(:,:,i).^2;
    scale_space(:,:,i) = scale_space(:,:,i)/mean(mean(scale_space(:,:,i)));
end

display(sprintf('-> Done in %.1f seconds.',toc));




% Non-maximum suppression
% =======================
display('Non-maximum suppression...');
% Avec ces techniques la suppression des non maximum n'est pas tout à fait complète :
% il manque la comparaison avec les 8 coins sur chaque cube de 27.

display('...on scale slices...');
tic;

for i=1:n
    % on supprime tous les non maximum sur chaque tranche 2D / 3ème coord
     scale_space(:,:,i) = reshape(nlfilter(reshape(scale_space(:,:,i), [h w]), [3 3], @c8_non_max), [1 h w]);
    %scale_space(:,:,i) = colfilt(scale_space(:,:,i),[3 3],'sliding',@ColMed_NonMax);
end

display(sprintf('-> Done in %.1f seconds.',toc));
display('...on height slices...');
tic;
for i=1:h
    % idem avec les tranches 2D / 1ere coord
    % on doit faire des reshape pour remettre les données dans des
    % matrices pour utiliser c8_non_max
    
     scale_space(i,:,:) = reshape(nlfilter(reshape(scale_space(i,:,:), [w n]), [3 3], @c8_non_max), [1 w n]);
    %scale_space(i,:,:) = reshape(colfilt(reshape(scale_space(i,:,:), [w n]), [3 3],'sliding',@ColMed_NonMax), [1 w n]);
end

display(sprintf('-> Done in %.1f seconds.',toc));
display('...on width slices...');
tic;
for i=1:w
    % idem avec les tranches 2D / 2eme coord
     scale_space(:,i,:) = reshape(nlfilter(reshape(scale_space(:,i,:), [h n]), [3 3], @c8_non_max), [1 h n]);
    %scale_space(:,i,:) = reshape(colfilt(reshape(scale_space(:,i,:), [h n]), [3 3], 'sliding',@ColMed_NonMax), [1 h n]);
end
display(sprintf('-> Done in %.1f seconds.',toc));



% Getting the max
% ===============
display('Getting the extrema...');
tic;
cx=[];
cy=[];
rad=[];
threshold = 10;

for i=2:n
    [cxtmp,cytmp] = find(scale_space(:,:,i)>threshold);
    cx = [cx;cxtmp];
    cy = [cy;cytmp];
    rad = [rad;ones(size(cxtmp,1),1)*sqrt(2)*i];
end
display(sprintf('-> Done in %.1f seconds.',toc));


% Displaying the results
% ======================
display('Displaying...');
tic;
show_all_circles(BWimg,cy,cx,rad);
display(sprintf('-> Done in %.1f seconds.',toc));