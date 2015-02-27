
@market = new Market($market)

market.add [
	{
		name: "(Better) Axe"
		description: "Chops wood faster."
		type: "special"
		value: 10
		onBuy: -> unlockAxe()
	}
	{
		name: "Bucket",
		description: "Use it to get water (which is totally pure, I swear) from the river."
		type: "special"
		value: 4
		onBuy: -> unlockRiver()
	}
	{
		name: "Distiller"
		description: "It distills stuff."
		type: "machine"
		value: 30
	}
	{
		name: "Burner"
		description: "BURN"
		type: "machine"
		value: 40
	}
]
market.add baseSubstances

