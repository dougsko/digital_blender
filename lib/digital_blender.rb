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
        @n = 17
        # for testing
        960.times do |i|
            SHA1.digest(i.to_s).each_byte do |b|
                @data << b
            end
        end
    end

    def n_way_turn()
        @data.each_byte do |b|
            begin
                sets[@data.index(b) % @n] << b
            rescue
                sets[@data.index(b) % @n] = [b]
            end
        end
        sets
    end

    def xor_fold_rot()
        buf = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        sets.each do |set|
            buf.size.times do |i|
                set[i*20..i*20+19].each do |n|
                    buf[i] ^= n
                    buf.push(buf.shift)
                end
            end
        end
        buf
    end


end
