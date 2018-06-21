-----------------------------
--タイマー
-----------------------------
Timer = {}

Timer.new = function(obj)
  local this = {} 
  this.time = 1000 * 30
  this.pLabel = UI_Label( nil, 7000, 0, 30, 0xFF, 0x000000, "AlexBrush", 32, "RemainingTime:" ..math.floor(this.time / 1000))
                      
  --更新
  this.Update = function(deltaT)
  
  	if this.time <= 0 then
  		return
  	end
  	
    this.time = this.time - deltaT
    if this.time <= 0 then
    	this.time = 0
  	end
  	
    local prop = TASK_getProperty(this.pLabel)
    prop.text = "RemainingTime:" ..math.floor(this.time / 1000)
    TASK_setProperty(this.pLabel, prop) 
  end
  
  --タイムオーバー？
  this.IsTimeOver = function()
    if this.time <= 0 then
    	return true
    end
    return false
  end
  
  --廃棄
  this.Destroy = function()
    this.pLabel = TASK_kill(this.pLabel)
  end

  return this
end