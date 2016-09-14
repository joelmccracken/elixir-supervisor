defmodule Mix.Tasks.Backup do
  use Mix.Task

  def run(_args) do
    {output, status} = System.cmd("rclone",
      [
        "sync",
        Path.expand("~/Files"),
        "s3-personal:my-files",
        "--retries",
        "1"
      ],
      stderr_to_stdout: true
    )
    IO.puts "Exit status is #{status}"
    IO.puts "Output is #{output}"
  end
end
