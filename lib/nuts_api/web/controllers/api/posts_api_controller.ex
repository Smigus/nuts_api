defmodule NutsApi.Web.PostApiController do
  use NutsApi.Web, :controller

  alias NutsApi.Content

  import Ecto.Query

  def index(conn, _params) do
    posts = 
      Content.list_posts_by_time
      |> Enum.map(&(preload_data(&1)))

    json conn, posts
  end

  def like(conn, %{"id" => id}) do
    Content.like_post(id)
    send_resp conn, 200, ""
  end

  def unlike(conn, %{"id" => id}) do
    Content.unlike_post(id)
    send_resp conn, 200, ""
  end

  def add_comment(conn, %{"id" => post_id}) do
    post = Content.get_post!(post_id)
    with %{"text" => text} <- conn.body_params,
      {:ok, comment} <- Content.create_comment_for_post(post, %{text: text}) do
      send_resp conn, 200, ""
    else
      {:error, reason} ->
        send_resp conn, 400, "Request body error"
    end
  end

  def create(conn, _params) do
    with %{"image_url" => image_url, "author" => %{"name" => name, "emoji_profile_pic" => emoji}} <- conn.body_params,
      {:ok, user} <- Content.create_user(%{name: name, emoji_profile_pic: emoji}),
      {:ok, post} <- Content.create_post_for_user(user, %{image_url: image_url, num_likes: 0}) do
      send_resp conn, 200, ""
    else
      {:error, reason} ->
        send_resp conn, 400, "Request body error"
    end
  end

  defp preload_data(post) do
    post
    |> Content.preload_user
    |> Content.preload_comments
    |> Map.update!(:user, &(Map.drop(&1, [:posts])))
    |> Map.update!(:comments, fn comments ->
      Enum.map(comments, &(Map.drop(&1, [:post]))) end)
  end
end
