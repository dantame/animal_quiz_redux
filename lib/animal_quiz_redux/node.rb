module AnimalQuizRedux
	class Node
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
			other_object.left.to_s == self.left.to_s &&
			other_object.right.to_s == self.right.to_s &&
			other_object.value.to_s == self.value.to_s
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

		def last?
			!(right || left)
		end

	end
end