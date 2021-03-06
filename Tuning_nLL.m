function [ nLL ] = Tuning_nLL(params, spikes_vec, angle_vec, tuningFun)
%TUNING_NLL Negative log likelihood function for directional tuning curves.

% Optional fourth argument
if nargin < 4; tuningFun = []; end

% Compute tuning curve
if isempty(tuningFun)
    % Exponential-cosine tuning curve by default
    predictedF = exp(params(1)+params(2)*cos(angle_vec-params(3)));
else
    % Use custom-made tuning curve
    predictedF = tuningFun(params, angle_vec);
    
    % Should we add some check if predictedF behaves badly? (what's 'bad'?)
end

% Compute Poisson probability for each data point
logP = spikes_vec .* log(predictedF) - predictedF - log(factorial(spikes_vec));

% The expression below is a better way to compute it - why?
% logP = spikes .* log(predictedF) - predictedF - gammaln(spikes + 1);

% Return summed negative log likelihood
nLL = -sum(logP);

end

