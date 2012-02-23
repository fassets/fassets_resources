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
          onComplete: function(){$("#fancybox-content").attr("box_type","add_asset");}
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
        $.fancybox.showActivity();
        event.preventDefault();
        $.fancybox.showActivity();
        //var catalog = event.target.href.split("=")[1];
        var search_key = $("#file_asset_search_key").val();
        $("#fancybox-content #add_asset_content").load("/search_wiki_imgs?search_key="+search_key);
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
    };
  $(document).ajaxStop(function() {
    if($("#fancybox-content").attr("box_type") == "add_asset"){ 
      adjust_links();
      $.fancybox.resize();
    }
  });
  $("#new_asset_link").click(function(event){
    event.preventDefault();
    show_asset_box();
  });
});
