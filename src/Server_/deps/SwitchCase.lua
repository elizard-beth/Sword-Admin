--[[
SwitchCase has two modes: efficient and aesethetic. 
Efficient is designed with pure efficiency in mind, 
while aesthetic is designed to look close to other
programming languages respsective switch cases.

Please place in ReplicatedStorage.
]]

--[[
Efficient use example:
local a=require(game.ReplicatedStorage.SwitchCase)[1];local switch=a.switch;local case=a.case

switch(1, {
  [1] = function()
	print(1)
  end,

  [2] = function()
	print(2)
  end,
})

Aesthetic use example:
local a=require(game.ReplicatedStorage.SwitchCase)[2];local switch=a.switch;local case=a.case

switch(1, { 
	case(2, function() 
		print(2)
	end, 'break'),
	case(1, function()
		print(1)
	end, 'break')
}, 'break')

]]

local aesthetic = {
	switch = function(n, array, str) 
		for _, v in ipairs(array) do 
			if v[1] == n then 
				v[2]()
				if v[3] and v[3] == "break" then 
					break
				end
			end 
		end
	end,

	case = function (a, b, c)
		return {a,b,c}
	end
}
local efficient = {
	switch = function(n, array)
		for i, v in pairs(array) do
			if i == n then 
				v()
				break
			end
		end 
	end
}
return {efficient,aesthetic}
