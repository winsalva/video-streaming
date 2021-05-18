defmodule MyTubeWeb.GlobalHelpers do


  def admin?(user_email) do
    user_email in ["winsalva396@gmail.com"]
  end


  def count(list) do
    length(list)
  end


  def url(url) do
    yt_link = "https://youtube.com/embed/"
    video_id =
      url
      |> String.split("/")
      |> List.last()

    yt_link <> video_id
  end


  # take the first character from a user's name
  def avatar_name(user_name) do
    String.first(user_name)
  end
end