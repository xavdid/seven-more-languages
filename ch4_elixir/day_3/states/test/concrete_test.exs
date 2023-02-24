defmodule ConcreteTest do
  import Should
  use ExUnit.Case

  should "update count" do
    rented_video = VideoStore.renting(video())
    assert rented_video.times_rented == 1
    assert length(rented_video.log) == 1
  end

  should "rent video" do
    rented_video = VideoStore.Concrete.rent(video())
    assert rented_video.state == :rented
    assert Enum.count(rented_video.log) == 1
  end

  should "handle multiple transitions" do
    import VideoStore.Concrete

    vid = video() |> rent |> return |> rent |> return |> rent

    assert Enum.count(vid.log) == 5
    assert vid.times_rented == 3
  end

  def video, do: %Video{title: "X-Men"}
end
