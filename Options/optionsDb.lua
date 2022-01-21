local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')

local _ = i18n.ptranslate

return {
	VR_AVS7	= DbOption.new():setValue(false):checkbox(),
}
