defmodule VidStoreTest do
  import Should
  use ExUnit.Case

  # these test context modification
  # should "update count" do
  #   rented_video = VidStore.renting(video())
  #   assert rented_video.times_rented == 1
  #   assert length(rented_video.log) == 1
  # end

  # while this is testing that the machine is wired up correctly
  should "rent video" do
    rented_video = VidStore.rent(video())
    assert rented_video.state == :rented
    assert Enum.count(rented_video.log) == 1
  end

  should "explode" do
    destroyed_video = video() |> VidStore.rent() |> VidStore.destroy()

    assert destroyed_video.state == :destroyed
    assert Enum.count(destroyed_video.log) == 2
    assert String.starts_with?(hd(destroyed_video.log), "Exploding")
  end

  should "find" do
    found_video = video() |> VidStore.rent() |> VidStore.lose() |> VidStore.find()

    assert found_video.state == :available
    assert Enum.count(found_video.log) == 3
    assert String.starts_with?(hd(found_video.log), "Found")
  end

  should "handle multiple transitions" do
    import VidStore

    vid = video() |> rent |> return |> rent |> return |> rent

    assert Enum.count(vid.log) == 5
    assert vid.times_rented == 3
  end

  def video, do: %Video{title: "X-Men"}
end
