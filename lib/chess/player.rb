module Chess
  class Player
    attr_reader :color, :order_player
    attr_accessor :computer_player
    def initialize(color, order)
      @order_player = order #player1, player2
      @color = color
    end
  end
end
