jQuery ->
	$("#user_first_name").blur (event) ->
	  if $(this).val().length > 1
	    setInterval (-> front_index_gage.refresh 16), 500
	  else

jQuery -> 
	$("#user_last_name").blur (event) -> 
	  if front_index_gage.val == 16 && $(this).val().length > 1 
	    setInterval (-> front_index_gage.refresh 33 ), 500 
	  else

jQuery -> 
	$("button").click ->
	  $("ul:last").toggle "drop",
	    direction: "down"
	  , "slow"	