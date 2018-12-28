defmodule Blink2 do
  use Application

  @duration 5000
  @duration_off 2000
  alias Nerves.Leds
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:blink2, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    Enum.each(led_list, &start_blink(&1))
    {:ok, self()}
  end

  defp start_blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    Leds.set [{
    led_key,
      [
        trigger: "timer",
        delay_off: @duration,
        delay_on: @duration_off
      ]
    }]
  end
end