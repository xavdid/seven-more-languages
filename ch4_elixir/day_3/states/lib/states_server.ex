defmodule States.Server do
  use GenServer
  require VidStore

  def start_link(videos, name \\ :video_store) do
    IO.puts("Starting server!")
    GenServer.start_link(__MODULE__, videos, name: name)
  end

  def init(videos) do
    {:ok, videos}
  end

  # syncronous
  def handle_call({action, item}, _from, videos) do
    case action do
      # also, :sys.get_state(:video_store)
      :state ->
        {:reply, videos, videos}

      _ ->
        video = videos[item]
        new_video = apply(VidStore, action, [video])
        {:reply, new_video, Keyword.put(videos, item, new_video)}
    end
  end

  # async
  def handle_cast({:add, video}, videos) do
    {:noreply, [video | videos]}
  end
end
