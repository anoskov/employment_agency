class CreateMatchesOfSkills < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW public.matches_of_skills AS
        WITH employees_skills as (
          SELECT employee.id as employee_id, skill.id as skill_id
          FROM employees employee
          JOIN specified_skills employee_skill ON employee_skill.owner_id = employee.id and employee_skill.owner_type = 'Employee'
          JOIN skills skill on employee_skill.skill_id = skill.id
          WHERE employee.job_status = 'Ищу работу'
          GROUP BY employee.id, skill.id
        ),
        vacancies_req_skills as (
          SELECT vacancy.id as vacancy_id, array_agg(skill.id) as skills, count(vacancy_req_skill.skill_id) as skills_cnt
          FROM vacancies vacancy
          JOIN specified_skills vacancy_req_skill ON  vacancy_req_skill.owner_id = vacancy.id and vacancy_req_skill.owner_type = 'Vacancy'
          JOIN skills skill ON vacancy_req_skill.skill_id = skill.id
          WHERE vacancy.expiration_date > vacancy_1.created_at::date
          GROUP BY vacancy.id
        )

        SELECT employee_id, vacancy_id, round(count(vacancy.skill_id)::numeric / skills_cnt::numeric * 100, 1)  as pct_of_match
        FROM employees_skills
        JOIN (SELECT vacancy_id, skills_cnt, unnest(skills) as skill_id FROM vacancies_req_skills) vacancy on vacancy.skill_id = employees_skills.skill_id
        GROUP BY employee_id, vacancy_id, skills_cnt
    SQL
  end

  def down
    execute 'DROP VIEW public.matches_of_skills'
  end
end
