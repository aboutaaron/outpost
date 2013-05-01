module Outpost
  module Controller
    module ArticleBackup
      def backup
        @article = Outpost.obj_by_key!(params[:obj_key])

        backup = ArticleBackup.create!({
          article: @article,
          frozen_article: params[resource.singular_route_key]
        })

        respond_with backup
      end
    end
  end
end
