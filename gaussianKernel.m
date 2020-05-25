% returns a gaussian kernel between x1 and x2
function sim = gaussianKernel(x1, x2, sigma)

% Ensure that x1 and x2 are column vectors
x1 = x1(:); x2 = x2(:);
sim = 0;

t = sum((x1 -x2).^2);
sim = exp(-t/(2*(sigma^2)));

end
