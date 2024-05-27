// Returns a 0.0-1.0 value depending on the value of 'axis' 
// May be used to create a mask along a mesh

// !!!PARAMETERS!!!
// axis: mesh axis along which the wave will move (e.g VERTEX.x)
// mask_start: location of the mask start along the axis
// mask_gradient: how gradient the mask is relative to the axis


float body_mask(float axis, float mask_start, float mask_gradient){
	return smoothstep(mask_start,mask_gradient,1.0 - (axis+1.0)*0.5);
}
