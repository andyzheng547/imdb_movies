# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
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
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
