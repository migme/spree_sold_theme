Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{add_top_nav},
                          :insert_top => %q{[data-hook='body']},
                          :partial => 'spree/shared/top_nav',
                          :original => 'd514f60a9c1a9a1d1d8023adb98ff06ef0f366e1')
