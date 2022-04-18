local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')

local _ = i18n.ptranslate

return {

	aimingMarkRemove	= DbOption.new():setValue(false):checkbox(),
	pedalTrimOption		= DbOption.new():setValue(false):checkbox(),
}
