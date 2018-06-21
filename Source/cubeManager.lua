include("asset://cube.lua")
include("asset://score.lua")

-----------------------------
--Cube管理クラス
-----------------------------
CubeManager = {}

CubeManager.new = function()
	local this = {} 
	this.listCube = {}
	this.gameTime = 0
	this.score = Score.new()

	-- 更新処理
	this.Update = function()
    	--Cube生成
    	this.gameTime = this.gameTime + 1
    	if this.gameTime % 10 == 0 then
    	    table.insert( this.listCube, Cube.new() )
    	end
       
    	--Cube廃棄
    	for i, v in ipairs(this.listCube) do
    	    v.Update()
    	    if v.CanDestroy() == true then
    	        TASK_kill(v.obj)
    	        table.remove( this.listCube, i )
    	    end
    	end
    	
    	--スコア更新
    	this.score.Update()
	end

	-- Cube当たり判定
	this.Collision = function(hitPos) 	
	      for i, v in ipairs(this.listCube) do
	          if v.Collision(hitPos) then
	          	this.score.Add( hitPos, v.isBad )
	              return true
	          end
	  	end
	  	return false
	end

	--廃棄
	this.Destroy = function()
		for i, v in ipairs(this.listCube) do
			if v ~= nil then
				v.Destroy()
			end
		end
		listCube = nil
	this.score.Destroy()
	end
  
  return this -- newの最後にメソッドやプロパティを構築したオブジェクトを返す
end