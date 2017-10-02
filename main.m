clear;clc;
itemName = ['a','b','c','R','r','A','B','C','S'];
item = zeros(1,9);
itemTmp = zeros(1,9);
fprintf('\tOrder of elements: a, b, c, R, r, A, B, C, S \n\tElements you want to set value?: ');
itemSelect = input('');
itemCnt = length(itemSelect);
for i = 1:itemCnt
    fprintf('\t- Value of %s: ',itemName(itemSelect(i)));
    item(itemSelect(i)) = input('');
end

if (~triangular_inequality(item(1),item(2),item(3)))
    disp('!---Invalid inputs (Triangular inequality unsatisfied)---!');
    return;
end
% convert deg into rad
for i = 6:8
    item(i) = item(i)*pi/180;
end

syms a b c R r A B C S positive;
eqn1 = 'r - sqrt((a+b-c)*(b+c-a)*(c+a-b)/4/(a+b+c))';
eqn2 = 'a - 2*R*sin(A)';
eqn3 = 'b - 2*R*sin(B)';
eqn4 = 'c - 2*R*sin(C)';
eqn5 = 'a - sqrt(b^2+c^2 - 2*b*c*cos(A))';
eqn6 = 'b - sqrt(a^2+c^2 - 2*a*c*cos(B))';
eqn7 = 'c - sqrt(b^2+a^2 - 2*b*a*cos(C))';
eqn8 = 'S - a*b*sin(C)/2';
eqn9 = 'S - b*c*sin(A)/2';
eqn10 = 'S - c*a*sin(B)/2';
eqn11 = 'S - a*b*c/4/R';
eqn12 = 'r - 2*S/(a+b+c)';
eqn13 = 'A + B + C - pi';

cnt = 1;
while (~isequal(itemTmp,item))
    itemTmp = item;
    for i = 1:cnt
        % calculate a
        if (item(i,1) == 0)
            if (item(i,2) && item(i,3) && item(i,5))
                tmp = solve(subs(eqn1,[b c r],[item(i,2) item(i,3) item(i,5)]),a);
                if (length(tmp) > 1)
                    cnt = length(tmp);
                    for j = 2:cnt
                        item(j,:) = item(1,:);
                    end
                    item(:,1) = tmp(:,1);
                end
            elseif (item(i,4) && item(i,6)) item(i,1) = solve(subs(eqn2,[R A],[item(i,4) item(i,6)]),a);
            elseif (item(i,2) && item(i,3) && item(i,6)) item(i,1) = solve(subs(eqn5,[b c A],[item(i,2) item(i,3) item(i,6)]),a);
            elseif (item(i,2) && item(i,8) && item(i,9)) item(i,1) = solve(subs(eqn8,[b C S],[item(i,2) item(i,8) item(i,9)]),a);
            elseif (item(i,3) && item(i,7) && item(i,9)) item(i,1) = solve(subs(eqn10,[b C S],[item(i,2) item(i,7) item(i,9)]),a);
            elseif (item(i,2) && item(i,3) && item(i,4) && item(i,9)) item(i,1) = solve(subs(eqn11,[b c R S],[item(i,2) item(i,3) item(i,4) item(i,9)]),a);
            elseif (item(i,2) && item(i,3) && item(i,5) && item(i,9)) item(i,1) = solve(subs(eqn12,[b c r S],[item(i,2) item(i,3) item(i,5) item(i,9)]),a);
            end
        end
        
        % calculate b
         if (item(i,2) == 0)
            if (item(i,1) && item(i,3) && item(i,5))
                tmp = solve(subs(eqn1,[r a c],[item(i,5) item(i,1) item(i,3)]),b);
                    cnt = length(tmp);
                    for j = 1:cnt
                        item(j,:) = item(1,:);
                    end
                    item(:,2) = tmp(:,1);
            elseif (item(i,4) && item(i,7)) item(i,2) = solve(subs(eqn3,[R B],[item(i,4) item(i,7)]),b);
            elseif (item(i,1) && item(i,3) && item(i,7)) item(i,2) = solve(subs(eqn6,[a c B],[item(i,1) item(i,3) item(i,7)]),b);
            elseif (item(i,1) && item(i,8) && item(i,9)) item(i,2) = solve(subs(eqn8,[a C S],[item(i,1) item(i,8) item(i,9)]),b);
            elseif (item(i,3) && item(i,6) && item(i,9)) item(i,2) = solve(subs(eqn9,[c A S],[item(i,3) item(i,6) item(i,9)]),b);
            elseif (item(i,1) && item(i,3) && item(i,4) && item(i,9)) item(i,2) = solve(subs(eqn11,[a c R S],[item(i,1) item(i,3) item(i,4) item(i,9)]),b);
            elseif (item(i,1) && item(i,3) && item(i,5) && item(i,9)) item(i,2) = solve(subs(eqn12,[a c r S],[item(i,1) item(i,3) item(i,5) item(i,9)]),b);
            end
         end
         
         % calculate c
         if (item(i,3) == 0)
            if (item(i,1) && item(i,2) && item(i,5))
                tmp = solve(subs(eqn1,[r b a],[item(i,5) item(i,2) item(i,1)]),c);
                    cnt = length(tmp);
                    for j = 1:cnt
                        item(j,:) = item(1,:);
                    end
                    item(:,3) = tmp(:,1);
            elseif (item(i,4) && item(i,8)) item(i,3) = solve(subs(eqn4,[R C],[item(i,4) item(i,8)]),c);
            elseif (item(i,2) && item(i,1) && item(i,8)) item(i,3) = solve(subs(eqn7,[b a C],[item(i,2) item(i,1) item(i,8)]),c);
            elseif (item(i,2) && item(i,6) && item(i,9)) item(i,3) = solve(subs(eqn9,[b A S],[item(i,2) item(i,6) item(i,9)]),c);
            elseif (item(i,1) && item(i,8) && item(i,9)) item(i,3) = solve(subs(eqn10,[a C S],[item(i,1) item(i,8) item(i,9)]),c);
            elseif (item(i,2) && item(i,1) && item(i,4) && item(i,9)) item(i,3) = solve(subs(eqn11,[b a R S],[item(i,2) item(i,1) item(i,4) item(i,9)]),c);
            elseif (item(i,2) && item(i,1) && item(i,5) && item(i,9)) item(i,3) = solve(subs(eqn12,[b a r S],[item(i,2) item(i,1) item(i,5) item(i,9)]),c);
            end
         end
        
         % calculate R
         if (item(i,4) == 0)
            if (item(i,1) && item(i,6)) item(i,4) = solve(subs(eqn2,[a A],[item(i,1) item(i,6)]),R);
            elseif (item(i,2) && item(i,7)) item(i,4) = solve(subs(eqn3,[b B],[item(i,2) item(i,7)]),R);
            elseif (item(i,3) && item(i,8)) item(i,4) = solve(subs(eqn4,[c C],[item(i,3) item(i,8)]),R);
            elseif (item(i,1) && item(i,2) && item(i,3) && item(i,9)) item(i,4) = solve(subs(eqn11,[a b c S],[item(i,1) item(i,2) item(i,3) item(i,9)]),R);
            end
         end
         
         % calculate r
         if (item(i,5) == 0)
             if (item(i,1) && item(i,2) && item(i,3)) item(i,5) = solve(subs(eqn1,[a b c],[item(i,1) item(i,2) item(i,3)]),r);
             elseif (item(i,1) && item(i,2) && item(i,3) && item(i,9)) item(i,5) = solve(subs(eqn12,[a b c S],[item(i,1) item(i,2) item(i,3) item(i,9)]),r);
             end
         end
         
         % calculate A
         if (item(i,6) == 0)
             syms tmpA
             if (item(i,1) && item(i,4)) item(i,6) = asin(solve(subs(eqn2,[a R sin(A)],[item(i,1) item(i,4) tmpA]),tmpA));
             elseif (item(i,1) && item(i,2) && item(i,3)) item(i,6) = acos(solve(subs(eqn5,[a b c cos(A)],[item(i,1) item(i,2) item(i,3) tmpA]),tmpA));
             elseif (item(i,2) && item(i,3) && item(i,9)) item(i,6) = asin(solve(subs(eqn9,[b c S sin(A)],[item(i,2) item(i,3) item(i,9) tmpA]),tmpA));
             elseif (item(i,7) && item(i,8)) item(i,6) = solve(subs(eqn13,[B C],[item(i,7) item(i,8)]),A);
             end
         end
         
         % calculate B
         syms tmpB;
         if (item(i,7) == 0)
             if (item(i,2) && item(i,4)) item(i,7) = asin(solve(subs(eqn3,[b R sin(B)],[item(i,2) item(i,4) tmpB]),tmpB));
             elseif (item(i,1) && item(i,2) && item(i,3)) item(i,7) = acos(solve(subs(eqn6,[a b c cos(B)],[item(i,1) item(i,2) item(i,3) tmpB]),tmpB));
             elseif (item(i,1) && item(i,3) && item(i,9)) item(i,7) = asin(solve(subs(eqn10,[a c S sin(B)],[item(i,1) item(i,3) item(i,9) tmpB]),tmpB));
             elseif (item(i,6) && item(i,8)) item(i,7) = solve(subs(eqn13,[A C],[item(i,6) item(i,8)]),B);
             end
         end
         
         % calculate C
         if (item(i,8) == 0)
             syms tmpC;
             if (item(i,3) && item(i,4)) item(i,8) = asin(solve(subs(eqn4,[c R sin(C)],[item(i,3) item(i,4) tmpC]),tmpC));
             elseif (item(i,1) && item(i,2) && item(i,3)) item(i,8) = acos(solve(subs(eqn7,[a b c cos(C)],[item(i,1) item(i,2) item(i,3) tmpC]),tmpC));
             elseif (item(i,1) && item(i,2) && item(i,9)) item(i,8) = asin(solve(subs(eqn8,[a b S sin(C)],[item(i,1) item(i,2) item(i,9) tmpC]),tmpC));
             end
         end
         
         % calculate S
         if (item(i,9) == 0)
             if (item(i,1) && item(i,2) && item(i,8)) item(i,9) = solve(subs(eqn8,[a b C],[item(i,1) item(i,2) item(i,8)]),S);
             elseif (item(i,2) && item(i,3) && item(i,6)) item(i,9) = solve(subs(eqn9,[b c A],[item(i,2) item(i,3) item(i,6)]),S);
             elseif (item(i,3) && item(i,1) && item(i,7)) item(i,9) = solve(subs(eqn10,[c a B],[item(i,3) item(i,1) item(i,7)]),S);
             elseif (item(i,1) && item(i,2) && item(i,3) && item(i,4)) item(i,9) = solve(subs(eqn11,[a b c R],[item(i,1) item(i,2) item(i,3) item(i,4)]),S);
             elseif (item(i,1) && item(i,2) && item(i,3) && item(i,5)) item(i,9) = solve(subs(eqn12,[a b c r],[item(i,1) item(i,2) item(i,3) item(i,5)]),S);
             elseif (item(i,6) && item(i,7)) item(i,8) = solve(subs(eqn13,[A B],[item(i,6) item(i,7)]),C);
             end
         end
    end
end
fprintf('\t---Activated elements---\n\n');
for i = 1:size(item,1)
    for j = 1:length(item)
        if (j == 6 || j == 7 || j == 8)
            item(i,j) = item(i,j)/pi*180;
        end
        fprintf('\tValue of %s: %f\n',itemName(j),item(i,j));
    end
    if (i<size(item,1))
        fprintf('\n\t---Other Values---\n\n');
    end
end