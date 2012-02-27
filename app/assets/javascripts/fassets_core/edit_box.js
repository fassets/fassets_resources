$(document).ready(function(){
    var show_edit_box = function(event) {
      var asset_id = $(event.target).attr("asset_id");
      $.fancybox.showActivity();
      var f_width = $(window).width()*0.8;
      var f_height = $(window).height()*0.8;
	    $.ajax({
		    type		: "GET",
		    cache	: false,
		    url		: "/asset/"+asset_id+"/edit",
		    success: function(data) {
			    $.fancybox({
            content: data,
            padding: 0,
            autoDimensions: false,
            width: f_width,
            height: f_height,
            onComplete: function(){$("#fancybox-content").attr("box_type","edit_asset");}
          });
          adjust_links();
          $.fancybox.resize();
		    }
	    });
    };
    $("body .edit_button").click(function(event){
      event.preventDefault();
      show_edit_box(event);
    });
    var adjust_links = function(){
      $("#fancybox-content li.asset_type").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var type = event.target.href.split("=")[1];
        $("#fancybox-content").load("/add_asset_box?type="+type);
        $.fancybox.resize();
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .asset_submit_button").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var asset_type = $(event.target).attr("asset_type");
        if (asset_type == "FileAsset"){
          var asset_data = {asset: {name: $("#fancybox-content #asset_name").val()}};
          var f_author = $("#fancybox-content #file_asset_author").val();
          var f_source = $("#fancybox-content #file_asset_source").val();
          var f_license = $("#fancybox-content #file_asset_license").val();
          var file_asset_data = {file_asset: {author: f_author, source: f_source, license: f_license}};
          var asset_id = $("#fancybox-content .asset_submit_button").attr("asset_id");
          var content_id = $("#fancybox-content .asset_submit_button").attr("content_id");
          var data = {asset: {name: $("#fancybox-content #asset_name").val()}, file_asset: {author: f_author, source: f_source, license: f_license}, "asset_id": asset_id};
          $.post("/file_assets/"+asset_id, data, function(retdata){
            $.fancybox.close();
          });  
        } 
        if (asset_type == "Url"){
          var asset_id = $("#fancybox-content .asset_submit_button").attr("asset_id");
          var content_id = $("#fancybox-content .asset_submit_button").attr("content_id");
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

    };
  $(document).ajaxStop(function() {
    if($("#fancybox-content").attr("box_type") == "edit_asset"){
      //("#fancybox-content button").off("click"); 
      adjust_links();
    }
  });
  var reload_tray = function() {
    var user_id = $("#tray").attr("user_id");
    $("#tray").load("/users/"+user_id+"/tray_positions/", function() {
      $('#tray .drop_button').click(function(event){
        event.preventDefault();
        var user_id = $(event.target).attr("user_id");
        var tp_id = $(event.target).attr("tp_id");
        $.ajax({
          type: 'DELETE',
          cache	: false,
          url		: "/users/"+user_id+"/tray_positions/"+tp_id,
          success: function(data) {
            $("#tray").load("/users/"+user_id+"/tray_positions/");
          }
        });
      });
    });
  };
});
