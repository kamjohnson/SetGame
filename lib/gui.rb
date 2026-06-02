=begin 
File Created 6/1/2026 by Kameron Johnson: Initial GUI setup using Glimmer
=end

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 800, 600) {
  margined true
  
  area {
    rectangle(0, 0, 800, 600) { # stable implicit path shape, added declaratively
      fill r: 140, g: 109, b: 173, a: 1.0
    }
  }
}.show
