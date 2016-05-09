function [ indx ] = roulette( weights )
visual_run = 1;
cdf = [0];
n = max(size(weights));
for i = 1 : n
    cdf = [cdf,cdf(end)+weights(i)];
end
cdf = cdf / sum(weights);
cdf = cdf(2:end);

i = rand();
indx = find(cdf > i);
if(visual_run)
	h = figure;
    str = {};
    for i = 1 : n
        str{i} = int2str(i);
    end
    explode = zeros(size(cdf));
    explode(indx(1)) = 1;
    pie(weights,explode,str);
    title('Roullete')
    pause(1);
    close(h);
end
end

