defmodule Mix.Tasks.InstallPlist do
  use Mix.Task

  def run(_args) do
    plist_file_location = Path.expand("~/Library/LaunchAgents/elixir_supervisor.plist")
    out_location = Path.expand("~/.ex_supervisor/out.log")
    err_location = Path.expand("~/.ex_supervisor/err.log")
    current_directory = System.cwd!()
    elixir_location = "/usr/local/bin"
    # {whoami, 0} = System.cmd("/usr/bin/whoami", [])
    # user = String.trim(whoami)

    unless File.exists?(Path.join(current_directory, "mix.exs")) do
      IO.puts("Please run from within the root directory of the project.")
      exit(10)
    end

    file_content = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    <key>KeepAlive</key>
    <true/>
    <key>EnvironmentVariables</key>
    <dict>
    <key>PATH</key>
    <string>#{elixir_location}:/usr/bin</string>
    </dict>
    <key>Label</key>
    <string>elixir.supervisor</string>
    <key>ProgramArguments</key>
    <array>
    <string>/usr/local/bin/mix</string>
    <string>run</string>
    <string>--no-halt</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>#{current_directory}</string>
    <key>StandardErrorPath</key>
    <string>#{err_location}</string>
    <key>StandardOutPath</key>
    <string>#{out_location}</string>
    </dict>
    </plist>
    """

    if File.exists?(plist_file_location) do
      System.cmd("launchctl", ["unload", plist_file_location])
    end

    :ok = File.write(plist_file_location, file_content)

    {output, 0} = System.cmd("launchctl", ["load", plist_file_location])
    IO.puts output
  end
end
