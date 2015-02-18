
@market =
	items: []
	
	add: (items)->
		items = arguments unless items.length?
		for item in items
			market.items.push item
		market.update()
	
	remove: (item)->
		i = market.items.indexOf item
		market.items.splice i, 1
		market.update()
	
	update: ->
		$market.innerHTML = ""
		for item, i in market.items
			iv = new ItemView(item, yes)
			$market.appendChild(iv.$item)
			item.view = iv

do ->
	market.add [
		{
			name: "(Better) Axe"
			description: "Chops wood faster."
			mtype: "special"
			value: 10
			onBuy: -> unlockAxe()
		}
		{
			name: "Bucket",
			description: "Use it to get water (which is totally pure, I swear) from the river."
			mtype: "special"
			value: 4
			onBuy: -> unlockRiver()
		}
		{
			name: "Distiller"
			description: "It distills stuff."
			mtype: "machine"
			value: 30
		}
		{
			name: "Burner"
			description: "BURN"
			mtype: "machine"
			value: 40
		}
	]
	market.add baseSubstances
	
	for item in market.items
		item.mprice = item.value
	
	market.update()

