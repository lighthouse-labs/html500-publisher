$(document).ready(function() {
  $('#fileupload').fileupload({
    dataType: 'json',
    singleFileUploads: false,
    add: function(e, data) {
      console.log('--ADD--');
      console.log(e);
      console.log(data);
      data.formData = [];
      // 'relativePaths[]': []
      // };
      $.each(data.files, function (index, file) {
        // console.log('Added file: ' + file.name+ ' Path :'+file.relativePath);
        data.formData.push({
          name: 'relative_paths[]',
          value: file.relativePath
        });
      });
      // data.formData = {
      //   "hello": "there"
      // }
      // console.log(data.formData);
      var resp = data.submit()
      resp.success(function (result, textStatus, jqXHR) {
        /* ... */
        console.log('new success');
      })
      resp.error(function (jqXHR, textStatus, errorThrown) {
        /* ... */
        console.log('new error');
      })
      resp.complete(function (result, textStatus, jqXHR) {
        /* ... */
        console.log('new complete');
      });
    },
    start: function(e, data) {
      console.log('e: ', e);
      console.log('data: ', data);
      $('.loader').addClass('active');
      $('a.button').removeClass('active');
      $('form.file-upload').addClass('off');
    },
    done: function (e, data, y) {
      console.log('DONE');
      console.log('e', e);
      console.log('data', data);
      console.log('y', y);
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