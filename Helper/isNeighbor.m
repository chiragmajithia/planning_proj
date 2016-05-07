function [ val ] = isNeighbor( A,B )
	res = 0.5;
	a = A;
	b = B;
	b(1) = B(1) - res;
	area1 = rectint(A,b);
	b(1) = B(1) + res;
	area2 = rectint(A,b);
	a(1) = A(1) - res;
	area3 = rectint(a,B);
	a(1) = A(1) + res;
	area4 = rectint(a,B);
	area = max([area1,area2,area3,area4]);
	if area > 0.0
		val = true;
	else
		val = false;
	end
end

