Deface::Override.new(:virtual_path => %q{spree/shared/_head},
                     :name => %q{add_facebook_javascript},
                     :insert_after => %q{meta[name='viewport']},
                     :text => %Q{<script src='http://connect.facebook.net/en_US/all.js'></script>
                                 <script>FB.init({appId:"405446656151324", status:true, cookie:true});</script>
                                })

Deface::Override.new(:virtual_path => %q{spree/layouts/spree_application},
                          :name => %q{add_div_fb_root_to_footer},
                          :insert_bottom => %q{[data-hook='body']},
                          :text => %Q{<div id="fb-root"></div>}   )