require "./lib/game_elements.rb"
require "./lib/move_rules.rb"

RSpec.describe Pawn do
  describe "#initialize" do
    it "creates a new pawn and attributes" do
      pawn = Pawn.new('a','2', 'white')
      expect(pawn.x_coord).to eql('2')
      expect(pawn.y_coord).to eql('a')
      expect(pawn.team).to eql('white')
      expect(pawn.figure).to eql("\u2659")
    end
  end
end

RSpec.describe Rook do
  describe "#initialize" do
    it "creates a new rook and attributes" do
      rook = Rook.new('a','1', 'white')
      expect(rook.x_coord).to eql('1')
      expect(rook.y_coord).to eql('a')
      expect(rook.team).to eql('white')
      expect(rook.figure).to eql("\u2656")
    end
  end
end

RSpec.describe Knight do
  describe "#initialize" do
    it "creates a new knight and attributes" do
      knight = Knight.new('b','1', 'white')
      expect(knight.x_coord).to eql('1')
      expect(knight.y_coord).to eql('b')
      expect(knight.team).to eql('white')
      expect(knight.figure).to eql("\u2658")
    end
  end
end

RSpec.describe Bishop do
  describe "#initialize" do
    it "creates a new bishop and attributes" do
      bishop = Bishop.new('c','1', 'white')
      expect(bishop.x_coord).to eql('1')
      expect(bishop.y_coord).to eql('c')
      expect(bishop.team).to eql('white')
      expect(bishop.figure).to eql("\u2657")
    end
  end
end

RSpec.describe Queen do
  describe "#initialize" do
    it "creates a new queen and attributes" do
      queen = Queen.new('d','1', 'white')
      expect(queen.x_coord).to eql('1')
      expect(queen.y_coord).to eql('d')
      expect(queen.team).to eql('white')
      expect(queen.figure).to eql("\u2655")
    end
  end
end

RSpec.describe King do
  describe "#initialize" do
    it "creates a new king and attributes" do
      king = King.new('e','1', 'white')
      expect(king.x_coord).to eql('1')
      expect(king.y_coord).to eql('e')
      expect(king.team).to eql('white')
      expect(king.figure).to eql("\u2654")
    end
  end
end

RSpec.describe Player do
  describe "#initialize" do
    it "creates a new player and attributes" do
      player = Player.new('Bob', 'black')
      expect(player.name).to eql('Bob')
      expect(player.team).to eql('black')
    end
  end
end

RSpec.describe Cell do
  describe "#initialize" do
    it "creates a new cell and attributes" do
      cell = Cell.new('3', 'a')
      expect(cell.row).to eql('3')
      expect(cell.col).to eql('a')
      expect(cell.content).to eql("\u2659")
      expect(cell.color).to eql(nil)
    end
  end
end

RSpec.describe Board do
  describe "#initialize" do
    it "creates a new board" do
      board = Board.new()
      expect(board.cells['a2'].content.figure).to eql("\u2659")
      expect(board.cells['a3'].content.instance_of?(String)).to eql(true)
      expect(board.cells['a1'].content.figure).to eql("\u2656")
      expect(board.cells['b1'].content.figure).to eql("\u2658")
      expect(board.cells['c1'].content.figure).to eql("\u2657")
      expect(board.cells['d1'].content.figure).to eql("\u2655")
      expect(board.cells['e1'].content.figure).to eql("\u2654")
    end
  end
end