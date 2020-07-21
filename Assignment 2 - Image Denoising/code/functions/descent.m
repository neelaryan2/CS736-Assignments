function [noisy, costs] = descent(ref, eps, alpha, gamma, epochs, grad, cost)
    rate = 1e-4; noisy = ref;
    prev = cost(noisy, ref, alpha, gamma);
    costs = prev;
    while epochs > 0 && rate > eps
        upd = noisy - rate * grad(noisy, ref, alpha, gamma);
        now = cost(upd, ref, alpha, gamma);
        if now < prev
            ref = noisy;
            noisy = upd; prev = now; 
            rate = 1.1 * rate;
        else rate = 0.5 * rate; end
        epochs = epochs - 1;
        costs = [costs, prev];
    end
end