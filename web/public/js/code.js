$(document).ready(function(){
  $('#add').click(function(){
    $('#add').after('<div><input name="artist" id="artist_name" type="text"></div>');
  });
});