$(document).ready(function(){
  var performWikiSearch = function() {
    var wiki_qry_path = $("input.wiki_submit").data("wiki-qry-path");
    var search_key = $("input#file_asset_search_key").val();
    $("#wiki_search_result").load(wiki_qry_path,{'search_key': search_key});
  };
  $(document).ajaxComplete(function() {
    $("input.wiki_submit").one("click", function(event){
      event.preventDefault();
      performWikiSearch();
    });
    $("input#file_asset_search_key").one("keydown", function(event){
      if (event.which == 13) {
        event.preventDefault();
        performWikiSearch();
      };
    });
  });
});
