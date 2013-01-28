Gem::Specification.new do |gem|
  gem.name          = "rgrmux"
  gem.authors       = ["Matt Rohrer"]
  gem.email         = ["matt@prognostikos.com"]
  gem.description   = %q{Red Green Refactor (t)mux}
  gem.summary       = %q{An RSpec formater for tmux notifications}
  gem.homepage      = "https://github.com/prognostikos/rgrmux"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = '0.0.1'
end
