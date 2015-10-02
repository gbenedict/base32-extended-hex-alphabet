# encoding: UTF-8
#
# Based on https://github.com/levinalex/base32
#
# This file is released under the same license as ruby.

require 'enumerator'

module Base32
end

# encode a value with the extended hex alphabet
# <https://tools.ietf.org/html/rfc4648#page-10>
#
# this is *not* the same as the Base32 encoding defined in RFC 4648
# it is similar to Crockford Base32 encoding, but the chars are different.
#
# Hyphens (-) can be inserted into symbol strings. This can partition a
# string into manageable pieces, improving readability by helping to prevent
# confusion. Hyphens are ignored during decoding. An application may look for
# hyphens to assure symbol string correctness.
#
#
class Base32::ExtendedHex
  VERSION = "0.0.1"

  ENCODE_CHARS =
    %w(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V ?)

  DECODE_MAP = ENCODE_CHARS.to_enum(:each_with_index).inject({}) do |h,(c,i)|
    h[c] = i; h
  end

  # encodes an integer into a string
  #
  # when +split+ is given a hyphen is inserted every <n> characters to improve
  # readability
  #
  # when +length+ is given, the resulting string is zero-padded to be exactly
  # this number of characters long (hyphens are ignored)
  #
  #   Base32::ExtendedHex.encode(1234) # => "16I"
  #   Base32::ExtendedHex.encode(123456789012345, :split=>5) # => "3G923-0RNRP"
  #
  def self.encode(number, opts = {})
    # verify options
    raise ArgumentError unless (opts.keys - [:length, :split] == [])

    str = number.to_s(2).reverse.scan(/.{1,5}/).map do |bits|
      ENCODE_CHARS[bits.reverse.to_i(2)]
    end.reverse.join

    str = str.rjust(opts[:length], '0') if opts[:length]

    if opts[:split]
      str = str.reverse
      str = str.scan(/.{1,#{opts[:split]}}/).map { |x| x.reverse }
      str = str.reverse.join("-")
    end

    str
  end

  # decode a string to an integer
  #
  # the string is converted to uppercase and hyphens are stripped before
  # decoding
  #
  # returns +nil+ if the string contains invalid characters and can't be
  # decoded
  #
  def self.decode(string)
    clean(string).split(//).map { |char|
      DECODE_MAP[char] or return nil
    }.inject(0) { |result,val| (result << 5) + val }
  end

  # same as decode, but raises ArgumentError when the string can't be decoded
  #
  def self.decode!(string)
    decode(string) or raise ArgumentError
  end

  # return the canonical encoding of a string. converts it to uppercase
  # and removes hyphens
  #
  # replaces invalid characters with a question mark ('?')
  #
  def self.normalize(string)
    clean(string).split(//).map { |char|
      ENCODE_CHARS[DECODE_MAP[char] || 32]
    }.join
  end

  # returns false iff the string contains invalid characters and can't be
  # decoded
  #
  def self.valid?(string)
    !(normalize(string) =~ /\?/)
  end

  class << self
    def clean(string)
      string.gsub(/-/,'').upcase
    end
    private :clean
  end
end

