skills = Skill.create([
                          {:title => 'Ruby'},
                          {:title => 'Rails'},
                          {:title => 'PostgreSQL'},
                          {:title => 'RSpec'},
                          {:title => 'AngularJS'}
                      ])
employee = Employee.create({
                    :fname => 'Андрей',
                    :lname => 'Носков',
                    :sname => 'Геннадьевич',
                    :contact_info => 'flashbulb54@gmail.com',
                    :job_status => 'Ищу работу',
                    :desired_salary => 80000,
                    :skills => skills
                })
vacancy = Vacancy.create({
                   :title => 'Senior/Ruby on Rails developer',
                   :expiration_date => Date.new(2015, 8, 30),
                   :contact_info => 'e-mail: hr@example.com',
                   :salary => 70000..100000,
                   :skills => skills
               })