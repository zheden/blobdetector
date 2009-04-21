%
% Fait par JB Fiot pour l'assignement 1 du cours 
% de Reconnaissance d'objets et vision artificielle

% Date : Oct. 2008

% Inputs :
% I : taleau h*w*n
% i,j,k : coordonnées d'un élément

% Output :
% resultat : 
%  tableau 3*3*3 centré sur le point de coordonnées (i,j,k), zero-paddé au
%  besoin.
% 

function resultat = vblock(I,i,j,k)
    resultat=zeros(3,3,3);

    resx = max(1,i-size(I,1)+2):min(3,i+1);
    Ix = max(1,i-1):min(size(I,1),i+1);
    
    resy = max(1,j-size(I,2)+2):min(3,j+1);
    Iy = max(1,j-1):min(size(I,2),j+1); 
    
    resz = max(1,k-size(I,3)+2):min(3,k+1);
    Iz = max(1,k-1):min(size(I,3),k+1);
  


%      display('k stuff');
%     max(3-k,1)
%     min(5-k,3)
%     max(1,k-1)
%     min(size(I,3),k+1)
%     
%          display('test eg');
%     [max(3-i,1):min(5-i,3),max(3-j,1):min(5-j,3),max(3-k,1):min(5-k,3)] == [max(1,i-1):min(size(I,1),i+1),max(1,j-1):min(size(I,2),j+1),max(1,k-1):min(size(I,3),k+1)]
%          display('fin test eg');
%          
   resultat(resx,resy,resz) = I(Ix,Iy,Iz);
