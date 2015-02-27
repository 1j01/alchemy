
class @ItemView
	constructor: (item, listView)->
		iv = @
		iv.item = item
		iv.$item = document.createElement("div")
		iv.$header = document.createElement("div")
		iv.$tspecific = document.createElement("div")
		iv.$item.className = "item"
		iv.$tspecific.className = "tspecific"
		iv.$header.className = "header"
		
		if item.symbol
			iv.$symbol = document.createElement("div")
			iv.$item.appendChild(iv.$symbol)
			iv.$symbol.className = "symbol"
			iv.$symbol.innerHTML = item.symbol
			
			effect = (dist)->
				iv.$symbol.style.webkitFilter = 
				iv.$symbol.style.mozFilter = 
				iv.$symbol.style.filter = 
					"drop-shadow(0 0 #{dist}em #{item.color})"
			
			iv.$symbol.onmouseenter = -> effect 0.5
			do iv.$symbol.onmouseleave = -> effect 0.1
		
		iv.$item.appendChild(iv.$header)
		iv.$item.appendChild(iv.$tspecific)
		
		do iv.update = ->
			inMarket = listView instanceof Market
			iv.$header.innerHTML = "
				<span class='type'>#{item.type}]</span>
				#{if inMarket then """
					<div class='wanna-buy'>
						<span class='too-expensive'>Not enough money</span>
						<button class='buy'>Buy</button>
					</div>
				""" else ""}
				<span class='substance-name'>#{item.name}</span>
				#{if item.quantity > 1 then "<span class='quantity'> × #{item.quantity}</span>" else ""}
				<span class='price'>#{item.value}ƒ</span>
			"
			
			if inMarket
				$buy = iv.$header.querySelector("button.buy")
				$buy.onclick = -> buy item
				console.log money
				if money >= item.value
					iv.$item.classList.add("can-afford")
					iv.$item.classList.remove("cannot-afford")
				else
					iv.$item.classList.remove("can-afford")
					iv.$item.classList.add("cannot-afford")
				
			
			iv.$tspecific.innerHTML = item.description
			#try iv.$tspecific.innerHTML += " <details class='raw'><summary>JSON</summary>#{JSON.stringify(item)}</details>"
		
