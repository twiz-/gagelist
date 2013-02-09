# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#task_due_date').datepicker
    dateFormat: 'mm-dd-yy'
  
jQuery ->
  $('.best_in_place').best_in_place()
  
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


