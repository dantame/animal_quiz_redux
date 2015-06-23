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
			return other_object.is_a?(self.class) &&
				other_object.left == self.left &&
				other_object.right == self.right &&
				other_object.value == self.value
		end

		def to_s
			value.to_s
		end

		def replace target, replacement
			if target == self.left
				self.left = replacement
			elsif target == self.right
				self.right = replacement
			else
				return
			end

			replacement.parent = self
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