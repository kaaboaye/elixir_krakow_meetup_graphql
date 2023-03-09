defmodule Blog.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        guid: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Blog.Comments.create_comment()

    comment
  end
end
