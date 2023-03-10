defmodule States do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html # for more information on OTP Applications
  def start(_type, videos) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(States.Server, [videos])
      # worker(States.Server, [videos, :backup])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html # for other strategies and supported options
    opts = [strategy: :one_for_one, name: States.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
