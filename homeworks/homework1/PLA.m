%provide the number of examples and a and b coefficients for target
%function (linear function: y = a*x + b)
%for example, PLA(20, 1, 0)
function PLA(num, a, b)
    %artificial coefficient
    x0 = ones(1, num);
    %points
    rng(1)    %can be changed
    x1 = randperm(num + 5, num);
    x2 = randperm(num + 5, num);
    %combining x0, x1, and x2 
    x = zeros(num, 3);
    for i = 1:num
        x(i, :) = [x0(i), x1(i), x2(i)];
    end
    
    %target function
    k = 0:num + 5;
    target_func = a*k + b;

    figure
    plot(k, target_func, 'g')    %color of target function is green
    
    hold on
    %labelling examples
    y = zeros(1, num);
    for i = 1:num
        if a*x1(i) + b < x2(i)
            y(i) = -1;
            plot(x1(i), x2(i), 'rx')    %red cross
        else    %points that are on target line are also labelled as +1
            plot(x1(i), x2(i), 'bo')    %blue circle
            y(i) = 1;
        end
    end

    %initialize weights with small numbers
    w = [0.001, 0.002, 0.003];

    %maximum number of iterations
    iter = 2000;
    
    %PLA
    for i=1:iter
        for j = 1:num
            if sign(w*(x(j, :))') ~= sign(y(j))    %w*x_transpose instead of w_transpose*x because row vectors are used
                w = w + y(j)*x(j, :); 
                break
            end
        end
        if j == num
            w_pla = w;
            break  
        end
    end
    
    num_of_iter = i;
    
    %final hypothesis in the form y = b + a*x
    g = w_pla(1)/(-w_pla(3)) + k*w_pla(2)/(-w_pla(3));
    plot(k, g, 'm')    %color of g is magenta

    title(['PLA for ', num2str(num), ' examples. The number of iterations is ', num2str(num_of_iter)])
    xlabel('x1')
    ylabel('x2')

end
