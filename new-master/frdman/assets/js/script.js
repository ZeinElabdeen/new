$(document).ready(function () {
  "use strict";


  $('[data-toggle="tooltip"]').tooltip();

  $(".menu-wrapper").on("click", function () {
    $(".hamburger-menu").toggleClass("animate");
    $(".full-menu").toggleClass('show-menu');
  });

  $(".show-search").click(function () {
    $(".search-block").slideDown();
  });
  $(".hide-search").click(function () {
    $(".search-block").slideUp();
  });

  $(window).scroll(function () {
    if ($(this).scrollTop() > 80) {
      $(".navbar").addClass("fixed-top");
      $('.scrollTop').fadeIn();
    } else {
      $(".navbar").removeClass("fixed-top");
      $('.scrollTop').fadeOut();
    }
  });

  $(".faqAccordion .btn").click(function () {
    if ($(this).hasClass("collapsed")) {
      $(this)
        .find(".icon")
        .attr("data-icon", "minus");
    } else {
      $(this)
        .find(".icon")
        .attr("data-icon", "plus");
    }
  });

  function readURL(input) {

    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('.avatar').children().attr('src', e.target.result);
        // $('<images src="" alt="images"'+ 'class="preview">').appendTo('.image-preview');
        // $('.preview').attr('src', e.target.result);
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
  $(".input-images").change(function () {
    readURL(this);
  });

  if ($("html").prop("dir") == "rtl") {
    $(".home-slider").slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      dots: false,
      cssEase: "ease-in-out",
      autoplay: true,
      speed: 1200,
      autoplaySpeed: 3000,
      arrows: true,
      rtl: true,
      prevArrow: '<a class="prev-arrow"><images src="images/icons/arrow-prev.svg"></a>',
      nextArrow: '<a class="next-arrow"><images src="images/icons/arrow-next.svg"></a>',
      responsive: [{
        breakpoint: 768,
        settings: {
          dots: false
        }
      }]
    });
    $(".testimonials .slider").slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      dots: false,
      cssEase: "ease-in-out",
      autoplay: true,
      speed: 1200,
      autoplaySpeed: 3000,
      arrows: true,
      rtl: true,
      prevArrow: '<a class="prev-arrow"><images src="images/icons/arrow-prev-black.svg"></a>',
      nextArrow: '<a class="next-arrow"><images src="images/icons/arrow-next-black.svg"></a>',
      responsive: [{
        breakpoint: 768,
        settings: {
          nav: false
        }
      }]
    });

    $(".items").slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      dots: true,
      arrows: false,
      focusOnSelect: true,
      rtl: true,
      responsive: [{
          breakpoint: 1200,
          settings: {
            slidesToShow: 3,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 992,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 768,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 540,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1
          }
        }
      ]
    });

  } else {
    $(".home-slider").slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      dots: false,
      cssEase: "ease-in-out",
      autoplay: true,
      speed: 1200,
      autoplaySpeed: 3000,
      arrows: true,
      prevArrow: '<a class="prev-arrow"><images src="images/icons/arrow-prev.svg"></a>',
      nextArrow: '<a class="next-arrow"><images src="images/icons/arrow-next.svg"></a>',
      responsive: [{
        breakpoint: 768,
        settings: {
          dots: false
        }
      }]
    });
    $(".testimonials .slider").slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      dots: false,
      cssEase: "ease-in-out",
      autoplay: true,
      speed: 1200,
      autoplaySpeed: 3000,
      arrows: true,
      prevArrow: '<a class="prev-arrow"><images src="images/icons/arrow-prev-black.svg"></a>',
      nextArrow: '<a class="next-arrow"><images src="images/icons/arrow-next-black.svg"></a>',
      responsive: [{
        breakpoint: 768,
        settings: {
          nav: false
        }
      }]
    });

    $(".items").slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      dots: true,
      arrows: false,
      focusOnSelect: true,
      responsive: [{
          breakpoint: 1200,
          settings: {
            slidesToShow: 3,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 992,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 768,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 1
          }
        },
        {
          breakpoint: 540,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1
          }
        }
      ]
    });
  }
});

$(window).on('load', function () {
  $('.loading .sk-folding-cube').delay(2000).fadeOut(function () {
    $('.loading').fadeOut();
    $('body').css('overflow', 'auto');
    new WOW().init();
    $('.counter').countTo();
  })
});