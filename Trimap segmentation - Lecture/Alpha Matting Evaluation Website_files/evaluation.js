var isCtrl = false;
    
    var flag = true;
    
    var parElems;
    var oldAnchor;
    var oldText;
    var idx;
    var oldSibling;
        
    document.onkeydown=function(u){
    	if(flag) {
    		

    	//if(u.which == 17) {
    		flag = false;
    		isCtrl=true;
    		
    		parElems = new Array();
		    oldAnchor = new Array();
		    oldText = new Array();
		    oldSibling = new Array();

    	
    		etable = document.getElementById('errortable');
	    	anchors=etable.getElementsByTagName('a');
	    		    	    	
	    	idx=-1;
	    	while(anchors.length>0) {
	    		    		    		    	   		    	
		    	for(var i=0;i<anchors.length;i++){
		    		idx = idx+1;
					tmp_tx = anchors[i].childNodes[0];
					oldText[idx] = anchors[i].removeChild(tmp_tx);
					
					parElems[idx] = anchors[i].parentNode;
					tmp1 = anchors[i];
					oldSibling[idx] = tmp1.nextSibling;
					oldAnchor[idx] = parElems[idx].replaceChild(oldText[idx], tmp1);
				}
			}

		}
		//}
	}

        
    document.onkeyup=function(u){
    		
    	//if(u.which == 17) {
    	flag = true;
	    	for(var i=0;i<=idx;i++) {
    			var appelem = parElems[i].insertBefore(oldAnchor[i],oldSibling[i]);
    			appelem.appendChild(oldText[i]);
  			}

			
		//}
	}
	
	function simulateMousedown(elId) {
		var evt;
		var el = document.getElementById(elId);
	
		if (document.createEvent){
			evt = document.createEvent("MouseEvents");
			evt.initMouseEvent("mouseover", true, true, window,
			0, 0, 0, 0, 0, false, false, false, false, 0, null);
			
			el.dispatchEvent(evt);
		} else if( document.createEventObject ) {
			var evObj = document.createEventObject();
			evObj.detail = 0;
			evObj.screenX = 0;
			evObj.screenY = 0;
			evObj.clientX = 0;
			evObj.clientY = 0;
			evObj.ctrlKey = false;
			evObj.altKey = false;
			evObj.shiftKey = false;
			evObj.metaKey = false;
			evObj.button = 0;
			evObj.relatedTarget = null;
		
			el.fireEvent('onmouseover',evObj);
		}
	}
	
	function simulateMouseup(elId) {
		var evt;
		var el = document.getElementById(elId);
	
		if (document.createEvent){
			evt = document.createEvent("MouseEvents");
			evt.initMouseEvent("mouseout", true, true, window,
			0, 0, 0, 0, 0, false, false, false, false, 0, null);
			
			el.dispatchEvent(evt);
		} else if( document.createEventObject ) {
			var evObj = document.createEventObject();
			evObj.detail = 0;
			evObj.screenX = 0;
			evObj.screenY = 0;
			evObj.clientX = 0;
			evObj.clientY = 0;
			evObj.ctrlKey = false;
			evObj.altKey = false;
			evObj.shiftKey = false;
			evObj.metaKey = false;
			evObj.button = 0;
			evObj.relatedTarget = null;
			
			el.fireEvent('onmouseover',evObj);
		}
	}
	
	var oldBox;
	var parentBox;
	var oldSib;
	function hideHelp() {
		newLink = document.createElement('a');
		newLink.onclick = function() { showHelp();};
		newLink.id = 'helpButton';
		newLink.innerHTML = 'Show Help';
		
		hlpButton = document.getElementById('helpButton');
		hlpButton.parentNode.replaceChild(newLink,hlpButton);
		hlpBox = document.getElementById('help');
		parentBox = hlpBox.parentNode;
		oldSib = hlpBox.nextSibling;
		
		oldBox = parentBox.removeChild(hlpBox);
	}
	
	function showHelp() {
		newLink = document.createElement('a');
		newLink.onclick = function() { hideHelp();};
		newLink.id = 'helpButton';
		newLink.innerHTML = 'Hide Help';
		
		hlpButton = document.getElementById('helpButton');
		hlpButton.parentNode.replaceChild(newLink,hlpButton);
	
		parentBox.insertBefore(oldBox,oldSib);
	}