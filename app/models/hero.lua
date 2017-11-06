local Hero = cc.Node:create()

Hero.idleSpriteFrame = nil
Hero.sprite = nil

Hero.isRunning = false
Hero.isJumping = false
Hero.isAttack = false
Hero.direction = true -- 向右方向为true，向左为false

local function createAnimation()

end

function Hero:initSprite()
	self.idleSpriteFrame = display.newSpriteFrame('idle.png')
	self.sprite = cc.Sprite:createWithSpriteFrame(self.idleSpriteFrame)
	self:addChild(self.sprite)
end

-- 开始走动动画
function Hero:startWalkAnimation(direction)
	if self.direction ~= direction then
		self.direction = direction
		self.sprite:setFlippedX(direction)
	end

	local animation = cc.Animation:create()

	for index = 1, 12 do
		local spriteFrame = display.newSpriteFrame(string.format('run%d.png', index))
		if spriteFrame == nil then
			break
		end

		animation:addSpriteFrame(spriteFrame)
	end
	animation:setDelayPerUnit(0.07);
	animation:setRestoreOriginalFrame(true);
	animation:setLoops(-1);

	local action = cc.Animate:create(animation)

	self.sprite:runAction(action)
end

-- 停止走动
function Hero:stopWalkAnimation()
	self.sprite:stopAllActions()
	self:resetToIdle()
end

-- 设置为Idle状态
function Hero:resetToIdle()
	self:removeChild(self.sprite)
	self.sprite = cc.Sprite:createWithSpriteFrame(self.idleSpriteFrame)
	self:addChild(self.sprite)
end

-- 开始跳跃 [jumpup1.png -> jumpup5.png -> jumpdown1.png -> jumpdown5.png]
function Hero:startJumpingAnimation()

end

-- 停止跳跃
function Hero:stopJumpingAnimation()

end

-- 开始攻击(拳头) [fist1.png -> fist4.png]
function Hero:startFistAnimation()

end

-- 停止攻击
function Hero:stopFistAnimation()

end


return Hero