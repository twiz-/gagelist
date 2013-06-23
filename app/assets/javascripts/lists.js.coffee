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
   make_tasks_sortable();

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
  $(".task-list li").live("mouseenter", ->
    $(this).find("div.assignee").slideToggle('fast')
  ).live "mouseleave", ->
    $(this).find("div.assignee").slideToggle('fast')

jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 100
        $('.pagination').text('Fetching more results...')
        $.getScript(url)
    $(window).scroll
  		$(this).closest(".activity_feed_icon").find("#activity_feed").slideToggle()

jQuery ->
  $(".activity_feed_icon").live "click", "img", ->
    $(this).closest(".activity_feed_icon").find("#activity_feed").slideToggle()
    unless $('.activity_feed_icon').hasClass('clicked')
      $.ajax
       url: "/activities.js"
       data: "latest=true"

  $(".activity_feed_icon").live "click", ->
    $(this).toggleClass "clicked"
    $(this).removeClass "red_icon"

window.enableChat = (baseRef, projRef, userName) ->
  # Get a reference to the root of the chat data.
  messagesRef = new Firebase(baseRef)
  projectRef = messagesRef.child(projRef)

  # When the user presses enter on the message input, write the message to firebase.
  $("#messageInput").keypress (e) ->
    if e.keyCode is 13
      text = $("#messageInput").val()
      projectRef.push #would call child before push to the ROOT above, so child then root then figure out how to organize
        name: userName
        text: text
      $("#messageInput").val ""

  # Add a callback that is triggered for each chat message.
  projectRef.limit(10).on "child_added", (snapshot) ->
    message = snapshot.val()
    $("<div/>").text(message.text).prepend($("<em/>").text(message.name + ": ")).appendTo $("#messagesDiv")
    $("#messagesDiv")[0].scrollTop = $("#messagesDiv")[0].scrollHeight  
