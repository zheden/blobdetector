function resultat = ColMed_NonMax(I)
% function resultat = ColMed_NonMax(I)
% Inputs :
% I : matrice 9*n
% 
% Output :
% resultat : 
%  = vecteur dont chaque composante i est le coeff (5,i) si ce coeff est
%  le max de la colonne i, 0 sinon.


% Fait par JB Fiot pour l'assignement 1 du cours 
% de Reconnaissance d'objets et vision artificielle

% Date : Oct. 2008

    if (size(I,1)==9)
        resultat = zeros(1,size(I,2));
    
        for i=1:size(I,2)
            if ((I(5,i)<I(1,i)) || (I(5,i)<I(2,i)) || (I(5,i)<I(3,i)) || (I(5,i)<I(4,i)) || (I(5,i)<I(6,i)) || (I(5,i)<I(7,i)) || (I(5,i)<I(8,i)) || (I(5,i)<I(9,i)))
                resultat(i) = 0;
            else
                resultat(i) = I(5,i);
            end
        end
        
    else
        resultat = 'ERREUR : ColMed_NonMax prend une matrice 9*n en entrée';
    end
        
