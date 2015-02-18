

supports = svg: document.createElementNS?('http://www.w3.org/2000/svg', "svg").createSVGRect

@symbol = (name, fallback)->
	if supports.svg
		"<img src='symbols/#{name}.svg' alt='#{fallback}'>"
	else
		fallback


# this is bad; don't do this @FIXME
@$ = (q)-> document.querySelector(q)
@$$ = (q)-> document.querySelectorAll(q)
do -> @["$#{ewid.id}"] = ewid for ewid in $$("[id]")

