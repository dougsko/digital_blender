#!/usr/bin/env ruby
#
# Ruby version of LavaRnd Digital Blender
#
require 'digest/sha1'

include Digest

class DigitalBlender
    def initialize
        @data = ""
        @sets = []
        @rotated = []
        @hashed = []
        @n = 17
        @results = []
        # for testing (150KB)
        960.times do |i|
            SHA1.digest(i.to_s).each_byte do |b|
                @data << b
            end
        end
    end

    def n_way_turn()
        @data.each_byte do |b|
            begin
                @sets[@data.index(b) % @n] << b
            rescue
                @sets[@data.index(b) % @n] = [b]
            end
        end
    end

    def hash_xor_fold_rot()
        @sets.each do |set|
            temp = []
            SHA1.digest(set.join(',').gsub(/,/,'')).each_byte do |b|
                begin
                    temp << b
                rescue
                    temp = [b]
                end
            end
            @hashed << temp
        end
        
        # xor and rotate
        buf = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        @sets.each do |set|
            set.size.times do |i|
                buf[i % 20] ^= set[i]
                buf << buf.shift
            end
            @rotated += buf
        end
        arr = @rotated.dup
        result = []
        while ! arr.empty?
            result << arr.slice!(0..19)
        end
        @rotated = result
    end

    def xor_hashed_rotated
        @hashed.size.times do |i|
            @hashed[i].size.times do |j|
                @results << (@hashed[i][j] ^ @rotated[i][j])
            end
        end
    end


            


end


