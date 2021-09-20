extends Node2D

var not_on_polygon := []
var polygon := PoolVector2Array([
	Vector2(40, 40), 
	Vector2(200, 40), 
	Vector2(200, 160), 
	Vector2(160, 160), 
	Vector2(160, 200),
	Vector2(40, 200)])

var polygon2 = PoolVector2Array()
var polygon3 = PoolVector2Array()


func _ready():
	
	# keep a record of points in the polygon which aren't "in" the polygon
	record_points_not_in_polygon(polygon)
	
	# make a larger polygon to the right
	for point in polygon:
		polygon2.append(Vector2(point.x * 1.1 + 300, point.y * 1.1))
	
	# keep a record of points in the polygon which aren't "in" the second polygon
	record_points_not_in_polygon(polygon2)
	
	# make a larger polygon to the bottom
	for point in polygon:
		polygon3.append(Vector2(point.x * 1.2, point.y * 1.2 + 300))
	
	# keep a record of points in the polygon which aren't "in" the third polygon
	record_points_not_in_polygon(polygon3)
		
	
	update()


func _draw():
	_draw_polygon(polygon)
	_draw_polygon(polygon2)
	_draw_polygon(polygon3)
	
	for point in not_on_polygon:
		draw_circle(point, 6, Color.yellow)
	
	_draw_poly_endpoints(polygon)
	_draw_poly_endpoints(polygon2)
	_draw_poly_endpoints(polygon3)


func _draw_polygon(poly: PoolVector2Array):
	draw_polygon(poly, PoolColorArray([Color.lightblue]))


func _draw_poly_endpoints(poly: PoolVector2Array):
	"""Indicate poly start/end vertices with coloured dots.
	
	Start vertex: green
	End vertex: blue
	"""
	
	draw_circle(poly[0], 3, Color.green)
	draw_circle(poly[-1], 3, Color.blue)


func record_points_not_in_polygon(poly: PoolVector2Array):
	"""Keep a record of points in the polygon which aren't "in" the polygon"""
	for point in poly:
		if not Geometry.is_point_in_polygon(point, poly):
			not_on_polygon.append(point)
