function  segGenVer(indx,n,thres)
	global map_handle seg
	[pw,ps] = seg(indx).generateVertices(n,thres);
    pw
    ps
	figure(map_handle);
	pltw = plot(pw(:,1),pw(:,2),'*');
    fig = figure;
	h = imshow(seg(indx).food_map');
	ps = plot(ps(:,1),ps(:,2),'*');
	input('check');
	delete(pltw);
	delete(h);
    delete(ps);
    close(fig)
end

