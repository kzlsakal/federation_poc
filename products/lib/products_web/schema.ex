defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  query do
    extends()

    field :product, :product do
      arg(:upc, non_null(:string))
      resolve(&resolve_product_by_upc/2)
    end
  end

  object :product do
    key_fields("upc")
    field(:upc, non_null(:string))
    field(:name, non_null(:string))

    field(:price, :integer, deprecate: "This field is deprecated") do
      deprecate("This field is truly deprecated")
    end
  end

  defp resolve_product_by_upc(%{upc: upc}, _ctx),
    do: {:ok, %{upc: upc, name: "Test Product", price: 1000}}
end
