require_relative '../chess'
 
describe Game do

  before(:all) do
    @player1 = Player.new("white", "player1")
    @player2 = Player.new("black", "player2")
  end

  context "movement of piece" do
    context "white pawn" do
      context "with no pieces in front" do
        before(:each) do
          @board = Board.new
          @piece = WhitePawn.new("white", 4, 6)
          @board.squares[4][6] = @piece
          @board.find_possible_moves_white_pawn(@piece)
          @game = Game.new(@board)
        end
        
        it "moves 1 squares on first move" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 5])).to eql(true)
        end

        it "moves 2 squares on first move" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 4])).to eql(true)
        end

        it "can't move 3 squares on first move" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 3])).to eql(false)
        end

        it "can't move backwards" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 7])).to eql(false)
        end
      end

      context "with pieces in front" do
        before(:each) do
          @board = Board.new
          @piece = WhitePawn.new("white", 4, 6)
          @board.squares[4][6] = @piece
          @board.squares[4][5] = Knight.new("black", 4, 5)
          @board.find_possible_moves_white_pawn(@piece)
          @game = Game.new(@board)
        end

        it "can't move 2 squares on first move" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 4])).to eql(false)
        end

        it "can't move 1 square" do
          expect(@game.board.squares[4][6].possible_moves.include?([4, 5])).to eql(false)
        end

      end

      context "with pieces in the first square on a diagonal" do
        before(:each) do
          @board = Board.new
          @piece = WhitePawn.new("white", 4, 6)
          @board.squares[4][6] = @piece
          @board.squares[5][5] = Knight.new("black", 5, 5)
          @board.squares[3][5] = Queen.new("white", 3, 5)
          @board.squares[3][7] = Bishop.new("black", 3, 7)
          @board.find_possible_moves_white_pawn(@piece)
          @game = Game.new(@board)
        end

        it "can't take piece of same color" do
          expect(@game.board.squares[4][6].possible_moves.include?([3, 5])).to eql(false)
        end

        it "can't take piece behind of it" do
          expect(@game.board.squares[4][6].possible_moves.include?([3, 7])).to eql(false)
        end

        it "can take piece of different color" do
          expect(@game.board.squares[4][6].possible_moves.include?([5, 5])).to eql(true)
        end
      end

      context "after having moved once" do
        before(:each) do
          @board = Board.new
          @piece = WhitePawn.new("white", 4, 5)
          @board.squares[4][5] = @piece
          @board.find_possible_moves_white_pawn(@piece)
          @game = Game.new(@board)
        end
        
        it "moves 1 squares" do
          expect(@game.board.squares[4][5].possible_moves.include?([4, 4])).to eql(true)
        end

        it "can't move 2 squares" do
          expect(@game.board.squares[4][5].possible_moves.include?([4, 3])).to eql(false)
        end

        it "can't move in diagonal" do
          expect(@game.board.squares[4][5].possible_moves.include?([3, 4])).to eql(false)
        end

        it "can't move backwards" do
          expect(@game.board.squares[4][5].possible_moves.include?([4, 6])).to eql(false)
        end
      end
     
    end

    context "black pawn" do
      context "with no pieces in front" do
        before(:each) do
          @board = Board.new
          @piece = BlackPawn.new("black", 4, 1)
          @board.squares[4][1] = @piece
          @board.find_possible_moves_black_pawn(@piece)
          @game = Game.new(@board)
        end
        
        it "moves 1 squares on first move" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 2])).to eql(true)
        end

        it "moves 2 squares on first move" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 3])).to eql(true)
        end

        it "can't move 3 squares on first move" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 4])).to eql(false)
        end

        it "can't move backwards" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 0])).to eql(false)
        end
      end

      context "with pieces in front" do
        before(:each) do
          @board = Board.new
          @piece = BlackPawn.new("black", 4, 1)
          @board.squares[4][1] = @piece
          @board.squares[4][2] = Knight.new("white", 4, 2)
          @board.find_possible_moves_black_pawn(@piece)
          @game = Game.new(@board)
        end

        it "can't move 2 squares on first move" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 3])).to eql(false)
        end

        it "can't move 1 square" do
          expect(@game.board.squares[4][1].possible_moves.include?([4, 2])).to eql(false)
        end

      end

      context "with pieces in the first square on a diagonal" do
        before(:each) do
          @board = Board.new
          @piece = BlackPawn.new("black", 4, 1)
          @board.squares[4][1] = @piece
          @board.squares[3][2] = Knight.new("white", 3, 2)
          @board.squares[5][2] = Queen.new("black", 5, 2)
          @board.squares[3][0] = Bishop.new("white", 3, 0)
          @board.find_possible_moves_black_pawn(@piece)
          @game = Game.new(@board)
        end

        it "can't take piece of same color" do
          expect(@game.board.squares[4][1].possible_moves.include?([5, 2])).to eql(false)
        end

        it "can't take piece behind of it" do
          expect(@game.board.squares[4][1].possible_moves.include?([3, 0])).to eql(false)
        end

        it "can take piece of different color" do
          expect(@game.board.squares[4][1].possible_moves.include?([3, 2])).to eql(true)
        end
      end

      context "after having moved once" do
        before(:each) do
          @board = Board.new
          @piece = BlackPawn.new("black", 4, 3)
          @board.squares[4][3] = @piece
          @board.find_possible_moves_black_pawn(@piece)
          @game = Game.new(@board)
        end
        
        it "moves 1 squares" do
          expect(@game.board.squares[4][3].possible_moves.include?([4, 4])).to eql(true)
        end

        it "can't move 2 squares" do
          expect(@game.board.squares[4][3].possible_moves.include?([4, 5])).to eql(false)
        end

        it "can't move in diagonal" do
          expect(@game.board.squares[4][3].possible_moves.include?([5, 4])).to eql(false)
        end

        it "can't move backwards" do
          expect(@game.board.squares[4][3].possible_moves.include?([4, 2])).to eql(false)
        end
      end
     
    end

    context "rook" do
      before(:each) do
        @board = Board.new
        @piece = Rook.new("white", 4, 3)
        @board.squares[4][3] = @piece
        @board.squares[4][1] = Queen.new("black", 4, 1)
        @board.squares[2][3] = WhitePawn.new("white", 2, 3)
        @board.find_possible_moves_rook(@piece)
        @game = Game.new(@board)
      end

      it "can't move out of the board" do
        expect(@game.board.squares[4][3].possible_moves.include?([8, 3])).to eql(false)
      end

      it "can't move in diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 4])).to eql(false)
      end

      it "can move to the right" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 3])).to eql(true)
      end

      it "can move to the right one square" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 3])).to eql(true)
      end

      it "can't move to the position of a piece with the same color" do
        expect(@game.board.squares[4][3].possible_moves.include?([2, 3])).to eql(false)
      end

      it "can't move over a piece with the same color" do
        expect(@game.board.squares[4][3].possible_moves.include?([1, 3])).to eql(false)
      end

      it "can move to the position of a piece with a different color" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 1])).to eql(true)
      end

      it "can't move over a piece with a different color" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 0])).to eql(false)
      end
    end

    context "bishop" do
      before(:each) do
        @board = Board.new
        @piece = Bishop.new("white", 4, 3)
        @board.squares[4][3] = @piece
        @board.squares[6][1] = Queen.new("black", 6, 1)
        @board.squares[6][5] = WhitePawn.new("white", 6, 5)
        @board.find_possible_moves_bishop(@piece)
        @game = Game.new(@board)
      end

      it "can't move out of the board" do
        expect(@game.board.squares[4][3].possible_moves.include?([8, 7])).to eql(false)
      end

      it "can't move in horizontal" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 3])).to eql(false)
      end

      it "can't move in vertical" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 2])).to eql(false)
      end

      it "can move in diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([0, 7])).to eql(true)
      end

      it "can move in diagonal one square" do
        expect(@game.board.squares[4][3].possible_moves.include?([3, 2])).to eql(true)
      end

      it "can't move to the position of a piece with the same color" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 5])).to eql(false)
      end

      it "can't move over a piece with the same color" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 6])).to eql(false)
      end

      it "can move to the position of a piece with a different color" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 1])).to eql(true)
      end

      it "can't move over a piece with a different color" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 0])).to eql(false)
      end
    end

    context "queen" do
      before(:each) do
        @board = Board.new
        @piece = Queen.new("black", 4, 3)
        @board.squares[4][3] = @piece
        @board.squares[6][1] = King.new("black", 6, 1)
        @board.squares[6][5] = WhitePawn.new("white", 6, 5)
        @board.squares[4][2] = BlackPawn.new("black", 4, 2)
        @board.squares[3][3] = Bishop.new("white", 3, 3)
        @board.find_possible_moves_queen(@piece)
        @game = Game.new(@board)
      end

      it "can't move out of the board in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([0, -1])).to eql(false)
      end

      it "can't move two squares to the right and one up" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 2])).to eql(false)
      end

      it "can move in diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([0, 7])).to eql(true)
      end

      it "can move in diagonal one square" do
        expect(@game.board.squares[4][3].possible_moves.include?([3, 2])).to eql(true)
      end

      it "can't move to the position of a piece with the same color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 1])).to eql(false)
      end

      it "can't move over a piece with the same color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 0])).to eql(false)
      end

      it "can move to the position of a piece with a different color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([6, 5])).to eql(true)
      end

      it "can't move over a piece with a different color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 6])).to eql(false)
      end

      it "can't move out of the board in a horizontal" do
        expect(@game.board.squares[4][3].possible_moves.include?([8, 3])).to eql(false)
      end

      it "can move to the right" do
        expect(@game.board.squares[4][3].possible_moves.include?([7, 3])).to eql(true)
      end

      it "can move to the right one square" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 3])).to eql(true)
      end

      it "can't move to the position of a piece with the same color in a vertical" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 2])).to eql(false)
      end

      it "can't move over a piece with the same color in a vertical" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 1])).to eql(false)
      end

      it "can move to the position of a piece with a different color in a horizontal" do
        expect(@game.board.squares[4][3].possible_moves.include?([3, 3])).to eql(true)
      end

      it "can't move over a piece with a different color in a horizontal" do
        expect(@game.board.squares[4][3].possible_moves.include?([2, 3])).to eql(false)
      end
    end

    context "king" do
      before(:each) do
        @board = Board.new
        @piece = King.new("black", 4, 3)
        @board.squares[4][3] = @piece
        @board.squares[5][2] = Queen.new("black", 5, 2)
        @board.squares[5][4] = Rook.new("white", 5, 4)
        @board.squares[4][2] = BlackPawn.new("black", 4, 2)
        @board.squares[3][3] = Bishop.new("white", 3, 3)
        @board.find_possible_moves_king(@piece)
        @game = Game.new(@board)
      end

      it "can't move two squares in diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([2, 1])).to eql(false)
      end

      it "can move in diagonal one square" do
        expect(@game.board.squares[4][3].possible_moves.include?([3, 2])).to eql(true)
      end

      it "can't move to the position of a piece with the same color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 2])).to eql(false)
      end

      it "can move to the position of a piece with a different color in a diagonal" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 4])).to eql(true)
      end

      it "can move one square to the right" do
        expect(@game.board.squares[4][3].possible_moves.include?([5, 3])).to eql(true)
      end

      it "can't move to the position of a piece with the same color in a vertical" do
        expect(@game.board.squares[4][3].possible_moves.include?([4, 2])).to eql(false)
      end

      it "can move to the position of a piece with a different color in a horizontal" do
        expect(@game.board.squares[4][3].possible_moves.include?([3, 3])).to eql(true)
      end

    end

    context "knight" do
      before(:each) do
        @board = Board.new
        @piece = Knight.new("black", 1, 5)
        @board.squares[1][5] = @piece
        @board.squares[2][7] = King.new("black", 2, 7)
        @board.squares[2][4] = BlackPawn.new("black", 2, 4)
        @board.squares[0][3] = Bishop.new("white", 0, 3)
        @board.find_possible_moves_knight(@piece)
        @game = Game.new(@board)
      end

      it "can't move out of the board" do
        expect(@game.board.squares[1][5].possible_moves.include?([-1, 6])).to eql(false)
      end

      it "can take piece of different color" do
        expect(@game.board.squares[1][5].possible_moves.include?([0, 3])).to eql(true)
      end

      it "can move over another piece" do
        expect(@game.board.squares[1][5].possible_moves.include?([2, 3])).to eql(true)
      end

      it "can move to an empty square" do
        expect(@game.board.squares[1][5].possible_moves.include?([3, 6])).to eql(true)
      end

      it "can't move to a square with a piece of same color" do
        expect(@game.board.squares[1][5].possible_moves.include?([2, 7])).to eql(false)
      end

      it "can't move in a horizontal" do
        expect(@game.board.squares[1][5].possible_moves.include?([0, 5])).to eql(false)
      end

      it "can't move in a vertical" do
        expect(@game.board.squares[1][5].possible_moves.include?([1, 4])).to eql(false)
      end

      it "can't move in a diagonal" do
        expect(@game.board.squares[1][5].possible_moves.include?([2, 6])).to eql(false)
      end

    end

  end

  context "white player encastling with king's rook" do
    before(:all) do
      @board = Board.new
      @board.squares[4][7] = King.new("white", 4, 7)
      @board.squares[7][7] = Rook.new("white", 7, 7)
      @board.squares[0][7] = Rook.new("white", 0, 7)
      @game = Game.new(@board)
    end
    
    context " with pieces between king and rook" do
      before do
        @board.squares[6][7] = Knight.new("white", 6, 7)
      end

      after do
        @board.squares[6][7] = nil
      end
   
      it "can't encastle when piece between king and rook" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when king in check" do
      before do
        @board.squares[4][5] = Rook.new("black", 4, 5)
      end
 
      after do
        @board.squares[4][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when adjacent square to the right of king is in check" do
      before do
        @board.squares[5][5] = Rook.new("black", 5, 5)
      end

      after do
        @board.squares[5][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when second square to the right of king in check" do
      before do
        @board.squares[6][5] = Rook.new("black", 6, 5)
      end

      after do
        @board.squares[6][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when king has moved" do
      before do
        @player1.king_moved = true
      end

      after do
        @player1.king_moved = false
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when king's rook has moved" do
      before do
        @player1.king_rook_moved = true
      end
   
      after do
        @player1.king_rook_moved = false
      end

      it "can't encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(false)
      end
    end

    context " when king's rook in check" do
      before do
        @board.squares[7][5] = Rook.new("black", 7, 5)
      end

      after do
        @player1.king_moved = false
        @game.board.make_move([6, 7],[4, 7])
        @game.board.make_move([5, 7],[7, 7])
        @board.squares[7][5] = nil
      end
   
      it "can encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(true)
        expect(@game.board.squares[6][7].class).to eql(King)
        expect(@game.board.squares[5][7].class).to eql(Rook)
      end
    end

    context "when no piece is between king and rook" do
      after do
        @player1.king_moved = false
        @game.board.make_move([6, 7],[4, 7])
        @game.board.make_move([5, 7],[7, 7])
      end

      it "can encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(true)
        expect(@game.board.squares[6][7].class).to eql(King)
        expect(@game.board.squares[5][7].class).to eql(Rook)
      end
    end

    context "when the queen's rook has moved" do
      before do
        @player1.queen_rook_moved = true
      end
      after do
        @player1.queen_rook_moved = false
        @game.board.make_move([6, 7],[4, 7])
        @game.board.make_move([5, 7],[7, 7])
      end

      it "can encastle" do
        expect(@game.board.encastle_right(@player1)).to eql(true)
        expect(@game.board.squares[6][7].class).to eql(King)
        expect(@game.board.squares[5][7].class).to eql(Rook)
      end
    end

  end

  context "white player encastling with queen's rook" do
    before(:all) do
      @board = Board.new
      @board.squares[4][7] = King.new("white", 4, 7)
      @board.squares[7][7] = Rook.new("white", 7, 7)
      @board.squares[0][7] = Rook.new("white", 0, 7)
      @game = Game.new(@board)
    end
    
    context " with pieces between king and rook" do
      before do
        @board.squares[2][7] = Knight.new("white", 2, 7)
      end

      after do
        @board.squares[2][7] = nil
      end
   
      it "can't encastle when piece between king and rook" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when king in check" do
      before do
        @board.squares[4][5] = Rook.new("black", 4, 5)
      end
 
      after do
        @board.squares[4][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when adjacent square to the left of king is in check" do
      before do
        @board.squares[3][5] = Rook.new("black", 3, 5)
      end

      after do
        @board.squares[3][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when second square to the left of king in check" do
      before do
        @board.squares[2][5] = Rook.new("black", 2, 5)
      end

      after do
        @board.squares[2][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when third square to the left of king in check" do
      before do
        @board.squares[1][5] = Rook.new("black", 1, 5)
      end

      after do
        @board.squares[1][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when king has moved" do
      before do
        @player1.king_moved = true
      end

      after do
        @player1.king_moved = false
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when queen's rook has moved" do
      before do
        @player1.queen_rook_moved = true
      end
   
      after do
        @player1.queen_rook_moved = false
      end

      it "can't encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(false)
      end
    end

    context " when queen's rook in check" do
      before do
        @board.squares[0][5] = Rook.new("black", 0, 5)
      end

      after do
        @player1.king_moved = false
        @game.board.make_move([2, 7],[4, 7])
        @game.board.make_move([3, 7],[0, 7])
        @board.squares[0][5] = nil
      end
   
      it "can encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(true)
        expect(@game.board.squares[2][7].class).to eql(King)
        expect(@game.board.squares[3][7].class).to eql(Rook)
      end
    end

    context "when no piece is between king and rook" do
      after do
        @player1.king_moved = false
        @game.board.make_move([2, 7],[4, 7])
        @game.board.make_move([3, 7],[0, 7])
      end

      it "can encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(true)
        expect(@game.board.squares[2][7].class).to eql(King)
        expect(@game.board.squares[3][7].class).to eql(Rook)
      end
    end

    context "when the king's rook has moved" do
      before do
        @player1.king_rook_moved = true
      end
      after do
        @player1.king_rook_moved = false
        @game.board.make_move([2, 7],[4, 7])
        @game.board.make_move([3, 7],[0, 7])
      end

      it "can encastle" do
        expect(@game.board.encastle_left(@player1)).to eql(true)
        expect(@game.board.squares[2][7].class).to eql(King)
        expect(@game.board.squares[3][7].class).to eql(Rook)
      end
    end

  end






  context "black player encastling with king's rook" do
    before(:all) do
      @board = Board.new
      @board.squares[4][0] = King.new("black", 4, 0)
      @board.squares[7][0] = Rook.new("black", 7, 0)
      @board.squares[0][0] = Rook.new("black", 0, 0)
      @game = Game.new(@board)
    end
    
    context " with pieces between king and rook" do
      before do
        @board.squares[6][0] = Knight.new("white", 6, 0)
      end

      after do
        @board.squares[6][0] = nil
      end
   
      it "can't encastle when piece between king and rook" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when king in check" do
      before do
        @board.squares[4][5] = Rook.new("white", 4, 5)
      end
 
      after do
        @board.squares[4][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when adjacent square to the right of king is in check" do
      before do
        @board.squares[5][5] = Rook.new("white", 5, 5)
      end

      after do
        @board.squares[5][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when second square to the right of king in check" do
      before do
        @board.squares[6][5] = Rook.new("white", 6, 5)
      end

      after do
        @board.squares[6][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when king has moved" do
      before do
        @player2.king_moved = true
      end

      after do
        @player2.king_moved = false
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when king's rook has moved" do
      before do
        @player2.king_rook_moved = true
      end
   
      after do
        @player2.king_rook_moved = false
      end

      it "can't encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(false)
      end
    end

    context " when king's rook in check" do
      before do
        @board.squares[7][5] = Rook.new("white", 7, 5)
      end

      after do
        @player2.king_moved = false
        @game.board.make_move([6, 0],[4, 0])
        @game.board.make_move([5, 0],[7, 0])
        @board.squares[7][5] = nil
      end
   
      it "can encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(true)
        expect(@game.board.squares[6][0].class).to eql(King)
        expect(@game.board.squares[5][0].class).to eql(Rook)
      end
    end

    context "when no piece is between king and rook" do
      after do
        @player2.king_moved = false
        @game.board.make_move([6, 0],[4, 0])
        @game.board.make_move([5, 0],[7, 0])
      end

      it "can encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(true)
        expect(@game.board.squares[6][0].class).to eql(King)
        expect(@game.board.squares[5][0].class).to eql(Rook)
      end
    end

    context "when the queen's rook has moved" do
      before do
        @player2.queen_rook_moved = true
      end
      after do
        @player2.queen_rook_moved = false
        @game.board.make_move([6, 0],[4, 0])
        @game.board.make_move([5, 0],[7, 0])
      end

      it "can encastle" do
        expect(@game.board.encastle_right(@player2)).to eql(true)
        expect(@game.board.squares[6][0].class).to eql(King)
        expect(@game.board.squares[5][0].class).to eql(Rook)
      end
    end

  end

  context "black player encastling with queen's rook" do
    before(:all) do
      @board = Board.new
      @board.squares[4][0] = King.new("black", 4, 0)
      @board.squares[7][0] = Rook.new("black", 7, 0)
      @board.squares[0][0] = Rook.new("black", 0, 0)
      @game = Game.new(@board)
    end
    
    context " with pieces between king and rook" do
      before do
        @board.squares[2][0] = Knight.new("white", 2, 0)
      end

      after do
        @board.squares[2][0] = nil
      end
   
      it "can't encastle when piece between king and rook" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when king in check" do
      before do
        @board.squares[4][5] = Rook.new("white", 4, 5)
      end
 
      after do
        @board.squares[4][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when adjacent square to the left of king is in check" do
      before do
        @board.squares[3][5] = Rook.new("white", 3, 5)
      end

      after do
        @board.squares[3][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when second square to the left of king in check" do
      before do
        @board.squares[2][5] = Rook.new("white", 2, 5)
      end

      after do
        @board.squares[2][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when third square to the left of king in check" do
      before do
        @board.squares[1][5] = Rook.new("white", 1, 5)
      end

      after do
        @board.squares[1][5] = nil
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when king has moved" do
      before do
        @player2.king_moved = true
      end

      after do
        @player2.king_moved = false
      end
   
      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when queen's rook has moved" do
      before do
        @player2.queen_rook_moved = true
      end
   
      after do
        @player2.queen_rook_moved = false
      end

      it "can't encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(false)
      end
    end

    context " when queen's rook in check" do
      before do
        @board.squares[0][5] = Rook.new("white", 0, 5)
      end

      after do
        @player2.king_moved = false
        @game.board.make_move([2, 0],[4, 0])
        @game.board.make_move([3, 0],[0, 0])
        @board.squares[0][5] = nil
      end
   
      it "can encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(true)
        expect(@game.board.squares[2][0].class).to eql(King)
        expect(@game.board.squares[3][0].class).to eql(Rook)
      end
    end

    context "when no piece is between king and rook" do
      after do
        @player2.king_moved = false
        @game.board.make_move([2, 0],[4, 0])
        @game.board.make_move([3, 0],[0, 0])
      end

      it "can encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(true)
        expect(@game.board.squares[2][0].class).to eql(King)
        expect(@game.board.squares[3][0].class).to eql(Rook)
      end
    end

    context "when the king's rook has moved" do
      before do
        @player2.king_rook_moved = true
      end
      after do
        @player2.king_rook_moved = false
        @game.board.make_move([2, 0],[4, 0])
        @game.board.make_move([3, 0],[0, 0])
      end

      it "can encastle" do
        expect(@game.board.encastle_left(@player2)).to eql(true)
        expect(@game.board.squares[2][0].class).to eql(King)
        expect(@game.board.squares[3][0].class).to eql(Rook)
      end
    end

  end

  context "ends in a stalemate" do
    before do
      @board = Board.new
      @board.squares[7][0] = King.new("white", 7, 0)
      @board.squares[6][2] = Queen.new("black", 6, 2)
      @board.squares[5][2] = King.new("black", 5, 2)
      @game = Game.new(@board)
    end

    it "white cannot move" do
      #check_mate_by? doesn't verify if the opponents king is in check but only if he can't move to a position not in check
      expect(@game.board.check_mate_by?(@player2)).to eql(true)
      expect(@game.board.check_by?(@player2)).to eql(false)
    end
  end

  context "ends in a check mate" do
    before do
      @board = Board.new
      @board.squares[7][0] = King.new("white", 7, 0)
      @board.squares[6][2] = Queen.new("black", 6, 2)
      @board.squares[5][2] = King.new("black", 5, 2)
      @board.squares[5][1] = Knight.new("black", 5, 1)
      @game = Game.new(@board)
    end

    it "white is checkmated" do
      expect(@game.board.check_mate_by?(@player2)).to eql(true)
      expect(@game.board.check_by?(@player2)).to eql(true)
    end
  end

  context "white king in check" do
    before do
      @board = Board.new
      @board.squares[7][0] = King.new("white", 7, 0)
      @board.squares[6][2] = Queen.new("black", 6, 3)
      @board.squares[5][2] = King.new("black", 5, 2)
      @board.squares[5][1] = Knight.new("black", 5, 1)
      @game = Game.new(@board)
    end

    it "white cannot move" do
      expect(@game.board.check_mate_by?(@player2)).to eql(false)
      expect(@game.board.check_by?(@player2)).to eql(true)
    end
  end
   
end

