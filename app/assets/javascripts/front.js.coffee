jQuery ->	
	$("#next_step").click ->
	  $(".first_step").hide "slow"
	  $(".second_step").show "slow"
	  $("#next_step").click ->
	   $(".second_step").hide "slow"
	   $("#next_step").hide "fast"
	   $(".third_step").show "slow"
	   $("#submit_front_button").show "slow"
	   