// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require raphael.min
//= require justgage
//= require jquery.purr
//= require best_in_place
//= require lightbox
//= require_tree .


$(function() {
	$('#new_task_bt').click(function() {
		$('#new_task_form').show();
		$("#new_task").each (function(){
		  this.reset();
		});
		$(this).hide();
		return false; //To avoid # added to current url
	});
	
	$('.mark_comp').live('click', function() {
		if ($(this).is(':checked')) {
			$(this).parent().submit();
		}
	});
	
	$('.mark_in_comp').live('click', function() {
		if($(this).is(':checked')) {
			$(this).parent().submit();
		}
	});
	
	$('#bt-cancel-task').live('click', function() {
		$("#new_task").each (function(){
		  this.reset();
		});
		$('#new_task_form').hide();
		$('#new_task_bt').show();
	});
	

	 $("#tb-incompletes th a").live("click", function() {
	    $.getScript(this.href);
	    return false;
	  });

	$('#bt-invite-user').click(function() {
		$('#frm_invite_user').show();
		$(this).hide();
		$('#new_task_bt').hide();
	});
	
	$('#bt-cancel-invite').click(function() {
		$('#frm_invite_user').hide();
		$('#bt-invite-user').show();
		$('#new_task_bt').show();
	});
	
});
$('.second_step').hide();

function update_due_labels(){  
  $('ul#incomplete li span.medium').html('');
  $('ul#incomplete li:first span.medium').html('<span class="label label-important">Due Now</span>');
  $('ul#incomplete').children('li').eq(1).children('span.medium').html('<span class="label label-warning">Up Next</span>');
  return false;
}
