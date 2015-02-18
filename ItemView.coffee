
class @ItemView
	constructor: (item, inMarket)->
		I = @
		I.item = item
		I.$item = document.createElement("div")
		I.$tgeneric = document.createElement("div")
		I.$tspecific = document.createElement("div")
		I.$item.className = "item"
		I.$tspecific.className = "tspecific"
		I.$tgeneric.className = "tgeneric"
		
		if item.symbol
			I.$symbol = document.createElement("div")
			I.$item.appendChild(I.$symbol)
			I.$symbol.className = "symbol"
			I.$symbol.innerHTML = item.symbol
			I.$symbol.onmouseover = ->
				I.$symbol.style.webkitFilter = 
				I.$symbol.style.mozFilter = 
				I.$symbol.style.filter = 
					"drop-shadow(0em 0em 0.5em #{item.color})"
			
			I.$symbol.onmouseout = ->
				I.$symbol.style.webkitFilter = 
				I.$symbol.style.mozFilter = 
				I.$symbol.style.filter = 
					"drop-shadow(0em 0em 0.1em #{item.color})"
				#	"drop-shadow(0em 0em 0.1em rgba(255,255,255,1))"
			
			I.$symbol.onmouseout()
		
		
		I.$item.appendChild(I.$tgeneric)
		I.$item.appendChild(I.$tspecific)
		
		I.update = ->
			I.$tgeneric.innerHTML = "
				<span class='mtype'>#{item.mtype}]</span>
				#{if inMarket then """
					<div class='wanna-buy'>
						<div class='too-expensive'>You don't have enough money!</div>
						<div class='can-afford'><button class='buy'>Buy</button><button class='cancel'>Cancel</button></div>
					</div>
				""" else ""}
				<span class='substance-name'>#{item.name}</span>
				#{if item.quantity > 1 then "<span class='quantity'> × #{item.quantity}</span>" else ""}
				<span class='mprice'>#{item.value}ƒ</span>
			"
			
			
			$buy = I.$tgeneric.querySelector("button.buy")
			if $buy
				$buy.onclick = (e)->
					if money >= item.value
						money -= item.value
						if item.mtype is "special"
							market.remove item
						if item.onBuy
							item.onBuy()
						else
							# wow, this is awkward (@FIXME)
							# an ItemView creating an ItemView
							iv = new ItemView(item)
							$inventory.appendChild(iv.$item)
							#inventory.push(iv)
			
			$cancel = I.$tgeneric.querySelector("button.cancel")
			if $cancel
				$cancel.onclick = (e)->
					I.$item.classList.remove("active")
			
			
			I.$item.onclick = ->
				if inMarket
					window.__activeItemView?.$item.classList.remove("active")
					window.__activeItemView = I
					window.__activeItemView.$item.classList.add("active")
				else
					alert "that is an item"
			
			I.$tspecific.innerHTML = item.description
			try I.$tspecific.innerHTML += " <details class='raw'><summary>JSON</summary>#{JSON.stringify(item)}</details>"
			
		
		I.update()
