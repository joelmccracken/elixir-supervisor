defmodule FunstationElixir do
  def heartbeat do
    IO.puts "Hello, heart!"
  end

  def backup do
    IO.puts "starting backup"
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

    log_file_location = Path.expand("~/.ex_supervisor/run.log")

    IO.puts "Log file at #{log_file_location}"

    File.open(log_file_location, [:append], fn(file)->
      date = DateTime.to_string DateTime.utc_now
      IO.puts(file, "At #{date}")
      IO.puts(file, "Exit status is #{status}")
      IO.puts(file, "output is #{output}")
    end)

    IO.puts "finishing backup"
  end
end
