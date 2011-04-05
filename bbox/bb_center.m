function center = bb_center(bb)
% Info

if isempty(bb)
	center = []; 
	return;
end

center = 0.5 * [bb(1,:)+bb(3,:); bb(2,:)+bb(4,:)];