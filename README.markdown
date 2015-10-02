An implementation of Douglas ExtendedHexs Base32-Encoding in Ruby

see <http://www.extended_hex.com/wrmg/base32.html>

Gemfile Installation
============

    gem 'base32-extended-hex', git: "git://github.com/gbenedict/base32-extended-hex-alphabet.git"

Changes
=======

    0.0.1 - initial release

Usage
=====

    #!/usr/bin/env ruby

    require 'base32/extended_hex'

    Base32::ExtendedHex.encode(1234)                            # => "16I"
    Base32::ExtendedHex.decode("16I")                            # => 1234
    Base32::ExtendedHex.encode(100**10, :split=>5, :length=>15)                  # => "02MNH-QU5LH-H0000"
    Base32::ExtendedHex.decode("02MNH-QU5LH-H0000")                            # => 100000000000000000000
