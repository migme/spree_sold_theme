Deface::Override.new(:virtual_path => %q{spree/products/show},
                     :name => %q{remove_product_properties_in_show_product},
                     :remove => %q{[data-hook='product_properties']})
