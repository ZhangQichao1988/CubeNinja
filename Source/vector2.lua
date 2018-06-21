-----------------------------
--ベクタークラス
-----------------------------
Vector2 = {}

function Vector2.new(x,y)
	local obj = {}
	obj.x = x
	obj.y = y
	return obj
end

function Vector2.rotate(x,y,phi)
	local obj = {}
	local c = math.cos(phi)
	local s = math.sin(phi)
	obj.x = c * x - s * y
	obj.y = s * x + c * y
	return obj
end

function Vector2.len(x,y)
	return math.sqrt(x^2 + y^2)
end

function Vector2.normalize(x,y)
	local obj = {}
	local len = Vector2.len(x, y)
	return Vector2.new( x / len, y / len )
end