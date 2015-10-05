require 'byebug'
class Employee
  attr_accessor :name, :title, :salary, :boss
  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    @bonus = salary * multiplier
  end

end


class Manager < Employee
  attr_accessor :name, :title, :salary, :boss, :subordinates

  def initialize(subordinates, name, title, salary, boss)
    @subordinates = subordinates
    super(name, title, salary, boss)
  end

  def bonus(multiplier)

    subtotal = 0
    subordinates.each do |subo|
      if subo.is_a? Manager
        subo.subordinates.each do |subosubo|
          subtotal+= subosubo.salary
        end
        subtotal += subo.salary
      else
        subtotal += subo.salary
      end
    end
    @bonus = subtotal * multiplier
  end

end

david = Employee.new("David", "TA", 10000, nil)
shawna = Employee.new("Shawna", "TA", 12000, nil)
darren = Manager.new([], "Darren", 'TA Manager', 78000, nil)

ned = Manager.new([], 'Ned', 'Founder', 1000000, nil)

david.boss = darren
shawna.boss = darren
darren.boss = ned
darren.subordinates = [shawna, david]
ned.subordinates = [darren]


puts ned.bonus(5) # => 500_000
# puts darren.bonus(4) # => 88_000
# puts david.bonus(3) # => 30_000
