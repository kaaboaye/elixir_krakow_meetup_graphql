defmodule Blog.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        guid: "7488a646-e31f-11e4-aace-600308960662",
        title: "some title"
      })
      |> Blog.Posts.create_post()

    post
  end
end
