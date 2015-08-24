module Api
  module V1
    class SkillsController < BaseController

      def index
        @skills = Skill.where("title LIKE '%#{params[:query]}%'")
      end

    end
  end
end