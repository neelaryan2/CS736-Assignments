function filt_rad = myFilter(rad, L,filter)
    four_trnsf = fft(rad);
    four_trnsf = fftshift(four_trnsf,1);
    filt_trnsf = zeros(size(four_trnsf));
    freq = -1 : 2/(size(four_trnsf,1)-1) : 1;
    for i = 1:size(four_trnsf,1)
        f = freq(i);
        if abs(f) > L
            filt_trnsf(i,:)=0;
        else
            if strcmp(filter,'Ram-Lak')
                fac = 1;
            elseif strcmp(filter,'Shepp-Logan')
                if f == 0
                    fac = 0;
                else
                    fac = sin(0.5*pi*f/L)/(0.5*pi*f/L);
                end
            elseif strcmp(filter,'Cosine')
                fac = cos(0.5*pi*f/L);
            end
            filt_trnsf(i,:)=four_trnsf(i,:)*abs(f)*fac;
        end
    end
    filt_trnsf = ifftshift(filt_trnsf,1);
    filt_rad = real(ifft(filt_trnsf));
end