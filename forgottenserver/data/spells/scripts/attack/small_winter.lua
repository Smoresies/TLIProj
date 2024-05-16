-- Using the Eternal Winter spell as template
-- Many attempts were made to make this spell have the correct tornadoes in each position
-- But either due to issues with OTClient (some records of it being out of date/glitching)
-- Or just due to lack of knowledge in regards to creating spells, this was the best original attempt.
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

-- Adjusted 3x3 to have more angles as needed
-- Can replace 3 in center with 2 
ADJ_AREA_CIRCLE3X3 = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 2, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0}
}
combat:setArea(createCombatArea(ADJ_AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
