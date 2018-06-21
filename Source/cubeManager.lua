include("asset://cube.lua")
include("asset://score.lua")

-----------------------------
--Cube�Ǘ��N���X
-----------------------------
CubeManager = {}

CubeManager.new = function()
	local this = {} 
	this.listCube = {}
	this.gameTime = 0
	this.score = Score.new()

	-- �X�V����
	this.Update = function()
    	--Cube����
    	this.gameTime = this.gameTime + 1
    	if this.gameTime % 10 == 0 then
    	    table.insert( this.listCube, Cube.new() )
    	end
       
    	--Cube�p��
    	for i, v in ipairs(this.listCube) do
    	    v.Update()
    	    if v.CanDestroy() == true then
    	        TASK_kill(v.obj)
    	        table.remove( this.listCube, i )
    	    end
    	end
    	
    	--�X�R�A�X�V
    	this.score.Update()
	end

	-- Cube�����蔻��
	this.Collision = function(hitPos) 	
	      for i, v in ipairs(this.listCube) do
	          if v.Collision(hitPos) then
	          	this.score.Add( hitPos, v.isBad )
	              return true
	          end
	  	end
	  	return false
	end

	--�p��
	this.Destroy = function()
		for i, v in ipairs(this.listCube) do
			if v ~= nil then
				v.Destroy()
			end
		end
		listCube = nil
	this.score.Destroy()
	end
  
  return this -- new�̍Ō�Ƀ��\�b�h��v���p�e�B���\�z�����I�u�W�F�N�g��Ԃ�
end