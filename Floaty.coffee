
class @Floaty
	constructor: (text, color, x,y)->
		$item = document.createElement("div")
		$item.className = "floaty"
		$item.innerText = text
		
		$item.style.color = color
		$item.style.position = "absolute"
		$item.style.transition = "none"
		$item.style.pointerEvents = "none"
		$item.style.left = (x)+"px"
		$item.style.top = (y)+"px"
		$item.style.transition = "opacity 1s ease-in-out, top 2s ease-out"
		
		setTimeout ->
			$item.style.top = (y-50)+"px"
		
		setTimeout ->
			$item.style.opacity = 0
			setTimeout ->
				$item.parentElement.removeChild($item)
			, 2000
		, 1000
		
		document.body.appendChild($item)
		
		@$item = $item
