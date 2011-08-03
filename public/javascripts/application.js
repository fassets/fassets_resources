// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  // UJS authenticity token fix: add the authenticy_token parameter
  // expected by any Rails POST request.
  $(document).ajaxSend(function(event, request, settings) {
    // do nothing if this is a GET request. Rails doesn't need
    // the authenticity token, and IE converts the request method
    // to POST, just because - with love from redmond.
    if (settings.type == 'GET') return;
    if (typeof(AUTH_TOKEN) == "undefined") return;
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  })
  $('.sortable_slides').sortable({
    items: 'li',
    update: function(){
      $.ajax({
        type: 'put', 
        data: $('.sortable_slides').sortable('serialize'), 
        dataType: 'script', 
        complete: function(request){
        $('.slide').effect('highlight',{},2000);
        },
        url: "/" + $('.sortable_slides').attr('id').replace(/\./g,"/")})
    }
  });
  $('#tray ol').sortable({
    //items: 'li',
    connectWith: "ul",
    update: function(){
      $.ajax({
        type: 'put', 
        data: $('.sortable_tray').sortable('serialize'), 
        dataType: 'script', 
        complete: function(request){
          window.location.reload();
          $('#tray').effect('highlight',{},2000);
        },
        url: "/" + $('.sortable_tray').attr('id').replace(/\./g,"/")})
    },
  });
  $('ul #assets').draggable({
    items: 'li',
    connectToSortable: "#tray ol",
  });
  $("#catalog_main").droppable({
    accept:'.asset',
    activeClass:'active',  
    hoverClass:'hover',
    drop:function(ev,ui){
		  var id;
		  var asset = $(ui.draggable).clone();
		  if ($(ui.draggable).is("[id^='tp']")) {
			  id = $(ui.draggable).attr("rel");
			  asset.find("input").remove();
			  asset.attr("id", "asset_" + id);
		  } else {
			  id = $(ui.draggable).attr("id").split('_')[1];
		  }
    $.ajax({
      type: 'put',
      url: window.location.href + "/add_asset",
      data: "&asset_id="+id,
    });
    window.location.reload();
    }
  });
  $(".collapsable_label").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".labeltitle",
    startCollapsed: true
  });
  $(".collapsable_facetlabels").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".facetlabelstitle",
    startCollapsed: true
  });
  $(".collapsable_facet").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".facettitle",
    startCollapsed: true
  });
  $(".collapsable_slide").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".slidetitle",
    startCollapsed: true
  })
  $(".collapsable_catalog").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".catalogtitle",
    startCollapsed: true
  })
  $(".collapsable_classification").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".classificationtitle",
    startCollapsed: true
  })
  $(".collapsable_classificationfacet").collapsiblePanel({
    collapsedImage: "/images/collapsed.png",
    expandedImage: "/images/collapse.png",
    titleQuery: ".classificationfacettitle",
    startCollapsed: true
  })
  $("img.fit").scaleImage({
    parent: ".slot_asset",
    scale: 'fit',
    center: false
  });
  $(window).resize(function() {
    $("img.fit").scaleImage({
      parent: ".slot_asset",
      scale: 'fit',
      center: false
    }),
    $(".content .preview").css("font-size", $(window).height()/32 + 'px');
  });
});
