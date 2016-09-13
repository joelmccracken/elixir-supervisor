defmodule Mix.Tasks.Backup do
  use Mix.Task

  def run(_args) do
    {_, status} = System.cmd("rclone",
      ["sync",
      Path.expand("~/Files"),
      "s3-personal:my-files"]
    )
    IO.puts "Exit status is #{status}"
  end
end
