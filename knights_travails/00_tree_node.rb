class PolyTreeNode

    def initialize(value)
        @parent = nil
        @children = []
        @value = value 
    end

    attr_reader :value, :parent , :children

    def children=(arr)
        @children = arr
    end

    def parent=(passed_node)
        if self.parent != nil
            self.parent.children.each_with_index do |child, i|
                if child == self 
                    self.parent.children.delete_at(i)
                end
            end
        end

        @parent = passed_node
        if self.parent != nil
            passed_node.children << self 
        end
    end

    #    B-> CHILD , WE WANT TO Add b to C
    def add_child(child_node)
        child_node.parent = self 
    end

    def remove_child(child_node)
        if @children.include?(child_node)
            child_node.parent = nil 
        else 
            raise "node is not a child" 
        end
    end

    def dfs(target_value)
        # p target_value + " target value"
        # p value
        # p @children.map{|ele| ele.value} if self.children.length != 0
        if self.value == target_value
            return self
        end
        return nil if self.children.length == 0
        answer = self
        @children.each do |child|
             answer =  child.dfs(target_value)
             return answer if answer != nil
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        # p target_value
        while !queue.empty?
           #p queue.map{|ele| ele.value} 
            first_node = queue.shift()
            # p first_node.class
           
            if first_node.value == target_value
                return first_node
            end
            (queue.push(first_node.children)).flatten!
        end
        nil
    end


end