module Jekyll
  class Tag
    attr_accessor :name, :posts

    def initialize(name)
      self.name = name
      self.posts = []
    end

    def count
      self.posts ? self.posts.size : 0
    end

    def <=>(other)
      self.name <=> other.name
    end

    def to_s()
      self.name
    end
  end
end
