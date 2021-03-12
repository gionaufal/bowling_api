defmodule BowlingApi.Game.FrameTest do
  use BowlingApi.DataCase

  alias BowlingApi.{Game, Game.Frame, Repo}

  describe "strike?/1" do
    test "when first throw hits 10 pins, returns true" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 10})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.strike?(frame) == true
    end

    test "when first throw hits less than 10 pins, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.strike?(frame) == false
    end

    test "when both throws hit less than 10 pins, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 1})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.strike?(frame) == false
    end

    test "when both throws hit 10 pins, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 6})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.strike?(frame) == false
    end
  end

  describe "spare?/1" do
    test "when first throw hits 10 pins, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 10})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.spare?(frame) == false
    end

    test "when both throws hit less than 10 pins, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 1})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.spare?(frame) == false
    end

    test "when both throws hit 10 pins, returns true" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      BowlingApi.new_throw(%{frame_id: frame.id, pins: 6})
      {:ok, frame} = Frame.Get.call(frame.id)

      assert Frame.spare?(frame) == true
    end
  end

  describe "last?/1" do
    test "when it's not the 10th frame, returns false" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))

      assert Frame.last?(frame) == false
    end

    test "when it's the 10th frame, returns true" do
      {:ok, game} = Game.Create.call()

      Enum.each(0..19, fn _ ->
        {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
        BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      end)

      {:ok, game} = Game.Get.call(game.id)

      frame = List.last(game.frames)

      assert Frame.last?(frame) == true
    end
  end

  describe "score/1" do
    test "when it's a normal frame, returns the the sum of the throws in that frame" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame1} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame1.id, pins: 4})
      BowlingApi.new_throw(%{frame_id: frame1.id, pins: 3})
      {:ok, frame2} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 5})
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 4})
      {:ok, frame} = Frame.Get.call(frame1.id)

      assert Frame.score(frame) == 7
    end

    test "when it's a strike in a normal frame, returns the 10 + the next 2 throws" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame1} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame1.id, pins: 10})
      {:ok, frame2} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 5})
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 4})
      {:ok, frame3} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame3.id, pins: 4})
      {:ok, frame} = Frame.Get.call(frame1.id)

      assert Frame.score(frame) == 19
    end

    test "when it's a spare in a normal frame, returns the 10 + the next throw" do
      {:ok, game} = Game.Create.call()

      game = game |> Repo.preload(:throws)
      {:ok, frame1} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame1.id, pins: 5})
      BowlingApi.new_throw(%{frame_id: frame1.id, pins: 5})
      {:ok, frame2} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 5})
      BowlingApi.new_throw(%{frame_id: frame2.id, pins: 4})
      {:ok, frame} = Frame.Get.call(frame1.id)

      assert Frame.score(frame) == 15
    end
  end
end
