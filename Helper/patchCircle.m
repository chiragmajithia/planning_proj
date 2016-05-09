function [mat] = patchCircle(r,x0,y0,id,mat)
	dx = size(mat,1);
	dy = size(mat,2);

	[columnsInImage rowsInImage] = meshgrid(1:dy,1:dx);
	circlePixels = (rowsInImage - x0).^2 + (columnsInImage - y0).^2 <= r.^2;
	mat(circlePixels) = 10;
end