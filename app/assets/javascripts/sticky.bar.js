;
(function ($) {
    $.fn.stickyBar = function(){
        this.each(function(){
            var $this = $(this);
            var barOffset = $this.offset().top;
            $(document).on('scroll', function(){
                if ($(document).scrollTop() > barOffset){
                    $this.addClass('sticky-bar');
                }else{
                    $this.removeClass('sticky-bar');
                }
            })
        })
    }
})(jQuery);