%
% Fait par JB Fiot pour l'assignement 1 du cours 
% de Reconnaissance d'objets et vision artificielle

% Date : Oct. 2008

% Inputs :
% I : matrice m*n
% kx : coefficient de sous-échantillonage suivant x
% ky : coefficient de sous-échantillonage suivant x

% Output :
% resultat : matrice de taille floor(m/kx)*floor(n/ky)


function resultat = SubSampling(I,kx,ky)
    new_size = [floor(size(I,1)/kx),floor(size(I,2)/ky)];
    resultat = zeros(new_size);
    for i=1:new_size(1)
        for j=1:new_size(2)
            resultat(i,j) = mean(mean(I([1+kx*(i-1) kx*i],[1+ky*(j-1) ky*j])));
        end
    end

