include("asset://vector2.lua")
include("asset://cubeManager.lua")
include("asset://timer.lua")

--初期化
function setup()
    cubeManager = CubeManager.new()
    timer = Timer.new()
	UI_TouchPad("callback_TouchPad")
	listPoint_ = {}
	state = 0
	
end

--タッチイベント
function callback_TouchPad(arr)
    if state == 1 then
    	return
    end
    local moveVec
    local len
    local moveNormalizeVec
    local pointPos
    
	for idx,item in ipairs(arr) do
	    
        --タップ
		if item.type == PAD_ITEM_TAP then
		    prePos_ = Vector2.new( item.x, item.y )
		    
		--ドラッグ
	    elseif item.type == PAD_ITEM_DRAG then
	        ---------------------------------------------------
	        --移動した距離によって、描画ポイントを調整する
	        ---------------------------------------------------
		    nowPos_= Vector2.new( item.x, item.y )
		    moveVec = Vector2.new( nowPos_.x - prePos_.x, nowPos_.y - prePos_.y )
            len = Vector2.len(moveVec.x, moveVec.y)
            moveNormalizeVec = Vector2.normalize( moveVec.x, moveVec.y )
 
            local is_hit = false
            for j = 1, len/2 do
                pointPos = Vector2.new( prePos_.x + moveNormalizeVec.x * 2,prePos_.y + moveNormalizeVec.y * 2 )
                table.insert( listPoint_, UI_SimpleItem( nil, 7000, pointPos.x, pointPos.y, "asset://assets/point.png.imag" ) )
                
                --Cube当たり判定
                if is_hit == false and cubeManager.Collision( pointPos ) then 
                	is_hit = true
                end
            end
		    prePos_ = nowPos_
            ---------------------------------------------------
		end
	end

end


function leave()
	timer.Destroy()
end

function execute(deltaT)
	if state == 0 then		--ゲーム中
		Update( deltaT )
	elseif state == 1 then	--ゲーム終了
		
	end
end


function Update(deltaT)
	
	--時間更新
    timer.Update( deltaT )
    
    --ゲーム終了判定
    if timer.IsTimeOver() == true then
    	state = 1
    	for i, v in ipairs(listPoint_) do
			v = TASK_kill(v)
		end
		cubeManager.Destroy()
    	TASK_StageClear()
    	UI_Label( nil, 7000, 400, 300, 0xFF, 0xFF0000, "AlexBrush", 32, "Game Over!")
    	UI_Label( nil, 7000, 400, 400, 0xFF, 0x000000, "AlexBrush", 32, "Score:"..cubeManager.score.score)
    	return
    end
    
    --ポイント更新
	local prop
	
	for i, v in ipairs(listPoint_) do
		if v ~= nil then
		    --フェードアウト
		    prop = TASK_getProperty(v)
		     
            prop.alpha = prop.alpha - 32
            prop.scaleX = prop.scaleX - 0.125
            prop.scaleY = prop.scaleY - 0.125
            --廃棄処理
            if prop.alpha < 0 then
                v = TASK_kill(v)
                table.remove( listPoint_, i )
            end
            TASK_setProperty(v, prop)       

        end
    end	
    
    --キューブ更新
    cubeManager.Update()

end
