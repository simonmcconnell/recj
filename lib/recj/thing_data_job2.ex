defmodule Recj.ThingDataJob2 do
  @moduledoc """
  doesn't work - conflict? == true
  """
  use Oban.Worker,
    queue: :things,
    unique: [
      period: :infinity,
      keys: [:thing, :tags],
      states: [:available, :scheduled, :executing]
    ]

  require Logger

  @impl Oban.Worker
  def perform(%{args: %{"tags" => []}}) do
    Logger.info("all tags done")
    :ok
  end

  def perform(job) do
    %{args: %{"tags" => [tag | tags], "thing" => thing} = args} = job

    Logger.info("tag: #{tag}")

    samples =
      for i <- 1..10 do
        %{
          t: i,
          thing: thing,
          a: i * 1.0,
          b: i * 2.0,
          c: i * 3.0
        }
      end

    Recj.Repo.insert_all(Recj.ThingData, samples,
      on_conflict: {:replace, [String.to_existing_atom(tag)]},
      conflict_target: [:t, :thing],
      returning: false
    )
    |> tap(&Logger.info("insert result: #{inspect(&1)}"))

    args
    |> tap(&Logger.info("this job's args: #{inspect(&1)}"))
    |> Map.put("tags", tags)
    |> Map.update("results", %{thing => :ok}, &Map.put(&1, thing, :ok))
    |> tap(&Logger.info("next job's args: #{inspect(&1)}"))
    |> new(schedule_in: 1)
    |> tap(&Logger.info("new job: #{inspect(&1)}"))
    |> Oban.insert()
    |> tap(&Logger.info("inserting new job result: #{inspect(&1)}"))
  end
end
