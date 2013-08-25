// Requires JQuery

$('h1, h2, h3, h4, h5, h6, h7, h8').hover(function () {
    var id_tag = $(this).attr('id');
    if (id_tag) {
        $(this).append('<a id="linktoself" href=#"' + id_tag + '">&#x00b6</a>');
    }
}, function () {
    $(this).children().hide();
});