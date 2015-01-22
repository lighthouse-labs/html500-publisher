$(document).ready(function() {
  $('#fileupload').fileupload({
    dataType: 'json',
    singleFileUploads: false,
    add: function(e, data) {
      data.formData = [];
      $.each(data.files, function (index, file) {
        data.formData.push({
          name: 'relative_paths[]',
          value: file.relativePath
        });
      });
      var resp = data.submit();
    },
    start: function(e, data) {
      $('.loader').addClass('active');
      $('a.button').removeClass('active');
      $('form.file-upload').addClass('off');
    },
    done: function (e, data, y) {
      $('.loader').removeClass('active');
      $('a.button').addClass('active');
      $('a.button').attr('href', $('a.button').data('root-url') + data.result.path);
    },
    error: function(e, data, y) {
      $('.loader').removeClass('active');
      $('a.button').removeClass('active');
      $('form.file-upload').removeClass('off');
      setTimeout(function() {
        alert(y);
      }, 300);
    }
  });
});