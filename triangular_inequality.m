function bool = triangular_inequality(a,b,c)
bool = 0;
if ((a>abs(b-c)) && (a<b+c) && (b>abs(a-c)) && (b<a+c) && (c>abs(b-a)) && (c<a+b)) || (a == 0 || b == 0 || c == 0)
    bool = 1;
end
end