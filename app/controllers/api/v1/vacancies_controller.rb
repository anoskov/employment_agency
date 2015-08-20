module Api
  module V1

    class VacanciesController < BaseController

      before_action :set_vacancy, :only => [:update, :destroy]

      def index
        @vacancies = Vacancy.all
      end

      def show
        @vacancy = Vacancy.with_candidates(params[:id])
      end

      def create
        @vacancy = Vacancy.new(vacancy_params)
        @vacancy.salary = params[:salary_begin].to_i..params[:salary_end].to_i if params[:salary_begin] && params[:salary_end]
        render status: @vacancy.save ? 201 : 422
      end

      def destroy
        @vacancy.destroy
      end

      def update
        @vacancy.salary = params[:salary_begin].to_i..params[:salary_end].to_i if params[:salary_begin] && params[:salary_end]
        render status: @vacancy.update_attributes(vacancy_params) ? 201 : 422
      end

      private

      def vacancy_params
        params.permit(:title, :expiration_date, :contact_info, :skills_attributes => [:title])
      end

      def set_vacancy
        @vacancy = Vacancy.find(params[:id])
      end

    end

  end
end