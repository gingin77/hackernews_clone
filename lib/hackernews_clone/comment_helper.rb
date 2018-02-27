module HackernewsClone
  module CommentHelper
    def self.included(base)
      base.helper_method :commentable
    end

    def controller
      params[:controller]
    end

    def id_finder
      /[a-zA-Z]+_id/.match(params.to_s).to_s
    end

    def commentable_type
      controller.classify.constantize
    end

    def id
      if commentable_type == Post
        params[:id]
      elsif params[id_finder].present?
        params[id_finder]
      else
        params[controller.singularize][id_finder]
      end
    end

    def commentable
      commentable_type.find(id)
    end
  end
end
