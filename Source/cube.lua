include("asset://vector2.lua")

-----------------------------
--Cubeクラス
-----------------------------
Cube = {}

Cube.new = function()
  local this = {} 
  this.isBad = false
  local cube_name = "asset://assets/cube.png.imag"
  if math.random() > 0.7 then
      cube_name = "asset://assets/cube_bad.png.imag"
      this.isBad = true
  end
  
  this.obj = UI_SimpleItem( nil, 7000, 400, 600, cube_name )
  this.pos = {}
  this.moveVec = Vector2.rotate(5,0,math.random()*1.57 - 2.355)
  this.addRot = 0
  this.hitWait = 0
  this.hitCnt = 0

  -- 更新処理
  this.Update = function()
    --描画処理
    local prop = TASK_getProperty(this.obj)
    prop.x = prop.x + this.moveVec.x
    prop.y = prop.y + this.moveVec.y
    this.pos = Vector2.new(prop.x, prop.y)
    this.addRot = this.addRot + this.moveVec.x
    prop.rot = this.addRot
    TASK_setProperty(this.obj, prop) 
    
    --ロジック処理
    this.hitWait = this.hitWait - 1
    
  end

  -- 当たり判定
  this.Collision = function(hitPos)
  	--ヒット無効時間
  	if this.hitWait > 0 then
  		return false
  	end
  	
  	local move_vec = Vector2.new(this.pos.x - hitPos.x, this.pos.y - hitPos.y)
  	if Vector2.len(move_vec.x, move_vec.y) < 64 then
  		this.moveVec = Vector2.new(move_vec.x/4, move_vec.y/4 )
  		this.hitWait = 10
  		this.hitCnt = this.hitCnt + 1
  		
  		
  		return true
  	end
  	return false
  end
  
   -- 廃棄可能？
  this.CanDestroy = function()
  	if this.pos.x < 0 or this.pos.x > 960 or this.pos.y < 0 or this.pos.y > 640 then
    	return true
    end
  	return false
  end
  
  	--廃棄
	this.Destroy = function()
		TASK_kill(this.obj)
		this.obj = nil
	end

  return this
end