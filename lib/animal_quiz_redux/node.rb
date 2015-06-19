module AnimalQuizRedux
	class Node
		include Enumerable

		attr_reader :value, :left, :right
		attr_accessor :parent

		def initialize value
			@value = value
		end

		def left= node
			@left = node
			node.parent = self
		end		

		def right= node
			@right = node
			node.parent = self
		end

		def == other_object
			return other_object.left == left &&
					other_object.right == right &&
					other_object.value == value
		end

		def to_s
			value.to_s
		end

		def each &block
			left.each &block if left
			block.call self
			right.each &block if right
		end

		def last?
			!(right || left)
		end

	end
end