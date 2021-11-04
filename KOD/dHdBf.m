% Charakterystyka magnestowania rdzenia 
function [H]=dHdBf(B)
H=1000+30*B^2+495*B^8;
end