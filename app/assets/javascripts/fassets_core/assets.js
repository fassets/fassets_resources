$(document).ready(function(){
  $(".asset").live("mouseenter",function(event){
    $(this).find(".asset_actions").fadeIn(150);
  });
  $(".asset").live("mouseleave",function(event){
    $(this).find(".asset_actions").fadeOut(100);
  }); 
});
