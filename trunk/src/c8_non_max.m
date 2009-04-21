function resultat = c8_non_max(I)
% function resultat = c8_non_max(I)
% 
% Inputs :
%   I : matrice 3*3
% 
% Output :
%   resultat : 
%       = coeff central de la matrice en entrée
%           si ce coeff est sup à tous les autres 
%       = 0 sinon
 

% Fait par JB Fiot pour l'assignement 1 du cours 
% de Reconnaissance d'objets et vision artificielle

% Date : Oct. 2008

    if (size(I)==[3,3])
        
        if (I(2,2)<I(1,1)) | (I(2,2)<I(1,1)) | (I(2,2)<I(1,3)) | (I(2,2)<I(1,2)) | (I(2,2)<I(1,3)) | (I(2,2)<I(3,1)) | (I(2,2)<I(3,2)) | (I(2,2)<I(3,3))
            resultat = 0;
        else
            resultat = I(2,2);
        end
    else
        resultat = 'ERREUR : 8c_non_local prend une matrice 3*3 en entrée';
    end
        
