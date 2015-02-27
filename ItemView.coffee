
class @ItemView
	constructor: (item, inMarket)->
		I = @
		I.item = item
		I.$item = document.createElement("div")
		I.$header = document.createElement("div")
		I.$tspecific = document.createElement("div")
		I.$item.className = "item"
		I.$tspecific.className = "tspecific"
		I.$header.className = "header"
		
		if item.symbol
			I.$symbol = document.createElement("div")
			I.$item.appendChild(I.$symbol)
			I.$symbol.className = "symbol"
			I.$symbol.innerHTML = item.symbol
			
			effect = (dist)->
				I.$symbol.style.webkitFilter = 
				I.$symbol.style.mozFilter = 
				I.$symbol.style.filter = 
					"drop-shadow(0 0 #{dist}em #{item.color})"
			
			I.$symbol.onmouseenter = -> effect 0.5
			do I.$symbol.onmouseleave = -> effect 0.1
		
		I.$item.appendChild(I.$header)
		I.$item.appendChild(I.$tspecific)
		
		I.update = ->
			I.$header.innerHTML = "
				<span class='mtype'>#{item.mtype}]</span>
				#{if inMarket then """
					<div class='wanna-buy'>
						<span class='too-expensive'>Not enough money</span>
						<button class='buy'>Buy</button>
					</div>
				""" else ""}
				<span class='substance-name'>#{item.name}</span>
				#{if item.quantity > 1 then "<span class='quantity'> × #{item.quantity}</span>" else ""}
				<span class='mprice'>#{item.value}ƒ</span>
			"
			
			$buy = I.$header.querySelector("button.buy")
			if $buy
				$buy.onclick = (e)->
					if money >= item.value
						money -= item.value
						if item.mtype is "special"
							market.remove item
						if item.onBuy
							item.onBuy()
						else
							# wow, this is awkward (@FIXME?)
							# an ItemView creating an ItemView
							iv = new ItemView(item)
							$inventory.appendChild(iv.$item)
							#inventory.push(iv)
			
			$cancel = I.$header.querySelector("button.cancel")
			if $cancel
				$cancel.onclick = (e)->
					I.$item.classList.remove("active")
			
			
			I.$tspecific.innerHTML = item.description
			#try I.$tspecific.innerHTML += " <details class='raw'><summary>JSON</summary>#{JSON.stringify(item)}</details>"
			
		
		I.update()
