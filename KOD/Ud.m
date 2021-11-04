%%funkcja odpowiadająca za działanie czterech jednakowych diod 
function [Ud]=Ud(I)
Ron=0.1; 
Roff=1e6;
Up = 0.6;
Iw = Up/Roff;

if (I<Iw)
    Ud=Roff*I;
else
    Ud=Up+Ron*I;
end