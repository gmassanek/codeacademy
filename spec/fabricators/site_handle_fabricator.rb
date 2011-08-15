Fabricator(:site_handle) do
  item! {Fabricate(:node)}
  github { "gmassanek" }
end
