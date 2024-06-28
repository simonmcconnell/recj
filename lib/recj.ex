defmodule Recj do
  def create_job(thing \\ "one") when thing in ~w[one two] do
    %{
      "thing" => thing,
      "tags" => [
        ["a", "1", "2"],
        ["b", "1", "3"],
        ["c", "1", "4"]
      ]
    }
    |> Recj.ThingDataJob.new(schedule_in: 1)
    |> Oban.insert()
  end

  def create_job2(thing \\ "one") when thing in ~w[one two] do
    %{
      "thing" => thing,
      "tags" => ["a", "b", "c"]
    }
    |> Recj.ThingDataJob2.new(schedule_in: 1)
    |> Oban.insert()
  end

  def create_job3(thing \\ "one") when thing in ~w[one two] do
    %{
      "thing" => thing,
      "tag" => "a"
    }
    |> Recj.ThingDataJob3.new(schedule_in: 1)
    |> Oban.insert()
  end

  def create_job4(thing \\ "one") when thing in ~w[one two] do
    tags = [
      ["a", "1", "2"],
      ["b", "1", "3"],
      ["c", "1", "4"]
    ]

    %{
      "thing" => thing,
      "tags" => tags,
      "hash" => :erlang.phash2(tags)
    }
    |> Recj.ThingDataJob4.new(schedule_in: 1)
    |> Oban.insert()
  end

  def reset do
    Recj.Repo.delete_all(Recj.ThingData)
    Recj.Repo.delete_all("oban_jobs")
  end
end
