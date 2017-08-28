defmodule NutsApi.ContentTest do
  use NutsApi.DataCase

  alias NutsApi.Content

  describe "posts" do
    alias NutsApi.Content.Post

    @valid_attrs %{image_url: "some image_url", num_likes: 42}
    @update_attrs %{image_url: "some updated image_url", num_likes: 43}
    @invalid_attrs %{image_url: nil, num_likes: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Content.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Content.create_post(@valid_attrs)
      assert post.image_url == "some image_url"
      assert post.num_likes == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Content.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.image_url == "some updated image_url"
      assert post.num_likes == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_attrs)
      assert post == Content.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Content.change_post(post)
    end
  end

  describe "users" do
    alias NutsApi.Content.User

    @valid_attrs %{emoji_profile_pic: "some emoji_profile_pic", name: "some name"}
    @update_attrs %{emoji_profile_pic: "some updated emoji_profile_pic", name: "some updated name"}
    @invalid_attrs %{emoji_profile_pic: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Content.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Content.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Content.create_user(@valid_attrs)
      assert user.emoji_profile_pic == "some emoji_profile_pic"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Content.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.emoji_profile_pic == "some updated emoji_profile_pic"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_user(user, @invalid_attrs)
      assert user == Content.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Content.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Content.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Content.change_user(user)
    end
  end

  describe "comments" do
    alias NutsApi.Content.Comment

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Content.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Content.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Content.create_comment(@valid_attrs)
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Content.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_comment(comment, @invalid_attrs)
      assert comment == Content.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Content.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Content.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Content.change_comment(comment)
    end
  end
end
