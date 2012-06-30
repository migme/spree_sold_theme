#Deface::Override.new(:virtual_path => %q{spree/products/show},
#                          :name => %q{replace_cart_form},
#                          :replace => %q{code:contains("render :partial => 'cart_form'")},
#                          :text => %q{<code erb-loud>render(:partial => 'sale_cart_form')</code>})