function out = align(ref, shape)
    orig = ref;
    shape = reshape(shape, [], 2); ref = reshape(ref, [], 2);
    % translation
    ref = ref - mean(ref); shape = shape - mean(shape);
    scal = sumsqr(shape);
    x1x2 = sum(ref(:, 1) .* shape(:, 1)) / scal;
    y1y2 = sum(ref(:, 2) .* shape(:, 2)) / scal;
    x2y1 = sum(ref(:, 2) .* shape(:, 1)) / scal;
    y2x1 = sum(ref(:, 1) .* shape(:, 2)) / scal;
    % rotation
    a = x1x2 + y1y2; b = x2y1 - y2x1; out1 = shape;
    out1(:, 1) = a * shape(:, 1) - b * shape(:, 2);
    out1(:, 2) = b * shape(:, 1) + a * shape(:, 2);
    out1 = reshape(out1 + mean(orig), 1, []); out = out1;
    % reflection + rotation
    a = x1x2 - y1y2; b = x2y1 + y2x1; out2 = shape;
    out2(:, 1) = a * shape(:, 1) + b * shape(:, 2);
    out2(:, 2) = b * shape(:, 1) - a * shape(:, 2);
    out2 = reshape(out2 + mean(orig), 1, []);
    % select best of both
    if (norm(out2 - orig) < norm(out1 - orig))
        out = out2;
    end
    % [~, out] = procrustes(ref, shape);
    % out = reshape(out, 1, []);
end
