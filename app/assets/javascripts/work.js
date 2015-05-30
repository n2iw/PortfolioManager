// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $( ".delete_work" ).submit(function( event ) {
        return confirm("!!!!!!!!!!!!!!!!!\nYou are going to DELETE THIS WORK!\nAre you sure you want to do it?");
  });
    $( ".delete_picture" ).submit(function( event ) {
        return confirm("!!!!!!!!!!!!!!!!!\nYou are going to DELETE THIS PICTURE!\nAre you sure you want to do it?");
  });
});
