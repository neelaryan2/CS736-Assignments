function m = meanShape(shapes)
    n = size(shapes, 1);
    d = size(shapes, 2);
    threshold = 1e-9; conv = Inf; 
    init = shapes(2,:); iter = 0;
    m = d*init/sumsqr(init);
    while conv > threshold && iter < 50 
        iter = iter+1; sum = zeros(1, d);
        for i=1:n
            sum = sum + align(m, shapes(i, :))/n;
        end
        sum = d*sum/norm(sum);
        conv = norm(sum-align(sum, m));
        m = sum;
    end
end
