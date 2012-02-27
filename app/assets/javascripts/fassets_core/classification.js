$(document).ready(function(){
    $("#sidebar .classification_create").click(function(event){
      event.preventDefault();
      $.fancybox.showActivity();
      var catalog_id = $("#fancybox-content #classification_catalog_id :selected").val();
      var asset_id = $("#fancybox-content #classification_asset_id").val();
	    $.ajax({
		    type		: "POST",
		    cache	: false,
		    url		: "/classifications?asset_id="+asset_id+"&catalog_id="+catalog_id,
		    success: function(data) {        
          $("#fancybox-content #sidebar").load("/asset/"+asset_id+"/classifications");
        }
      });
      $.fancybox.resize();;
      $.fancybox.hideActivity();
    });
    $("#sidebar .classification_drop").click(function(event){
      event.preventDefault();
      $.fancybox.showActivity();
      var classification_id = $(event.target).attr("classification_id");
      var asset_id = $("#fancybox-content #classification_asset_id").val();
	    $.ajax({
		    type		: "DELETE",
		    cache	: false,
		    url		: "/classifications/"+classification_id,
		    success: function(data) {
		      $("#fancybox-content #sidebar").load("/asset/"+asset_id+"/classifications");
		    }
      });
      $.fancybox.resize();
      $.fancybox.hideActivity();
    });
});
