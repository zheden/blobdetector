% Master MVA
% Reconnaissance d'objets et Vision 
% Assignment 1 - Scale Invariant Blob Detection (SIBD)
% Jean-Baptiste FIOT


clear all;
clc;

display('========================================================================');
display('           SIBD - Méthode LoG par SubSampling successifs');
display('========================================================================');

img = imread('../Data/butterfly.jpg');
BWimg = rgb2gray(img);
[h,w] = size(BWimg);


% Scale-space
% ===========
display('Creating scale-space...');
tic;
n=10; %Nombre de niveaux du scale space
k = 2;

n = min([n,floor(log(h/2)/log(k)), floor(log(w)/log(k))]); % On met à jour le nombre max de niveau. On sous échantillonne au max jusqu'a une matrice 2*2.
display(sprintf('Updated number of scale-space levels: %d',n))
scale_space = zeros(h,w,n);
scale_space(:,:,1)=BWimg;

ratio_kernelsize_sigma = 4;

kernel=LoG_kernel(ratio_kernelsize_sigma,1);
  


for i=2:n
     % Le niveau i est un sous-échantillon du niveau précédent d'un facteur kx=ky=k
     % Pour le niveau i, on obtient une zone divisée par k^i par rapport à
     % l'image de départ.
     previous = scale_space(1:floor(h/k^(i-1)),1:floor(w/k^(i-1)),i-1);
     
     sub = SubSampling(previous,k,k);
     % On fait la convolution de ce sous-echantillon
     sub = conv2(sub,kernel,'same');
    % On stocke ce sous-échantillon dans la partie haut-gauche du niveau i
    % NB : pour le niveau i, la taille est donc la taille de l'image de
    % départ divisée par k^i
     scale_space(1:floor(h/k^i),1:floor(w/k^i),i) = sub;
     

      
end

for i=2:n % On normalise la partie haute
    scale_space(1:floor(h/k^i),1:floor(w/k^i),i) = scale_space(1:floor(h/k^i),1:floor(w/k^i),i).^2;
    scale_space(1:floor(h/k^i),1:floor(w/k^i),i) = scale_space(1:floor(h/k^i),1:floor(w/k^i),i)/mean(mean(scale_space(1:floor(h/k^i),1:floor(w/k^i),i)));
end

display(sprintf('-> Done in %.1f seconds.',toc));




% Non-maximum suppression
% =======================
display('Non-maximum suppression...');

display('...on scale slices...');
tic;
for i=1:n
    scale_space(1:floor(h/k^i),1:floor(w/k^i),i) = colfilt(scale_space(1:floor(h/k^i),1:floor(w/k^i),i),[3 3],'sliding',@ColMed_NonMax);
end
display(sprintf('-> Done in %.1f seconds.',toc));


display('...Interpoling scale slices to original size...');
for i=2:n % On interpole pour retrouver les bonnes tailles.
    scale_space(1:k^i*floor(h/k^i)-(k^i-1),1:k^i*floor(w/k^i)-(k^i-1),i) = interp2(1:k^i:k^i*floor(w/k^i),(1:k^i:k^i*floor(h/k^i))',scale_space(1:floor(h/k^i),1:floor(w/k^i),i),1:k^i*floor(w/k^i)-(k^i-1),(1:k^i*floor(h/k^i)-(k^i-1))');
end

display(sprintf('-> Done in %.1f seconds.',toc));

display('...last removal...');
tic;
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
threshold = 2.5;

for i=2:n
    [cxtmp,cytmp] = find(scale_space(:,:,i)>threshold);
    cx = [cx;cxtmp];
    cy = [cy;cytmp];
    rad = [rad;ones(size(cxtmp,1),1)*sqrt(2)*k^i];
end
display(sprintf('-> Done in %.1f seconds.',toc));


% Displaying the results
% ======================
display('Displaying...');
tic;
show_all_circles(BWimg,cy,cx,rad); 
display(sprintf('-> Done in %.1f seconds.',toc));