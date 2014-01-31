$(document).ready(function() {
  $('#fileupload').fileupload({
    dataType: 'json',
    singleFileUploads: false,
    start: function() {
      $('.loader').addClass('active');
      $('a.button').removeClass('active');
      $('form.file-upload').addClass('off');
    },
    done: function (e, data, y) {
      $('.loader').removeClass('active');
      $('a.button').addClass('active');
      $('a.button').attr('href', $('a.button').data('root-url') + data.result.site);
    }
  });
});