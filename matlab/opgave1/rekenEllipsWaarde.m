function [xOut,y] = rekenEllipsWaarde(a,b,c,d,e,f,xIn)
%rekenEllipsWaarde Berekent waarde van ellips afhankelijk van
%coefficienten.
%   Detailed explanation goes here

columnOfOnes = ones(size(xIn,1),1);

xOut = [xIn;xIn];
y1 = (-(2*b.*xIn +e.*columnOfOnes) + sqrt((2*b.*xIn+e.*columnOfOnes).^2-4*c*(a.*xIn.*xIn+d.*xIn + f*columnOfOnes)))./(2*c);
y2 = (-(2*b.*xIn +e.*columnOfOnes) - sqrt((2*b.*xIn+e.*columnOfOnes).^2-4*c*(a.*xIn.*xIn+d.*xIn + f*columnOfOnes)))./(2*c);
y = [y1;y2];



end

