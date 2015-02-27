
class @ItemListView
	hash = (item)->
		item.name # TODO: hash together different properties?
	
	constructor: (@element)->
		@items = []
		@itemsHash = {}
	
	add: (items)->
		itemsToAdd = (if items.length? then items else arguments)
		for item in itemsToAdd
			existingItem = @itemsHash[hash item]
			if existingItem
				value_per_unit = existingItem.value / existingItem.quantity
				existingItem.value = value_per_unit * ++existingItem.quantity
				existingItem.view.update()
			else
				#iv = new ItemView(item)
				@items.push item
				@itemsHash[hash item] = item
		@update()
	
	remove: (item)->
		i = @items.indexOf item
		@items.splice i, 1
		@update()
	
	update: ->
		@element.innerHTML = ""
		for item, i in @items
			iv = new ItemView(item, @)
			@element.appendChild(iv.$item)
			item.view = iv


class @Market extends ItemListView


