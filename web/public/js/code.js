$(document).ready(function(){
  $('#add_icon').click(function(){
    $('#extra_artists').append('<div><i class="fa fa-times"></i><input name="artist[]" id="artist_name" type="text"></div>');
  });

  $('#add').on('click', '.fa-times', function(){
    $(this).parent().remove();
  });
});