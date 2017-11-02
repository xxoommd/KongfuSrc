local M = {}

local defaultBackgroundMusic = 'Sound/startBGM.mp3'
local userDefault = cc.UserDefault:getInstance()

function M.playMusic(musicFile)
	AudioEngine.playMusic(musicFile, true)
end

function M.playEffect(effectFile)
	if M.isEffectOn() then
		AudioEngine.playEffect(effectFile, false)
	end
end

function M.playButtonEffect()
	if M.isEffectOn() then
		AudioEngine.playEffect('Sound/button.wav', false)
	end
end

function M.getMusicVolume()
	return userDefault:getIntegerForKey('MusicVolume', 100)
end

function M.setMusicVolume(volume)
	if volume > 100 then volume = 100 end
	userDefault:setIntegerForKey('MusicVolume', volume)
	userDefault:flush()

	AudioEngine.setMusicVolume(volume * 0.01)
end

function M.getEffectVolume()
	return userDefault:getIntegerForKey('EffectVolume', 100)
end

function M.setEffectVolume(volume)
	if volume > 100 then volume = 100 end
	userDefault:setIntegerForKey('EffectVolume', volume)
	userDefault:flush()

	AudioEngine.setEffectsVolume(volume * 0.01)
end

function M.setMusicOn(ret)
	userDefault:setBoolForKey('MusicOn', ret)
	userDefault:flush()

	if ret then
		if AudioEngine.isMusicPlaying() then
			AudioEngine.resumeMusic()
		else
			AudioEngine.playMusic(defaultBackgroundMusic, true)
		end
	else
		AudioEngine.pauseMusic()
	end
end

function M.setEffectOn(ret)
	local userDefault = cc.UserDefault:getInstance()
	userDefault:setBoolForKey('EffectOn', ret)
	userDefault:flush()
end

function M.isMusicOn()
	return cc.UserDefault:getInstance():getBoolForKey('MusicOn', true)
end

function M.isEffectOn()
	return cc.UserDefault:getInstance():getBoolForKey('EffectOn', true)
end

function M.isMusicPlaying()
	return AudioEngine.isMusicPlaying()
end


return M