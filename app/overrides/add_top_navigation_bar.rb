Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{add_top_nav},
                          :insert_top => %q{[data-hook='body']},
                          :partial => 'spree/shared/top_nav')
