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
        new_pos = KnightPathFinder.valid_moves(pos) - @considered_positions
        # @considered_positions += new_pos
        return new_pos
    end

    def print
        p @root_node.children.map {|child| p child.value}
    end

    # # build the whole tree , implementing depth first
    # def build_move_tree(parent)
    #     @considered_positions = trace_path_back(parent)
    #     new_pos = new_move_positions(parent.value)

    #     # base case 
    #     if new_pos.empty? 
    #         return nil
    #     end

    #     new_pos.each do |pos|
    #         parent.add_child(PolyTreeNode.new(pos))
    #     end
 
    #     parent.children.each do |child_nodes|
    #         build_move_tree(child_nodes)
    #     end
    #     # recursive call here
    # end

    # using breadth-first
    def build_move_tree (target_value)
        queue = [@root_node]

        while !queue.empty?
            first = queue.shift
            @considered_positions = trace_path_back(first)
            new_pos = new_move_positions(first.value)
            new_pos.each { |pos| first.add_child(PolyTreeNode.new(pos)) }
            # p "parent is #{first.value}"
            # p first.children.map {|ele| ele.value}
            return first if (first.value == target_value) 
            first.children.each { |child| queue << child}
        end

    end



    def find_path(end_pos)
        ans = build_move_tree(end_pos)
        # target_node = @root_node.bfs(end_pos)
        return trace_path_back(ans)
    end



    # def self.trace_path_back(node)
    #     output = [node.value]
    #     par = node.parent
    #     while par != nil 
    #         output.unshift(par.value)
    #         par = par.parent 

    #     end
    #     return output 
    # end



    def trace_path_back(node)
        output = []
        par = node
        while par != nil
            output = [par.value] + output 
            par = par.parent 
        end
        # p output
        return output 
    end
end

kpf = KnightPathFinder.new([0, 0])

# kpf.print
 p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# p KnightPathFinder.valid_moves([5,5])
# kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

# [0,0] -> [1,2]  [2,1] 

# kpf = KnightPathFinder.new([0, 0])
# kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# # kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]

# tree = KnightPathFinder.valid_moves([0,0])

# kpf.find_path([2,1])
# kpf.print




