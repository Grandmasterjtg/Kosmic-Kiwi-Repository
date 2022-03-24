extends Node

const ELLIPSE_A = 1.0
const ELLIPSE_B = 0.5

func angle_to_isometric_vector(angle : float = 0.0) -> Vector2:
	var e = sqrt(1-(pow(ELLIPSE_B,2)/pow(ELLIPSE_A,2)))
	var x = ELLIPSE_A*ELLIPSE_B/sqrt(pow(ELLIPSE_B,2)+pow(ELLIPSE_A,2)*pow(tan(angle),2))
	var y = x*tan(angle)
	if abs(angle) > PI / 2:
		x *= -1
		y *= -1
	return Vector2(x,y)

func vector_to_isometric_vector(direction : Vector2 = Vector2(0,0)) -> Vector2:
	var angle = 0.0
	if direction.y != 0:
		angle = atan(direction.x/direction.y)
	return angle_to_isometric_vector()
