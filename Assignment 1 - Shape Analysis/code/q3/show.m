function show(shape, w)
    shape = reshape(shape, [], 2);
    if w>1
        plot([shape(:,1); shape(1,1)], [shape(:,2); shape(1,2)], '-k','LineWidth',w/2);
    else
        plot([shape(:,1); shape(1,1)], [shape(:,2); shape(1,2)]);
    end
end