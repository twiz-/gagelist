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

jQuery ->
  front_index_gage = new JustGage(
    id: "front_gage"
    value: 0
    min: 0
    max: 100
    title: "Your Next Project"
    startAnimationType: "bounce"
    refreshAnimationType: "bounce"
    refreshAnimationTime: 700
    startAnimationTime: 500
    levelColors: ["#ff0000", "#999900", "#00ff00"]
  )
  $("#new_user input[type=text],#new_user input[type=password],#new_user input[type=email]").blur ->
    counter = 0
    $("#new_user input[type=text],#new_user input[type=password],#new_user input[type=email]").each ->
      if @value.length > 1
        counter = counter + 16
        counter = (if counter > 90 then 100 else counter)
        front_index_gage.refresh counter