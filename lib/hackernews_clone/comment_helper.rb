module HackernewsClone
  module CommentHelper
    def self.included(base)
      base.helper_method :new_comment
      base.helper_method :comments_parent
    end

    def new_comment
      @comment = Comment.new
    end

    def comments_parent
      @parent ||=
      if params[:comment_id].blank? && params[:post_id].present?
        Post.find(params[:post_id])
      elsif params[:comment_id].blank? && params[:id].present?
        Post.find(params[:id])
      else
        Comment.find(params[:comment_id])
      end
    end
  end
end
