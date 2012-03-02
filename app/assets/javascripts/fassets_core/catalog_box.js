$(document).ready(function(){
  var show_catalog = function() {
    $.fancybox.showActivity();
    var f_width = $(window).width()*0.8;
    var f_height = $(window).height()*0.8;
    $("#box_content").css("left",$("#catalog_list").width()+10);
    $("#box_content").css("width",$("#fancybox-content").width()-$("#catalog_list").width()-30-$("#facets").width());
	  $.ajax({
		  type		: "GET",
		  cache	: false,
		  url		: "/catalog_box",
		  success: function(data) {
			  $.fancybox({
          content: data,
          padding: 0,
          autoDimensions: false,
          width: f_width,
          height: f_height,
          onComplete: function(){$("#fancybox-content").attr("box_type","catalog");}
        });
        $("#box_content").css("left",$("#catalog_list").width()+10);
        $("#box_content").css("width",$("#fancybox-content").width()-$("#catalog_list").width()-30-$("#fancybox-content #sidebar").width());
        fancybox_links();
        $.fancybox.resize();
		  }
	  });
  };
  $(window).keydown(function(event){
    switch(event.keyCode) {
    case 67: // c
      activeObj = document.activeElement;
      if (activeObj.type == "textarea") break;
      if (activeObj.type == "text") break;
      if ($("#fancybox-wrap").is(":visible")) {
        $.fancybox.close();
      } else {
        show_catalog();
      }      
      break;
    }
   });
    var fancybox_links = function(){
      $("#fancybox-content li.label, .clear_filter, .facet_drop_link").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var catalog = $("#fancybox-content #selected").attr("catalog_id");
        var filter = event.target.href.split("?")[1];
        $("#fancybox-content #facets").load("/box_facet?id="+catalog+"&"+filter);
        $("#fancybox-content #box_content").load("/box_content?id="+catalog+"&"+filter, function(){
          $("#box_content").css("width",$("#fancybox-content").width()-$("#catalog_list").width()-30-$("#fancybox-content #sidebar").width());
        });
        $.fancybox.resize();
        $.fancybox.hideActivity();
      });
      $("#fancybox-content .catalog_list_item").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        var catalog = event.target.href.split("=")[1];
        $("#fancybox-content").load("/catalog_box?id="+catalog, function(){
          $("#box_content").css("width",$("#fancybox-content").width()-$("#catalog_list").width()-30-$("#fancybox-content #sidebar").width());
        });
        $.fancybox.resize();;
        $.fancybox.hideActivity();
      });
    };
  $(document).ajaxStop(function() {
    if($("#fancybox-content").attr("box_type") == "catalog"){ 
      fancybox_links();
      $.fancybox.resize();
    }
  });
});
