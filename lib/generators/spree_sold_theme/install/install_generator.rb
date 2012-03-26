module SpreeSoldTheme
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file "app/assets/javascripts/store/all.js", "//= require store/spree_sold_theme\n"
      end

      def add_stylesheets
        inject_into_file "app/assets/stylesheets/store/all.css", " *= require store/spree_sold_theme\n", :before => /\*\//, :verbose => true
      end

      def add_config_files
        template 'config/initializers/simple_form.rb', 'config/initializers/simple_form.rb'
        template 'config/locales/simple_form.en.yml', 'config/locales/simple_form.en.yml'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_sold_theme'
      end

      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'bundle exec rake db:migrate'
        else
          puts "Skiping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
