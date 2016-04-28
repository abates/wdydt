$(document).ready(function() {
  if ($('.page-navigation').size() > 0) {
    var page = 0;
    var lastPage = $.getQueryParameters($('.page-navigation .last-page').attr('href')).page
    console.log("First page ", page, " last page ", lastPage);
    $('.page-navigation').each(function() {
      $(this).hide();
    });

    $(window).on('scroll', function() {
      if($(window).scrollTop() + $(window).height() == $(document).height() && page <= lastPage) {
        var params = $.getQueryParameters();
        params.page = page;
        var url = $.getUpdatedUrl(params);
        $.getScript(url, function() {
          page++;
        });
      }
    });
  }
});
