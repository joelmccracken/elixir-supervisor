defmodule Mix.Tasks.Backup do
  use Mix.Task

  def run(_args) do
    System.cmd("rclone",
      ["sync",
      Path.expand("~/Files"),
      "s3-personal:my-files"]
    )
  end
end
