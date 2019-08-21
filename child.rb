require_relative "parent"
require_relative "child_module"

class Child < Parent
  include ChildModule

  def initialize
    super

    disable_call_trace
    disable_raise_trace
  end

  def hello
    p "hello"
  end

  def bye
    raise "エラーが発生しました"
  end

  def greeting
    child_in_class = ChildModule::ChildInClass.new
    child_in_class.good_evening
  end
end

child = Child.new
child.bye
child.hello
child.greeting