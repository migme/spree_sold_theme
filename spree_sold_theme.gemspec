# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_sold_theme'
  s.version     = '1.0.0'
  s.summary     = 'Revamp themes soldsg project'
  s.description = 'Sold.sg revamp layout'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'Quy Doan'
  s.email             = 'quydoantran@gmail.com'
  # s.homepage          = 'http://www.spreecommerce.com'

  s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = ['lib']
  s.requirements << 'none'

  s.add_dependency "less-rails-bootstrap"
  s.add_dependency 'spree_core', '~> 1.0.0'
  s.add_dependency 'simple_form'
end
