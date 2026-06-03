=begin 
File Created 6/1/2026 by Kameron Johnson: Initial GUI setup using Glimmer
=end

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 800, 600) {
  margined true

  label {
      text 'Welcome to the Set Game!'
      font size: 24, weight: :bold
      color r: 255, g: 255, b: 255
    }
  
  area {
    rectangle(0, 0, 1024, 768) { # stable implicit path shape, added declaratively
      fill r: 140, g: 109, b: 173, a: 1.0
    }
    
  }
}.show

