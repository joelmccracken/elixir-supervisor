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
    :ok = File.write(Path.expand("~/.ex_supervisor/last-backup-date"), DateTime.to_string DateTime.utc_now)
    Logger.info "Exit status is #{status}"
    Logger.info "output is #{output}"
    Logger.info "finishing backup"
  end
end
