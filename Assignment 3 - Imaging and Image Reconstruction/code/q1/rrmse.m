function out = rrmse(a,b)
    % following the definition mentioned in assignment
    out = sqrt(sumsqr(a-b)/sumsqr(a));
end

