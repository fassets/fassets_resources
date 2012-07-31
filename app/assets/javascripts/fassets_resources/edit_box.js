$(document).ready(function(){
    var adjust_links = function(){
      $("#fancybox-content .asset_submit_button").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var asset_type = $(event.target).data("asset-type");
        if (asset_type == "FileAsset"){
          var asset_data = {asset: {name: $("#fancybox-content #asset_name").val()}};
          var f_author = $("#fancybox-content #file_asset_author").val();
          var f_source = $("#fancybox-content #file_asset_source").val();
          var f_license = $("#fancybox-content #file_asset_license").val();
          var file_asset_data = {file_asset: {author: f_author, source: f_source, license: f_license}};
          var asset_id = $("#fancybox-content .asset_submit_button").data("asset-id");
          var content_id = $("#fancybox-content .asset_submit_button").data("content-id");
          var data = {asset: {name: $("#fancybox-content #asset_name").val()}, file_asset: {author: f_author, source: f_source, license: f_license}, "asset_id": asset_id};
          $.post("/file_assets/"+asset_id, data, function(retdata){
            $.fancybox.close();
          });
        }
        if (asset_type == "Url"){
          var asset_id = $("#fancybox-content .asset_submit_button").data("asset-id");
          var content_id = $("#fancybox-content .asset_submit_button").data("content-id");
          var data = {asset: {name: $("#fancybox-content #asset_name").val()}, url: {url: $("#fancybox-content #url_url").val()}};
          $.post("/urls/"+asset_id, data, function(retdata){
            $.fancybox.close();
          });
        }
        reload_tray();
      });
      $("#fancybox-content .wiki_submit").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var search_key = $("#file_asset_search_key").val();
        $("#fancybox-content #add_asset_content").load("/search_wiki_imgs?search_key="+search_key);
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
      $("form.edit_classification input[type=submit][value=Save]").hide();
    };
});
