//$(document).ajaxSend(function(event, request, settings) {
//  if (typeof(AUTH_TOKEN) == "undefined") return;
//  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
//  settings.data = settings.data || "";
//  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
//});


$(document).ready(function(){
  var show_asset_box = function() {
    $.fancybox.showActivity();
    var f_width = $(window).width()*0.8;
    var f_height = $(window).height()*0.8;
    $("#add_asset_content").css("left",$("#catalog_list").width()+10);
    $("#add_asset_content").css("width",$("#fancybox-content").width()-$("#catalog_list").width()-30-$("#facets").width());
	  $.ajax({
		  type		: "GET",
		  cache	: false,
		  url		: "/add_asset_box",
		  success: function(data) {
			  $.fancybox({
          content: data,
          padding: 0,
          autoDimensions: false,
          width: f_width,
          height: f_height,
          onComplete: function(){$("#fancybox-content").data("box-type","add_asset");}
        });
        adjust_links();
        $.fancybox.resize();
		  }
	  });
  };
  $(window).keydown(function(event){
    switch(event.keyCode) {
    case 65: // a
      activeObj = document.activeElement;
      if (activeObj.type == "textarea") break;
      if (activeObj.type == "text") break;
      if ($(activeObj).attr("class") != undefined && $(activeObj).attr("class").indexOf("slot") != -1) break;
      if ($("#fancybox-wrap").is(":visible")) {
        $.fancybox.close();
      } else {
        show_asset_box();
      }      
      break;
    }
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
      $("#fancybox-content .wiki_submit").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var search_key = $("#file_asset_search_key").val();
        $("#fancybox-content #add_asset_content").load("/search_wiki_imgs?search_key="+search_key);
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .add_wiki_img").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        $.post("/file_assets/", $(event.target).parent().parent().serialize(), function(data){
          for(var key in data){ alert('key name: ' + key + ' value: ' + data[key]); }
          $("#fancybox-content #add_asset_content").load(data[0].edit_box_url+"?type="+data[0].content_type);
        });
        reload_tray();        
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .add_remote_file").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        $.post("/file_assets/", $(event.target).parent().serialize(), function(data){
          $("#fancybox-content #add_asset_content").load(data[0].edit_box_url+"?type="+data[0].content_type, function(){adjust_links();});
        });
        reload_tray();        
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .asset_create_button").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var action = $("#add_asset_content form").attr("action");
        $.post(action, $("#add_asset_content form").serialize(), function(data){
          $("#fancybox-content #add_asset_content").load(data[0].edit_box_url+"?type="+data[0].content_type);
        });
        reload_tray();        
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .asset_submit_button").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        //var token = encodeURIComponent(AUTH_TOKEN)
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
          $.post("/file_assets/"+asset_id, data);  
        } 
        if (asset_type == "Url"){
          var asset_id = $("#fancybox-content .asset_submit_button").data("asset-id");
          var content_id = $("#fancybox-content .asset_submit_button").data("content-id");
          var data = {asset: {name: $("#fancybox-content #asset_name").val()}, url: {url: $("#fancybox-content #url_url").val()}};
          $.post("/urls/"+asset_id, data);         
        }
        reload_tray();
        $.fancybox.hideActivity();     
      });
      $("form.edit_classification input[type=submit][value=Save]").hide();
    };
  $(document).ajaxStop(function() {
    if($("#fancybox-content").data("box-type") == "add_asset"){
      adjust_links();
      $.fancybox.resize();
    }
  });
  $("#new_asset_link").click(function(event){
    event.preventDefault();
    show_asset_box();
  });
  var reload_tray = function() {
    var user_id = $("#tray").data("user-id");
    $("#tray").load("/users/"+user_id+"/tray_positions/", function() {
      $('#tray .drop_button').click(function(event){
        event.preventDefault();
        var user_id = $(event.target).data("user-id");
        var tp_id = $(event.target).data("tp-id");
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
