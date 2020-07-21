function [x, costs] = descent(A, b, eps, alpha, gamma, epochs, grad, cost)
    rate = 1e-4;
    x = ones(size(A,2),1);
    prev = cost(x, A, b, alpha, gamma);
    costs = prev;
    while epochs > 0 && rate > eps
        %disp(epochs);
        upd = x - rate * grad(x, A, b, alpha, gamma);
        now = cost(upd, A, b, alpha, gamma);
        if now < prev
            ref = x;
            x = upd;
            prev = now;
            rate = 1.23 * rate;
        else
            rate = 0.5 * rate;
        end
        epochs = epochs - 1;
        costs = [costs, prev];
    end
end