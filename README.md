# 课题提交

■游戏名
* 方块忍者

■游戏规则
* 在30秒内尽可能的用手指划过的线去碰触蓝色方块
* 碰触蓝色一次加1分，碰触红色一次减2分

■文件构成
* Source				--用Toboggan.exe来打开的元文件
* Capture.mp4			--游戏演示
* CuneNinja.apk			--安卓设备的执行文件

■代码构成
* start.lua				--游戏初始化
* main.lua				--游戏根类
* cubeManager.lua		--方块管理
* cube.lua				--方块
* score.lua				--分数管理
* timer.lua				--时间制约
* vector2.lua			--坐标工具

■开发心得
* 由于lua第一次接触，所以是边学习边完成的开发
* 总得来说是个不错的开发引擎
* 有时候编辑过的代码和资源会无法被正确打包，需要重启Toboggan.exe已经删除缓存文件才行
