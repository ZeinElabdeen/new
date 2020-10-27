jQuery(function ($) {

    $(".sidebar-dropdown > a").click(function () {
        $(".sidebar-submenu").slideUp(200);
        if (
            $(this)
                .parent()
                .hasClass("active")
        ) {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .parent()
                .removeClass("active");
        } else {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .next(".sidebar-submenu")
                .slideDown(200);
            $(this)
                .parent()
                .addClass("active");
        }
    });

    $("#close-sidebar i").click(function () {
        $(".page-wrapper").removeClass("toggled");
    });
    $(".open").click(function () {
        $(".page-wrapper").addClass("toggled");
    });

    $('.owl-carousel').owlCarousel({
        items: 1,
        loop:true,
        margin:10,
        nav: false,
        autoplay: true,
        rtl: true
    })

});


// play video
$(document).on('click', '.js-videoPoster', function (ev) {

    'use strict';

    ev.preventDefault();
    var $poster = $(this);
    var $wrapper = $poster.closest('.js-videoWrapper');
    videoPlay($wrapper);
});

function videoPlay($wrapper) {
    'use strict';

    var $iframe = $wrapper.find('.js-videoIframe');
    var src = $iframe.data('src');
    $wrapper.addClass('videoWrapperActive');
    $iframe.attr('src', src);
}

function videoStop($wrapper) {

    'use strict';

    var $iframe;

    if (!$wrapper) {
        $wrapper = $('.js-videoWrapper');
        $iframe = $('.js-videoIframe');
    } else {
        $iframe = $wrapper.find('.js-videoIframe');
    }
    $wrapper.removeClass('videoWrapperActive');
    $iframe.attr('src', '');
}