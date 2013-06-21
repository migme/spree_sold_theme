jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.dropdown-toggle').dropdown()
  $('.carousel').carousel()
  $(".yes_no:checkbox").iphoneStyle({
        checkedLabel: 'Yes',
        uncheckedLabel: 'No',
        onChange: (e,v) ->
          hide_dom = $(e).data('toggle-form')
          if hide_dom
            if $(e).is(":checked")
              $("##{hide_dom}").show()
            else
              $("##{hide_dom}").hide()
      }
  )
