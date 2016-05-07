function [ dg ] = configSegGraph(seg)
dg = sparse(size(seg,1),0);
	for i = 1:size(seg,1)
		source = seg(i);
		for j = 1:size(source.n,1)
			dg(i,source.n(j)) = size(source.p2n{source.n(j)},1);
            sprintf('%d,%d',i,source.n(j))
            %input('check');
		end
    end
     h = view(biograph(dg))
     %input('check');
end

