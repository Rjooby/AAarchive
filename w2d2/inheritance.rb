class Employee
  attr_accessor :title, :salary, :boss, :name
  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @boss = nil
    @employees = []
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

  def reassign_boss(new_boss)

    @boss.employees.delete(self) unless @boss.nil?
    @boss = new_boss
  end

  def inspect
    self.name
  end

  def all_underlings
    if @employees.empty?
      return []
    end

    arr = []
    @employees.each do |employee|
      arr <<  employee
      arr.concat(employee.all_underlings)
    end

    return arr

  end

  def underling_count
    self.all_underlings.count
  end
end

class Manager<Employee

  attr_accessor :employees

  def initialize(name, title, salary)
    super(name,title,salary)
    @employees = []
  end

  def bonus(multiplier)
    accum = 0
    self.all_underlings.each do |employee|
      accum += employee.salary
    end
    return accum * multiplier

  end

  def assign_employee(employee)
    employee.reassign_boss(self)
    @employees.push(employee)

  end

  # def all_underlings
  #   underlings = []
  #   if self.class == Employee
  #     return self
  #   else
  #     @employees.each do |employee|
  #       underlings << employee.all_underlings
  #     end
  #   end
  #   return underlings
  #
  # end

end
phil = Employee.new('phil','bottom', 0)
ryan = Employee.new('ryan','bottom', 0)
mike = Manager.new('mike','middle', 5)
craig = Manager.new('craig','top', 10)
mike.assign_employee(phil)
mike.assign_employee(ryan)
craig.assign_employee(mike)
