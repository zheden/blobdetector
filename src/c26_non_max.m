%
% Fait par JB Fiot pour l'assignement 1 du cours 
% de Reconnaissance d'objets et vision artificielle

% Date : Oct. 2008

% Inputs :
% I : taleau 3*3*3

% Output :
% resultat : 
%  = coeff central du tableau en entrée
%    si ce coeff est sup à tous les autres 
%  = 0 sinon
% 


function resultat = c26_non_max(I)
    if (size(I)==[3,3,3])
        
        if (I(2,2,2)<I(1,1,1) || I(2,2,2)<I(1,1,2) || I(2,2,2)<I(1,1,3) || I(2,2,2)<I(1,2,1) || I(2,2,2)<I(1,2,2) || I(2,2,2)<I(1,2,3) || I(2,2,2)<I(1,3,1) || I(2,2,2)<I(1,3,2) || I(2,2,2)<I(1,3,3) || I(2,2,2)<I(2,1,1) || I(2,2,2)<I(2,1,2) || I(2,2,2)<I(2,1,3) || I(2,2,2)<I(2,2,1) || I(2,2,2)<I(2,2,3) || I(2,2,2)<I(2,3,1) || I(2,2,2)<I(2,3,2) || I(2,2,2)<I(2,3,3) || I(2,2,2)<I(3,1,1) || I(2,2,2)<I(3,1,2) || I(2,2,2)<I(3,1,3) || I(2,2,2)<I(3,2,1) || I(2,2,2)<I(3,2,2) || I(2,2,2)<I(3,2,3) || I(2,2,2)<I(3,3,1) || I(2,2,2)<I(3,3,2) || I(2,2,2)<I(3,3,3) ) 
            resultat = 0;
        else
            resultat = I(2,2,2);
        end
    else
        resultat = 'ERREUR : c26_non_max prend une tableau 3*3*3 en entrée';
    end
        
