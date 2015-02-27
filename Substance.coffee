
class @Substance
	constructor: (o)->
		@symbol = "*"
		@name = "Inutile Stuff"
		@description = "It is........ indescribable." #"Inutile material"
		
		@flammability = 0 #0..4
		@burnable = yes
		@soluble = no
		@state = "solid" #enum { solid, powder, liquid, gas, plasma } #gas = gone, plasma !exist
		@components = [] #[Substance...]
		@isChemicalCompound = no
		
		@color = "#aaa"
		
		@type = "substance"
		@value = 14
		@quantity = 1
		
		#if(o)for(p in o)@[p]=o[p]
		@[k] = v for k, v of o
	
	toJSON: ->
		o = {}
		o[k] = v for k, v of @ when k isnt "view" # view contains circular reference
		o
