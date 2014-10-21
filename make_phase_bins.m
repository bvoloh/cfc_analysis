function [bins, centers] = make_phase_bins(nbins)

bins = zeros(2,nbins+1);

b = pi/nbins + (0:nbins/2-1)*pi/(nbins/2);

bins(:,1) = [-pi -b(end)];
bins(:,nbins+1) = [b(end) pi];
bins(:,nbins/2+1) = [-pi/nbins pi/nbins];
bins(:,nbins/2+2:end-1) = [b(1:end-1)' b(2:end)']';
bins(:,2:nbins/2) = flipud(fliplr(-bins(:,nbins/2+2:end-1)));

centers = mean(bins,1);  