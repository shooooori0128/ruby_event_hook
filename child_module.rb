module ChildModule
  class ChildInClass
    def good_morning
      p "good morning!"
    end

    def good_evening
      raise "モジュールで例外が発生しました！"
    end
  end
end