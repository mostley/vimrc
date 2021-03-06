local M = {}

function M.setup(installed_server)
  return {
    schemas = {
      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      ["../path/relative/to/file.yml"] = "/.github/workflows/*",
      ["/path/from/root/of/project"] = "/.github/workflows/*",
      -- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
    },
  }
end

return M
