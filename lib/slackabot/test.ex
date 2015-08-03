defmodule Slackabot.Test do
  def test do
    url = String.to_char_list(Slackabot.Slack.connect_url)
    :gen_tcp.connect(url, 443, [:binary, packet: :line, active: false, reuseaddr: true])
  end
end
