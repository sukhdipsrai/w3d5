require_relative "./00_tree_node.rb"
require "byebug"
class KnightPathFinder

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)

        @considered_positions = [start_pos]
        @board = Array.new(8) {Array.new(8, 0)}

    end

    # upto 8 possible moves, from pos return arr of valid knights moves
    def self.valid_moves(pos)
        x , y = pos
        moves = []
        moves << [x+2,y+1] if valid_index?([x+2,y+1]) 
        moves << [x+2,y-1] if valid_index?([x+2,y-1])
        moves << [x-2,y+1] if valid_index?([x-2,y+1])
        moves << [x-2,y-1] if valid_index?([x-2,y-1])
        moves << [x+1,y+2] if valid_index?([x+1,y+2])
        moves << [x+1,y-2] if valid_index?([x+1,y-2])
        moves << [x-1,y+2] if valid_index?([x-1,y+2])
        moves << [x-1,y-2] if valid_index?([x-1,y-2])
        moves
    end

    def self.valid_index? (pos)
        bool1 = pos[0] <= 7 && pos[0] >= 0 
        bool2 = pos[1] <= 7 && pos[1] >= 0
        bool1 && bool2
    end

    def new_move_positions(pos)
        new_pos = KnightPathFinder.valid_moves(pos) - @considered_moves
        @considered_moves += new_pos
        return new_pos
    end

    # build the whole tree , implementing depth first
    def build_move_tree(parent)
        new_pos = new_move_positions(parent.value)
        # base case 
        return nil if new_pos.empty?
        new_pos.each do |pos|
            parent.children << PolyTreeNode.new(pos)
        end
        parent.children.each do |child_nodes|
            build_move_tree(child_nodes)
        end
        # recursive call here
        
    end

    def find_path(pos)
        build_move_tree(@root_node)

    end

end
# [0,0] -> [1,2]  [2,1] 

# kpf = KnightPathFinder.new([0, 0])
# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]

p KnightPathFinder.valid_moves([0,0])
