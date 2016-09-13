defmodule FunstationElixir do
  def heartbeat do
    IO.puts "Hello, heart!"
  end

  def heartbeat2 do
    System.cmd("rclone",
      ["sync",
       Path.expand("~/Files"),
       "s3-personal:my-files"]
    )
  end
end
