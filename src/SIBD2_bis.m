% Master MVA
% Reconnaissance d'objets et Vision 
% Assignment 1 - Scale Invariant Blob Detection (SIBD)
% Jean-Baptiste FIOT


clear all;
clc;

display('========================================================================');
display('           SIBD - Méthode LoG par SubSampling successifs');
display('========================================================================');

img = imread('../Data/apples.jpg');
BWimg = rgb2gray(img);
[h,w] = size(BWimg);


% Scale-space
% ===========
display('Creating scale-space...');
tic;
n=15; %Nombre de niveaux du scale space

scale_space = zeros(h,w,n);
scale_space(:,:,1)=BWimg;

ratio_kernelsize_sigma = 4;

kernel=LoG_kernel(ratio_kernelsize_sigma,1);
  


for i=2:n
     scale_space(1:floor(h/i),1:floor(w/i),i) = conv2(SubSampling(scale_space(:,:,1),i,i),kernel,'same');
end

for i=2:n % On normalise la partie haute
    scale_space(1:floor(h/i),1:floor(w/i),i) = scale_space(1:floor(h/i),1:floor(w/i),i).^2;
    scale_space(1:floor(h/i),1:floor(w/i),i) = scale_space(1:floor(h/i),1:floor(w/i),i)/mean(mean(scale_space(1:floor(h/i),1:floor(w/i),i)));
end

display(sprintf('-> Done in %.1f seconds.',toc));


% Non-maximum suppression
% =======================
display('Non-maximum suppression...');

display('...on scale slices...');
tic;

for i=1:n
    scale_space(1:floor(h/i),1:floor(w/i),i) = colfilt(scale_space(1:floor(h/i),1:floor(w/i),i),[3 3],'sliding',@ColMed_NonMax);
end
display(sprintf('-> Done in %.1f seconds.',toc));


display('...Interpoling scale slices to original sizes...');
tic;
for i=2:n % On interpole pour retrouver les bonnes tailles.
    scale_space(1:i*floor(h/i)-(i-1),1:i*floor(w/i)-(i-1),i) = interp2(1:i:i*floor(w/i),(1:i:i*floor(h/i))',scale_space(1:floor(h/i),1:floor(w/i),i),1:i*floor(w/i)-(i-1),(1:i*floor(h/i)-(i-1))'); 
end
display(sprintf('-> Done in %.1f seconds.',toc));

display('...last removal...');

for i=1:h
    for j=1:w
        for k=1:n
            if scale_space(i,j,k) ~= 0
                scale_space(i,j,k) = c26_non_max(vblock(scale_space,i,j,k));
            end
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
threshold = 3;

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