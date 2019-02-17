defmodule LedBlink do
  @moduledoc """
   The hello world of Raspberry pi 3 with nerves
  """
  use Application
    @off_duration 500 #miliseconds
    @on_duration 500 #miliseconds
  alias Nerves.Leds
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:led_blink, :led_list)
    Logger.debug "list of leds to blink is" #{inspect led_list}
    Enum.each(led_list, &start_blink(&1))
    {:ok, self}
  end

  defp start_blink(led_key) do
    Logger.debug "blinking led #{inspect led_key}"
    Leds.set [{
    led_key,
        [
          trigger: "timer",
          delay_off: @off_duration,
          delay_on: @on_duration
        ]
      }
    ]
  end
end
