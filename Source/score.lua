
-----------------------------
--ポイント管理クラス
-----------------------------
Score = {}

Score.new = function()
	local this = {} 
	this.listScore = {}
	this.score = 0
  	this.pLabel = UI_Label( nil, 7000, 0, 10, 0xFF, 0x000000, "AlexBrush", 32, "Score:0")

  -- 更新処理
	this.Update = function()
    	for i, v in ipairs(this.listScore) do
			if v ~= nil then
			
			    --フェードアウト
			    prop = TASK_getProperty(v)
        	    prop.alpha = prop.alpha - 16
        	    prop.y = prop.y - 5
        	    --廃棄処理
        	    if prop.alpha < 0 then
        	        v = TASK_kill(v)
        	        table.remove( this.listScore, i )
        	    end
        	    TASK_setProperty(v, prop)       

        	end
    	end	
	end

  -- Cube当たり判定
  this.Add = function(pos, isBad)
  	
  	if isBad == false then
  		table.insert( this.listScore, UI_Label( nil, 7000, pos.x, pos.y, 0xFF, 0x000000, "AlexBrush", 48, "+"..1) )
  		this.score = this.score + 1
  	else
  		table.insert( this.listScore, UI_Label( nil, 7000, pos.x, pos.y, 0xFF, 0xFF0000, "AlexBrush", 48, "-"..2) )
  		this.score = this.score - 1
  	end
    local prop = TASK_getProperty(this.pLabel)
    prop.text = "Score:"..this.score
    TASK_setProperty(this.pLabel, prop) 
  end
  
	--廃棄
	this.Destroy = function()
		for i, v in ipairs(this.listScore) do
			TASK_kill(v)
		end
		listScore = nil
	end

  return this