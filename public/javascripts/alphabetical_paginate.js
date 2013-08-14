$(function() {
    var once = false,
        img = "<img src='/images/loader.gif' class='loading'/>";
    
    $(document).on("click", ".pagination#alpha a", function(e) {
        var url = location.href,
            letter = $(this).data("letter");
        if (/letter/.test(url)){
          url = url.replace(/letter=[^&]*/,"letter=" + letter); 
        }
        else {
          if (/\?/.test(url)) {
            url += "&letter=" + letter;
          }
          else {
            url += "?letter=" + letter;
          }
        }
        $(".pagination").html(img);
        //$.load(url + " #pagination_table");
        $.get(url, function(result) {
          $(".pagination").html($(".pagination", result));
          $("#pagination_table").html($("#pagination_table", result));
        });
        history.pushState(null, document.title, url);
        e.preventDefault();
    });


 // let navigate the browser throught the ajax history
$(window).bind("popstate", function() {
  if (once) {
    $(".pagination").html(img);
    $.get(location.href, function(result) {
      $(".pagination").html($(".pagination", result));
        $("#pagination_table").html($("#pagination_table", result));
      });
    } else {
      once = true;
    }
});


});
