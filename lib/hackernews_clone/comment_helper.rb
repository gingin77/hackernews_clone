module HackernewsClone
  module CommentHelper
    def self.included(base)
      base.helper_method :new_comment
    end

    def new_comment
      @comment = Comment.new
    end
  end
end
