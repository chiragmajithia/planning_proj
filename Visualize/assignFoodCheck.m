function assignFoodCheck()
global seg
cnt = 0;
for i = 1:size(seg)
	cnt = cnt + size(seg(i).fw_loc,1);
	seg(i).visible(1);
	f = seg(i).fw_loc
    if(~isempty(f))
	plt = plot(f(:,1),f(:,2),'d');
	pause(1);
	delete(plt);
    end
	seg(i).visible(0);
end
sprintf('Total allocated food:: %d',cnt);
end