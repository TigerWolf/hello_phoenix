# defmodule HelloPhoenix.Plugs.Rollbar do
#
#   import Plug.Conn
#   import Logger
#
#   def init(opts) do
#   end
#
#   def call(conn, opts) do
#     try do
#       super(conn, opts)
#     catch
#       kind, error ->
#         Logger.error "WE HAVE AN ERROR --------------------------------------------------"
#     end
#   end
#
#
# end
