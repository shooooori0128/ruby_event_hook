require "active_support/all"

# ################################################
# 親クラス
# ################################################
class Parent
  def initialize
    # ログ設定
    FileUtils.mkdir_p("log")
    $logger           = ActiveSupport::Logger.new("log/production.log", "daily")
    $logger.formatter = ::Logger::Formatter.new
    console           = ActiveSupport::Logger.new(STDOUT)
    $logger.extend ActiveSupport::Logger.broadcast(console)
    # callイベントトレース
    start_call_trace
    # raiseイベント
    start_raise_trace
  end

  protected

  # callトレースの有効化
  def enable_call_trace
    @@tp_call.enable
  end

  # callトレースの無効化
  def disable_call_trace
    @@tp_call.disable
  end

  # raiseトレースの有効化
  def enable_raise_trace
    @@tp_raise.enable
  end

  # raiseトレースの無効化
  def disable_raise_trace
    @@tp_raise.disable
  end

  private

  # callイベントトレース
  def start_call_trace
    @@tp_call = TracePoint.trace(:call) do |tp|
      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "start_call_trace"

      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "enable_call_trace"

      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "disable_call_trace"

      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "start_raise_trace"

      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "enable_raise_trace"

      next if tp.defined_class.to_s == "Parent" && tp.method_id.to_s == "disable_raise_trace"

      $logger.debug("call => class: #{tp&.defined_class}, method: #{tp&.method_id}")
    end
  end

  # raiseイベントトレース
  def start_raise_trace
    @@tp_raise = TracePoint.trace(:raise) do |tp|
      $logger.error("★例外が発生しました！")
      $logger.error("エラー発生箇所 => #{tp.inspect}")
      $logger.error("クラス名 => #{tp.defined_class}")
      $logger.error("メソッド名 => #{tp.method_id}")
      $logger.error("エラーメッセージ => #{tp.raised_exception}")
    end
  end
end
