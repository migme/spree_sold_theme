Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{add_footer},
                          :insert_bottom => %q{[data-hook='body']},
                          :partial => 'spree/shared/footer')
