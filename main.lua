
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
    -- 加载所有的资源
	local allRes = {
        'cheatsLayer',
        'galleryLayer',
        'gameLayer',
        'gateMap',
        'hero',
        'heroComobo',
        'heroGun',
        'mapBefore',
        'mapBg',
        'mapMid',
        'mapRoad',
        'monster',
        'pauseLayer',
        'resultLayer',
        'setLayer',
        'startGame'
    }

    for i, v in ipairs(allRes) do
        local plist = 'pnglist/'..v..'.plist'
        local png = 'pnglist/'..v..'.png'
        display.loadSpriteFrames(plist, png)
    end
    
	local app = require( "app.MyApp" )
    app:create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
