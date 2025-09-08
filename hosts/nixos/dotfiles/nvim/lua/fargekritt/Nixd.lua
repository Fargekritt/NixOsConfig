require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
      },
       options = {
         nixos = {
             expr = '(builtins.getFlake "/home/amund/nixos").nixosConfigurations.nixos.options',
         },
         home_manager = {
             expr = '(builtins.getFlake "/home/amund/nixos").homeConfigurations.nixos.options',
         },
       },
    },
  },
})
