% Master MVA
% Reconnaissance d'objets et Vision 
% Assignment 1 - Scale Invariant Blob Detection (SIBD)
% Jean-Baptiste FIOT


clear all;
clc;

display('========================================================================');
display('SIBD - Méthode LoG par augmentation de la taille du noyau de convolution');
display('========================================================================');

img = imread('../Data/fishes.jpg');
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

tic;

for i=1:h
    for j=1:w
        for k=1:n
            scale_space(i,j,k) = c26_non_max(vblock(scale_space,i,j,k));
        end
    end
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