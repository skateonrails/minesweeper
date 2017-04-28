# frozen_string_literal: true

# requiring ruby dependencies
require 'matrix'
require 'ostruct'

# requiring printers
require_relative 'printers/simple_printer'
require_relative 'printers/pretty_printer'

# requiring helpers
require_relative 'lib/helpers/board_helper'
require_relative 'lib/helpers/tile_helper'

# requiring lib files
require_relative 'lib/exceptions'
require_relative 'lib/tile'
require_relative 'lib/board'
require_relative 'lib/minesweeper'
