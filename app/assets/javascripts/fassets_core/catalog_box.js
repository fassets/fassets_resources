$(document).ready(function(){
  var show_catalog = function() {
    $.fancybox.showActivity();
	  $.ajax({
		  type		: "GET",
		  cache	: false,
		  url		: "/catalog_box",
		  success: function(data) {
			  $.fancybox({
          content: data
        });
        fancybox_links()
		  }
	  });
  };
  $(window).keydown(function(event){
    switch(event.keyCode) {
    case 67: // c
      if ($("#fancybox-wrap").is(":visible")) {
        //$.fancybox.close();
      } else {
        show_catalog();
      }      
      break;
    }
   });
    var fancybox_links = function(){
      $("#fancybox-content .facet_link, .icon.remove, .catalog_list_item").click(function(event){
        event.preventDefault();
        $.fancybox.showActivity();
        $.ajax({
		      type		: "GET",
		      cache	: false,
		      url		: event.target.href,
		      success: function(data) {
            $("#fancybox-content").html(data);
            $("#fancybox-wrap").css("width", "80%");
            $("#fancybox-content").css("width", "100%");
            $.fancybox.hideActivity();
            $.fancybox.resize();
		      }
	      });
      });
    };
  $(document).ajaxStop(function() { 
    fancybox_links();
    $.fancybox.resize();
  });
});
$(document).ajaxStop(function() {
  var fancybox_links = function(){
    $("#fancybox-content .facet_link, .icon.remove, .catalog_list_item").click(function(event){
      event.preventDefault();
      $.fancybox.showActivity();
      $.ajax({
		    type		: "GET",
		    cache	: false,
		    url		: event.target.href,
		    success: function(data) {
          $("#fancybox-content").html(data);
          $("#fancybox-wrap").css("width", "80%");
          $("#fancybox-content").css("width", "100%");
          $.fancybox.hideActivity();
          $.fancybox.resize();
		    }
	    });
    });
  }; 
  fancybox_links();
  $.fancybox.resize();
});
