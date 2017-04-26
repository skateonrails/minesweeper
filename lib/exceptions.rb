# frozen_string_literal: true

# MineAlreadyPlacedError raise when tile tries to set mine
# more than once
class MineAlreadyPlacedError < StandardError; end
