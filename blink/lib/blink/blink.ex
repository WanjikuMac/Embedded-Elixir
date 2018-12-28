defmodule Blink do
  @moduledoc """
  Blink LED Project with Nerves
  """
  require Logger

  @led_pin Application.get_env(:blink, :led_pin)

  @doc """
  Start up the led pin
  """
  def start_link do
    Logger.debug "Starting pin #{@led_pin} as output"
    {:ok, pin} = Gpio.start_link(@led_pin, :output)

    spawn_link fn -> blink_led_forever(pin) end

    {:ok, self()}
  end
  defp blink_led_forever(pin) do
    Logger.debug "Blinking pin #{@led_pin}"
    blink_ms = Blink.Store.get(:blink_ms)
    Gpio.write(pin, 1)
    :timer.sleep(blink_ms)
    Gpio.write(pin, 0)
    :timer.sleep(blink_ms)

    blink_led_forever(pin)
  end
end
