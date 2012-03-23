Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{remove_all_footer},
                          :remove => %q{footer#footer},
                          :original => '1863ad7604779657cf4f82859cfa2efda9ceb0c8')

Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{add_footer},
                          :insert_bottom => %q{[data-hook='body']},
                          :partial => 'spree/shared/footer',
                          :original => '3dbbb63c87799c243fb392d7c48d97cbca81edc4')

