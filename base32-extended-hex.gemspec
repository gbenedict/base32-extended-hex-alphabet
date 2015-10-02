$:.push File.expand_path("../lib", __FILE__)
require 'base32/extended_hex'

Gem::Specification.new do |gem|
  gem.authors = ["gbenedict"]
  gem.email = ["gbenedict@gmail.com"]
  gem.description = "Base32 Extended Hex Alphabet Encoding/Decoding in Ruby"
  gem.summary = "32-symbol hex notation for expressing numbers in a form that can be conveniently and accurately transmitted between humans"
  gem.homepage = "https://github.com/gbenedict/base32-extended-hex-alphabet"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name = 'base32-extended-hex'
  gem.require_paths = ['lib']
  gem.version = Base32::ExtendedHex::VERSION

  gem.add_development_dependency 'rake'
end
