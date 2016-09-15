defmodule ElixirSupervisor do
  require Logger

  def heartbeat do
    Logger.info "heartbeat"
  end

  def backup do
    Logger.info "starting backup"
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

    Logger.info "Exit status is #{status}"
    Logger.info "output is #{output}"
    Logger.info "finishing backup"
  end

  def with_log_file(file_handler) do
    log_location = Path.expand("~/.ex_supervisor/run.log")
    log_dirname = Path.dirname(log_location)

    open_and_call_back = fn ->
      File.open(log_location, [:append], file_handler)
    end

    if File.exists?(log_location) do
      open_and_call_back.()
    else
      File.mkdir_p(log_dirname)
      open_and_call_back.()
    end
  end
end
