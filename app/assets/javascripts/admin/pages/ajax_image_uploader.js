function AjaxImageUploader(asset_title, upload_button_id) {

  new AjaxUpload(upload_button_id,
      {
        action: $("#async_create_asset_path").attr('value'),
        name: 'asset[asset]',
        data: {
          page : $("#page_id").attr('value'),
          authenticity_token: $("#auth_token").attr('value'),
          "asset[title]": asset_title
        },

        onSubmit : function(file, ext) {
          if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))) {
            alert('You are only allowed to upload image files');
            return false;
          }
          $("#edit_page").bind("submit.asset_upload", function() {
            alert("Please wait until the image has completed uploading.");
            return false;
          });
        },

        onComplete: function(file, response) {
          $("#edit_page").unbind("submit.asset_upload");
          $("#" + asset_title + "_icons").html("<img src='" + response + "'></img>");
        }
      });
}
