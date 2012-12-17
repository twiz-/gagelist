jQuery ->
	$("#user_first_name").blur (event) ->
	  if $(this).val().length > 1
	    setInterval (-> front_index_gage.refresh 16), 500
	  else
jQuery -> 
	$("button").click ->
	  $("ul#three_questions").toggle "drop",
	    direction: "down"
	  , "slow"	
