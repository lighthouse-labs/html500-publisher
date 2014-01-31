$(function() {
  $('input,textarea').change(function(e) {
    $(this).toggleClass('focused', $(this).val().trim() != '');
  }).change();
});