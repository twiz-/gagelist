# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.best_in_place').best_in_place()
  
  #show members in this project button
  $(".show_members").click ->
    $("#members_list").toggle "fast"
  
  #To stop closing the drop down on submit of teh new project form
  $(".dropdown-menu").find("form").click (e) ->
    e.stopPropagation()
  
jQuery -> 
    $('#incomplete').sortable(
      axis: 'y'
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    );
    
jQuery ->
  $("#new_invitation").bind("ajax:beforeSend", ->
    $("#loading").toggle()
    $("#frm_invite_user").hide()
  ).bind "ajax:success", (xhr, data, status) ->
    $("#loading").toggle()
    $("#frm_invite_user").hide()
    $("#bt-invite-user").show()
    $("#new_task_bt").show()
    $("#notice").text("Invitation email has been sent successfully").css("color", "green").fadeIn(300).delay(30000).fadeOut 300

$ ->
  update_due_labels()


jQuery ->
  $(".task-list").on("mouseenter", "li", ->
    $(this).find("div.assignee").slideToggle('fast')
  ).on "mouseleave", "li", ->
    $(this).find("div.assignee").slideToggle('fast')

jQuery ->
	$(".activity_feed_icon").on "click", "img", ->
  		$(this).closest(".activity_feed_icon").find("#activity_feed").slideToggle()
jQuery ->
	$(window).load ->
	  $("#list_index_tour").joyride {}

