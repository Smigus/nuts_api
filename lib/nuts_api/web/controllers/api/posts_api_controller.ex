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
    conn
    |> put_status(200)
  end

  def unlike(conn, %{"id" => id}) do
    Content.unlike_post(id)
    conn
    |> put_status(200)
  end

  def add_comment(conn, %{"id" => post_id, "text" => text}) do
    post = Content.get_post!(post_id)
    text = String.replace(text, "_", " ")
    with {:ok, comment} <- Content.create_comment_for_post(post, %{text: text}) do
      json conn, %{status_code: 200}
    else
      {:error, reason} ->
        json conn, %{status_code: 400, message: "Request body error"}
    end
  end

  def create(conn, _params) do
    with {:ok, encoded_body, _} <- Plug.Conn.read_body(conn),
      {:ok, body} <- Poison.decode(encoded_body),
      {:ok, post} <- create_post_from_request_body(body) do
      json conn, %{status_code: 200}
    else
      {:error, reason} ->
        json conn, %{status_code: 400, message: "Request body error"}
    end
  end

  def create_post_from_request_body(body = %{"image_url" => image_url, "author" => %{"name" => name, "emoji_profile_pic" => emoji}}) do
    with {:ok, user} <- Content.create_user(%{name: name, emoji_profile_pic: emoji}),
      {:ok, post} <- Content.create_post_for_user(user, %{image_url: image_url, num_likes: 0}) do
      {:ok, post}
    else
      {:error, reason} -> {:error, reason}
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
