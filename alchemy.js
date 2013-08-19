/*
https://docs.google.com/document/d/1PzHK7lriCHThVUdGon-11rrtDNh9r58A_Ex5ItFdLIY/edit#

*/
//symbol("bismuth","ȣ");
function $(Q){return document.querySelector(Q)}
function $$(Q){return document.querySelectorAll(Q)}
!function(){var l=$$("[id]"),i=0;for(;i<l.length;)window["$"+l[i].id]=l[i++]}();

function ItemView(item, inMarket){
	var I = this;
	I.item = item;
	I.$item = document.createElement("div");
	I.$tgeneric = document.createElement("div");
	I.$tspecific = document.createElement("div");
	I.$item.className = "item";
	I.$tspecific.className = "tspecific";
	I.$tgeneric.className = "tgeneric";
	
	if(item.symbol){
		I.$symbol = document.createElement("div");
		I.$item.appendChild(I.$symbol);
		I.$symbol.className = "symbol";
		I.$symbol.innerHTML = item.symbol;
		I.$symbol.onmouseover = function(){
			I.$symbol.style.webkitFilter = 
			I.$symbol.style.mozFilter = 
			I.$symbol.style.filter = 
				"drop-shadow(0em 0em 0.1em "+item.color+")";
		};
		I.$symbol.onmouseout = function(){
			I.$symbol.style.webkitFilter = 
			I.$symbol.style.mozFilter = 
			I.$symbol.style.filter = 
				"drop-shadow(0em 0em 0.1em rgba(255,255,255,1))";
		};
	}
	
	I.$item.appendChild(I.$tgeneric);
	I.$item.appendChild(I.$tspecific);
	
	I.update = function(){
		I.$tgeneric.innerHTML = "<span class='mtype'>["+item.mtype+"]</span>"
			+ (inMarket?""
			+ "<div class='wanna-buy'>"
			+	"<div class='too-expensive'>You don't have enough money!</div>"
			+	"<div class='can-afford'><button class='buy'>Buy</button><button class='cancel'>Cancel</button></div>"
			+ "</div>":"")
		//	+ (inMarket?"<button class='buy'>":"")
			+ "&nbsp;<span class='substance-name'>"+item.name+"</span>"
			+ (item.quantity>1?("<span class='quantity'> × "+item.quantity+"</span>"):"")
			+ "&nbsp;<span class='mprice'>("+(item.value)+"ƒ)</span>"
		//	+ (inMarket?"</button>":"")
		;
		
		var $buy = I.$tgeneric.querySelector("button.buy");
		if($buy){
			$buy.onclick = function(e){
				if(money >= item.value){
					money -= item.value;
					if(item.onBuy){
						item.onBuy();
					}else{
						var iv = new ItemView(item);
						$inventory.appendChild(iv.$item);
						//inventory.push(iv);
					}
				}
			};
		}
		var $cancel = I.$tgeneric.querySelector("button.cancel");
		if($cancel){
			$cancel.onclick = function(e){
				I.$item.classList.remove("active");
			};
		}
		
		I.$item.onclick = function(){
			if(inMarket){
				if(window.__activeItemView){
					window.__activeItemView.$item.classList.remove("active");
				}
				window.__activeItemView = I;
				window.__activeItemView.$item.classList.add("active");
			}else{
				alert("that is an item");
			}
		};
		
		if(item.mtype === "substance"){
			I.$tspecific.innerHTML = item.description;
			//	+ "It is a "+(item.shiny?"shiny, ":" ")+item.color+", "+item.state+" substance. "
			//	+ " <details class='raw'><summary>RAW</summary>"+JSON.stringify(item)+"</details>";
		}else if(item.mtype === "machine"){
			I.$tspecific.innerHTML = item.description;
		}else if(item.mtype === "special"){
			I.$tspecific.innerHTML = item.description;
			//remove the item from the shop
			for(var i in market.items){
				if(market.items[i]==item){
					delete market.items[i];
					market.update();
					break;
				}
			}
		}
	};
	I.update();
}
function Floaty(text, color, x,y){
	var $item = document.createElement("div");
	$item.className = "floaty";
	$item.innerText = text;
	$item.style.cssText = "color:"+color;
	$item.style.position = "absolute";
	$item.style.transition = "none";
	$item.style.pointerEvents = "none";
	$item.style.left = (x)+"px";
	$item.style.top = (y)+"px";
	$item.style.transition = "opacity 1s ease-in-out, top 2s ease-out";
	setTimeout(function(){
		$item.style.top = (y-50)+"px";
	});
	setTimeout(function(){
		$item.style.opacity = 0;
		setTimeout(function(){
			$item.parentElement.removeChild($item);
		},2000);
	},1000);
	
	document.body.appendChild($item);
	
	this.$item = $item;
}
function Substance(o){
	this.symbol = "*";
	this.name = "Inutile Stuff";
	this.description = "It is........ indescribable."; //"Inutile material";
	
	this.flammability = 0; //0..4
	this.burnable = true;
	this.soluble = false;
	this.state = "solid"; //enum { solid, powder, liquid, gas, plasma } //gas = gone, plasma !exist
	this.components = []; //[Substance...]
	this.isChemicalCompound = false;
	
	this.color = "#aaa";
	
	this.mtype = "substance";
	this.value = 14;
	this.quantity = 1;
	
	if(o)for(p in o)this[p]=o[p];
}
function MachineVi(o){//{name, description, takes, callback}
//	this.name = "Mechanizer";
//	this.description = "desc";
//	this.takes = [{
//		solid: true|false,
//		liquid: true|false,
//	}];;
//	this.callback = function(substances){// ??? or... function(s1,s2,s3...){? ?? ?? 
//		return [new Substance()];
//	};
	
//	//this.$object = document.createElement("div");
//	//this.$object.className = "machine";
	this.$div = document.createElement("div");
	//this.$inp
	
	
	if(o)for(p in o)this[p]=o[p];
}
function Input(o){//{x!, y!, name, description, takes, callback}
	this.$input = document.createElement("div");
	this.$input.className = "input";
	this.$input.style.position = "absolute";
	this.$input.style.left = x;
	this.$input.style.top = y;
	
	if(o)for(p in o)this[p]=o[p];
}
var supports = {
	svg: document.createElementNS && document.createElementNS('http://www.w3.org/2000/svg', "svg").createSVGRect,
};
(function(){
	var money = 10;
	var symbol = function(name, fallback){
		if(supports.svg) return "<img src='symbols/"+name+".svg' alt='"+fallback+"'>";
		return fallback;
	};
	var baseSubstances = [
		new Substance({
			name: "Gold",
			symbol: symbol('gold','⊙'),
			description: "Gold is a shiny, yellow, valuable metal.",
			
			group: "metal",
			color: "yellow",
			value: 500,
			
			state: "solid",
		}),
		new Substance({
			name: "Silver",
			symbol: symbol('silver','☽'),
			description: "Silver is a shiny metal.",
			
			group: "metal",
			color: "gray",
			
			state: "solid",
		}),
		new Substance({
			name: "Copper",
			//symbol: "♀",
			symbol: symbol('copper','♀'),
			description: "Copper is a shiny light-orangish metal.",
			group: "metal",
			color: "orange",
			
			state: "solid",
			
		}),
		new Substance({
			name: "Iron",
			symbol: symbol('iron','♂'),
			description: "Iron is a metal",
			group: "metal",
			color: "gray",
			
			state: "solid",
		}),
		new Substance({
			name: "Tin",
			symbol: symbol('tin','♃'),
			description: "Tin eth is isjk.. metal",
			group: "Metal",
			color: "ltgray",
			
			state: "solid",
		}),
		new Substance({
			name: "Lead",
			symbol: symbol('lead','♄'),
			description: "Lead is a soft and malleable metal. Contrary to popular belief, pencil leads in wooden pencils have never been made from lead. Roman styluses used lead, but never pencils!",
			group: "metal",
			color: "dkgray",
			
			state: "solid",
		}),
		new Substance({
			name: "Mercury",
			symbol: symbol('mercury','☿'),
			description: "Mercury is.",
			group: "metal",
			color: "red",
			
			state: "liquid",
			
		}),
		new Substance({
			name: "Sulfur",
			symbol: symbol('sulfur','⊕'),
			//symbol: symbol('sulfur','<div style="-webkit-transform:rotate(90deg) rotateY(-180deg);transform:rotate(90deg) rotateY(-180deg)">Ⓢ</div>'),
			description: "Sulfur is a yellow chrystaline substance.",
			color: "yellow",
			
			state: ["solid","powder"],
		}),
		new Substance({
			name: "Salt",
			symbol: symbol('salt','ϴ'),
			description: "Salt is.....saltie",
			color: "white",
			
			state: ["solid","powder"],
		}),
		new Substance({
			name: "Quicklime",
			symbol: symbol('lime','<strike>Ψ</strike>'),
			description: "afailk",
			color: "#BFB",
			
			state: "solid",
		}),
		new Substance({
			name: "Arsenic",
			symbol: symbol('arsenic','Å'),
			description: "Arsenic ist evil among us...........",
			color: "gray",
			
			state: "solid",
		}),
	];
	var combinations = {
		"substance where combustion equaleth two whatwith limestone withpojigtkodgmkfkmkjk code = nil string var;;;;;; hello world.vios.bnm@herby.comin furnace": {
			
		}
	};
	var inventory = {};
	var machines = {};
	var yourAxeQuality = 1;
	var market = {
		items: [
			{
				name: "(Better) Axe",
				description: "Chops wood faster.",
				mtype: "special",
				value: 10,
				onBuy: function(){
					yourAxeQuality = 3;
				}
			},{
				name: "Bucket",
				description: "Use it to get water (which is totally pure, I swear) from the river.",
				mtype: "special",
				value: 4,
				onBuy: function(){
					unlockRiver();
				}
			},{
				name: "Distiller",
				description: "It distills stuff.",
				mtype: "machine",
				value: 30,
			},{
				name: "Burner",
				description: "BURN",
				mtype: "machine",
				value: 40,
			}
		],
		update: function(){
			$market.innerHTML = "";
			for(var i in market.items){
				var item = market.items[i];
				var iv = new ItemView(item, true);
				$market.appendChild(iv.$item);
				item.view = iv;
			}
		},
		thisObjectHappensToBeAMarket: true
	};
	
	
	market.items = market.items.concat(baseSubstances);
	for(var i in market.items){
		var item = market.items[i];
		item.mprice = item.value;
	}
	market.update();
	
	
	addToInventory({
		name: "Fists of Herobrine",
		description: "A fairly decent axe stand-in.",
		mtype: "special",
		value: 0,
	});
	
	function addToInventory(item){
		console.log("addToInventory",item);
		var iv = inventory[item.name];
		if(iv){
			//iv.item.value /= iv.item.quantity;
			//iv.item.quantity++;
			//iv.item.value *= iv.item.quantity;
			
			iv.item.value /= iv.item.quantity / ++iv.item.quantity;
			iv.update();
		}else{
			iv = new ItemView(item);
			inventory[item.name] = iv;
			$inventory.appendChild(iv.$item);
		}
	}
	
	function unlockRiver(){
		//unlock the river for water getting
		var $button = document.createElement("button");
		$button.innerText = "Fetch Water";
		$button.onclick = function(){
			alert("impure water GET");
			addToInventory(new Substance({
				name: "Impure Water",
				symbol: "⍫",//symbol("impure-water","⍫"),
				description: "This water is impure. Where'd you get it, anyway? A river?",
				
				color: "aqua",
				value: 0,
				
				state: "liquid",
				soluble: true,
				flammability: 0,
				burnable: false,
			}));
		};
		document.body.appendChild($button);
	}
	function unlockForest(){
		//unlock the forest for wood getting
		var counter = 0;
		var $button = document.createElement("button");
		$button.innerText = "Cut Wood";
		$button.onclick = function(){
			var rect = $button.getBoundingClientRect();
			var x = rect.left + Math.random()*50;
			var y = rect.top - Math.random()*10 + scrollY;
			if((counter += yourAxeQuality) > 20){
				counter = 0;
				new Floaty("WOOD GET!","rgba(255,255,255,1)",x,y,$button);
				addToInventory(new Substance({
					name: "Wood",
					symbol: symbol("wood","W"),
					description: "wood of tree",
					
					value: 8,
					color: "brown",
					
					soluble: false,
					state: "solid",
					flammability: 1,
					burnable: true,
				}));
			}else{
				//+(Math.random()<0.1?"pa":Math.random()<0.1?"py":"")
				new Floaty("chop","rgba(255,255,255,0.5)",x,y,$button);
			}
		};
		document.body.appendChild($button);
	}
	unlockForest();
	
	setInterval(function(){
		$money.innerText = money;
		for(var i in market.items){
			var item = market.items[i];
			if(item.value <= money){
				item.view.$item.classList.add("affordable");
				item.view.$item.classList.remove("unaffordable");
			}else{
				item.view.$item.classList.remove("affordable");
				item.view.$item.classList.add("unaffordable");
			}
		}
	},10);

})();