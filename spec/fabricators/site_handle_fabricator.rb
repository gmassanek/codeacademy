Fabricator(:site_handle) do
  node_id {Fabricate(:node).id}
  github { "gmassanek" }
end
