function MinMaxPlot(minMaxArray, envelope)
% This function plots a graph of the envelope and extremum points
    figure
    plot(envelope)
    hold on
    axis tight
    plot(minMaxArray)
end