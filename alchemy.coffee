###
# https://docs.google.com/document/d/1PzHK7lriCHThVUdGon-11rrtDNh9r58A_Ex5ItFdLIY/edit#
###

#symbol("bismuth","ȣ")

###
MachineVi = ({name, description, takes, callback})->
#	@name = "Mechanizer"
#	@description = "desc"
#	@takes = [
#		solid: yes or no
#		liquid: yes or no
#	]
#	@callback = (substances)-> ??? or... (s1,s2,s3...)-> ?? ?? 
#		[new Substance()]?
	
#	#@$object = document.createElement("div")
#	#@$object.className = "machine"
	@$div = document.createElement("div")
	#@$inp
	
	#if(o)for(p in o)@[p]=o[p]


# This isn't used
Input = ({x, y, name, description, takes, callback})-> 
	@$input = document.createElement("div")
	@$input.className = "input"
	@$input.style.position = "absolute"
	@$input.style.left = x+"px"
	@$input.style.top = y+"px"
	
	#if(o)for(p in o)@[p]=o[p]
###

@money = 10
@inventory = {}
@machines = {}
axeQuality = 1

@addToInventory = (item)->
	console.log "addToInventory", item
	iv = inventory[item.name]
	if iv
		value_per_unit = iv.item.value / iv.item.quantity
		iv.item.quantity += 1
		iv.item.value = value_per_unit * iv.item.quantity
		iv.update()
	else
		iv = new ItemView(item)
		inventory[item.name] = iv
		$inventory.appendChild(iv.$item)

@unlockAxe = ->
	axeQuality = 3

@unlockRiver = ->
	# unlock the river of water getting
	# @TODO: floaties for all GETs
	$button = document.createElement("button")
	$button.innerText = "Fetch Water"
	$button.onclick = ->
		alert "impure water GET"
		addToInventory new Substance
			name: "Impure Water"
			symbol: symbol("impure-water","⍫"),
			description: "This water is impure. Where'd you get it, anyway? A river?"
			
			color: "aqua"
			value: 0
			
			state: "liquid"
			soluble: yes
			flammability: 0
			burnable: no
	
	document.body.appendChild($button)

@unlockForest = ->
	# unlock the forest of wood getting
	counter = 0
	$button = document.createElement("button")
	$button.innerText = "Cut Wood"
	$button.onclick = ->
		rect = $button.getBoundingClientRect()
		x = rect.left + Math.random()*50
		y = rect.top - Math.random()*10 + scrollY
		counter += axeQuality
		if counter > 20
			counter = 0
			new Floaty("WOOD GET!","rgba(255,255,255,1)",x,y,$button)
			addToInventory new Substance
				name: "Wood"
				description: "wood of tree"
				symbol: symbol("wood","W")
				color: "brown"
				value: 8
				
				state: "solid"
				soluble: no
				flammability: 1
				burnable: yes
			
		else
			#+(Math.random()<0.1?"pa":Math.random()<0.1?"py":"")
			new Floaty("chop","rgba(255,255,255,0.5)",x,y,$button)
	
	document.body.appendChild($button)

addToInventory
	name: "Fists of Herobrine"
	description: "A fairly decent axe stand-in."
	mtype: "special"
	value: 0

unlockForest()

setInterval ->
	$money.innerText = money
	for item in market.items
		if item.value <= money
			item.view.$item.classList.add("affordable")
			item.view.$item.classList.remove("unaffordable")
		else
			item.view.$item.classList.remove("affordable")
			item.view.$item.classList.add("unaffordable")
, 10

