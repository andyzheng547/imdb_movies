# coding: utf-8
bin = File.expand_path('../bin', __FILE__)
$LOAD_PATH.unshift(bin) unless $LOAD_PATH.include?(bin)
require 'imdb_movies/version'

Gem::Specification.new do |spec|
  spec.name          = "imdb_movies"
  spec.version       = ImdbMovies::VERSION
  spec.authors       = ["azheng249"]
  spec.email         = ["andy.zheng249@gmail.com"]

  spec.summary       = %q{Look at current/upcoming movies via. IMDB's website}
  spec.description   = %q{Navigate the CLI menu. View info and play trailers for upcomng films.}
  spec.homepage      = "https://github.com/azheng249/imdb_movies"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["imdb_movies"]
  spec.require_paths = ["bin"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"  
  spec.add_development_dependency "pry"
end
