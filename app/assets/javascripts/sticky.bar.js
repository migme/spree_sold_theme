;
(function ($) {
    $.fn.stickyBar = function(){
        this.each(function(){
            var $this = $(this);
            var barOffset = $this.offset().top;
            console.info("A:" + barOffset);
            $(document).on('scroll', function(){
                console.info("B:" + barOffset);
                if ($(document).scrollTop() > barOffset){
                    $this.addClass('sticky-bar');
                }else{
                    $this.removeClass('sticky-bar');
                }
            })
        })
    }
})(jQuery);