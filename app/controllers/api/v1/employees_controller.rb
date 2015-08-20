module Api
  module V1

    class EmployeesController < BaseController

      before_action :set_employee, :only => [:update, :destroy]

      def index
        @employees = Employee.all
      end

      def show
        @employee = Employee.with_vacancies(params[:id])
      end

      def create
        @employee = Employee.new(employee_params)
        render status: @employee.save ? 201 : 422
      end

      def destroy
        @employee.destroy
      end

      def update
        render status: @employee.update_attributes(employee_params) ? 201 : 422
      end

      private

      def employee_params
        params.permit(:fname, :lname, :sname, :job_status, :desired_salary, :contact_info,
                      :skills_attributes => [:title])
      end

      def set_employee
        @employee = Employee.find(params[:id])
      end

    end

  end
end