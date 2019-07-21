function bounds_out = CutWord(curve, maxStep, minStep, iterNum, pointNum)
% determines local minima on the curve by the method of fastest descent with decreasing step
    % starting points are randomly selected
    startPoints = fix( rand(pointNum, 1) .* size(curve, 1) );
    % transition from maxStep to minStep
    step = fix( linspace(maxStep, minStep, iterNum) );
    % initialization
    bounds = startPoints;
    
    % finding local minima
    % pointNum random points raise local minima
    for i = 1:pointNum
        for j = 1:iterNum
            if ( bounds(i) + step(j) ) > size(curve, 1)
                bounds(i) = size(curve, 1);
                break;
            elseif ( bounds(i) - step(j) ) < 1
                bounds(i) = 1;
                break;
            elseif ( curve(bounds(i) + step(j)) < curve(bounds(i)) )
                bounds(i) = bounds(i) + step(j);
            elseif ( curve(bounds(i) - step(j)) < curve(bounds(i)) )
                bounds(i) = bounds(i) - step(j);
            end
        end
    end
    
    % local minimum has more than 0 hits
    sum(1:size(curve, 1)) = 0;
    sum = sum';
    for i = 1:size(bounds, 1)
        sum(bounds(i)) = sum(bounds(i)) + 1;
    end
    
    % new array of local minima without zeros
    j = 1;
    for i = 1:size(sum, 1)
        if sum(i) > 0
            bounds_preOut(j) = i;
            j = j + 1;
        end
    end
    bounds_preOut = bounds_preOut';
    
    % if the two local minima are too close to each other, take the minima with the minimum value
    % repeat until such points disappear
    minDist = maxStep;
    success = 0;
    while ~success
        success = 1;
        i = 1;
        j = 1;
        
        while ( i < length(bounds_preOut) )
            if ( bounds_preOut(i + 1) - bounds_preOut(i) < minDist )
                if ( curve( bounds_preOut(i + 1) ) < curve( bounds_preOut(i) ) )
                    bounds_out(j) = bounds_preOut(i + 1);
                else
                    bounds_out(j) = bounds_preOut(i);
                end
                i = i + 2;
                success = 0;
            else
                bounds_out(j) = bounds_preOut(i);
                i = i + 1;
            end
            j = j + 1;
        end
        % last point
        bounds_out(j) = bounds_preOut(end);
        
        bounds_preOut = bounds_out;
        bounds_out = [];
    end
    
    bounds_out = bounds_preOut';