# CLN-plugins

[![NixOS](https://img.shields.io/badge/NixOS-24.11-blue.svg?style=flat-square&logo=nixos)](https://nixos.org)
[![Core Lightning](https://img.shields.io/badge/Core%20Lightning-24.08-yellow.svg?style=flat-square&logo=lightning)](https://github.com/ElementsProject/lightning)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-informational?style=flat-square&logo=nixos)](https://nixos.wiki/wiki/Flakes)

A comprehensive collection of Nix packages for Core Lightning plugins, enabling easy deployment of essential and community-built plugins for your Lightning node.

## 🎯 Why CLN-plugins?

Running a Core Lightning node on NixOS? You've probably noticed:

- ❌ The official Core Lightning package doesn't include Rust plugins (clnrest, cln-grpc)
- ❌ No easy way to install individual plugins without building everything
- ❌ Community plugins require manual compilation and management
- ❌ Configuration is scattered and non-declarative

**CLN-plugins solves these problems by providing:**
- ✅ Pre-built packages for essential Core Lightning plugins
- ✅ Declarative NixOS integration
- ✅ Individual plugin selection
- ✅ Community plugin support
- ✅ Easy remote node access via Zeus, BitBanana, and other apps

## 📦 Available Plugins

### Core Plugins
| Plugin | Description | Use Case |
|--------|-------------|----------|
| **cln-grpc** | gRPC interface for Core Lightning | Remote node control, app integration |
| **clnrest** | RESTful API interface | Web services, HTTP-based tools |

### Community Plugins
| Plugin | Description | Use Case |
|--------|-------------|----------|
| **summars** | Enhanced node statistics | Detailed performance metrics | 
| **summary** | Summarize node activity | Node monitoring and reporting |
| **rebalance** | Channel rebalancing tool | Liquidity management |
| **trustedcoin** | Block explorer integration | Enhanced chain validation |
| **sauron** | Simple plugin to ditch running bitcoind |
| **backup** | Automated backup solution | Node data protection |
| **payany** | Payment automation | Advanced payment features |

### Dependencies
| Package | Description |
|---------|-------------|
| **pyln-client** | Python library for plugin development |

## 🚀 Quick Start

### Build a Single Plugin

```bash
# Build cln-grpc for remote access
nix build github:jjacke13/CLN-plugins#cln-grpc

# Build clnrest for REST API
nix build github:jjacke13/CLN-plugins#clnrest

# Build any community plugin
nix build github:jjacke13/CLN-plugins#rebalance
```

## 🔧 NixOS Integration

### Add to Your Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    cln-plugins.url = "github:jjacke13/CLN-plugins";
  };

  outputs = { self, nixpkgs, cln-plugins, ... }: {
    nixosConfigurations.lightning-node = nixpkgs.lib.nixosSystem {
      modules = [{
        environment.systemPackages = with pkgs; [
          # Add Core Lightning plugins
          cln-plugins.packages.${system}.cln-grpc
          cln-plugins.packages.${system}.clnrest
          cln-plugins.packages.${system}.rebalance
        ];
      }];
    };
  };
}
```

### Configure Core Lightning

Add plugins to your Core Lightning configuration:

```bash
# /etc/clightning/config or ~/.lightning/config
plugin=/run/current-system/sw/bin/cln-grpc
plugin=/run/current-system/sw/bin/clnrest
plugin=/run/current-system/sw/bin/rebalance
```

Or declaratively in NixOS (given that you run clightning with systemd):

```nix
services.clightning = {
  enable = true;
  extraConfig = ''
    plugin=/run/current-system/sw/bin/cln-grpc
    plugin=/run/current-system/sw/bin/clnrest
    plugin=/run/current-system/sw/bin/rebalance
  '';
};
```

## 📱 Remote Access Setup

### For Zeus/BitBanana via cln-grpc

1. Add to Core Lightning config:
   ```
   plugin=/run/current-system/sw/bin/cln-grpc
   grpc-port=<your-choise>
   grpc-host=<your-choise>
   ```
2. Configure your Bit-banana mobile app with:
   - Host: the host you chose above
   - Port: the port you chose above
   - Certificates: Host certificate -> the file: `~/.lightning/bitcoin/server.pem`
                   Client certificate -> the file: `~/.lightning/bitcoin/client.pem`
                   Client key -> the file: `~/.lightning/bitcoin/client-key.pem`

### For REST API Access via clnrest

1. You have to create a rune first with:
   ```bash
   lightning-cli createrune
   ```

2. Edit lightning configuration:
   ```
   plugin=/run/current-system/sw/bin/clnrest
   clnrest-port=<your-choise>
   clnrest-protocol=https
   clnrest-host=<your-choise>
   ```
3. Access your node with ZeusLN app
   - Server address: `https://clnrest-host
   - REST Port: clnrest-port
   - Rune: `the rune you created`


## 🛠️ Advanced Usage

### Building Multiple Plugins

Create a custom package set:

```nix
# my-cln-plugins.nix
{ pkgs, cln-plugins }:
pkgs.symlinkJoin {
  name = "my-cln-plugins";
  paths = with cln-plugins.packages.${pkgs.system}; [
    cln-grpc
    clnrest
    rebalance.py
    summary.py
  ];
}
```

### Plugin Development

Use pyln-client for Python plugin development:

```nix
{ pkgs, cln-plugins }:
pkgs.python3.withPackages (ps: [
  cln-plugins.packages.${pkgs.system}.pyln-client
  # Other Python dependencies
])
```

## 📊 Plugin Configuration Examples

### Rebalance Plugin

```bash
# Rebalance a channel
lightning-cli rebalance outgoing_scid incoming_scid amount_msat

# Set up automatic rebalancing
lightning-cli rebalance-auto enable=true threshold=0.8
```

### Summary Plugin

```bash
# Get enhanced node statistics
lightning-cli summary
```

### Sauron Plugin

```bash
# /etc/clightning/config or ~/.lightning/config
plugin=/run/current-system/sw/bin/sauron.py
sauron-api-endpoint=https://mempool.space/api/
```
## 🔍 Troubleshooting

### Plugin Not Loading

1. Verify Core Lightning can find the plugin:
   ```bash
   lightning-cli plugin list
   ```

2. Check logs for errors:
   ```bash
   tail -f ~/.lightning/lightning.log
   ```

### Common Issues

**"Plugin not found"**
- Ensure the plugin is in your `environment.systemPackages`
- Run `nixos-rebuild switch` after adding plugins

**"Permission denied"**
- Check that the clightning user can execute the plugin

**"Plugin crashed"**
- Check plugin-specific logs in `~/.lightning/`

## 🤝 Contributing

Contributions are welcome! To add a new plugin:

1. Fork the repository
2. Create a new Nix expression for your plugin:
   ```nix
   # my-plugin.nix
   { pkgs }:
   pkgs.stdenv.mkDerivation {
     pname = "cln-my-plugin";
     version = "0.1.0";
     # ... build instructions
   }
   ```
3. Add to `flake.nix`:
   ```nix
   packages = {
     # ... existing plugins
     my-plugin = import ./my-plugin.nix { inherit pkgs; };
   };
   ```
4. Test thoroughly and submit a PR

### Plugin Requirements

- Must be compatible with recent Core Lightning versions
- Should follow Core Lightning plugin standards
- Include documentation and examples
- Pass basic functionality tests

## 📚 Resources

### Official Documentation
- [Core Lightning Config Reference](https://docs.corelightning.org/reference/lightningd-config)
- [Core Lightning Plugin Development](https://docs.corelightning.org/docs/plugin-development)

### Community Plugins
- [Lightning Plugins Repository](https://github.com/lightningd/plugins)
- [Plugin Compatibility Matrix](https://github.com/lightningd/plugins/tree/master#compatibility)

### Mobile Apps
- [Zeus LN](https://zeusln.app/) - iOS/Android Lightning wallet
- [BitBanana](https://bitbanana.app/) - Android node manager

## 📄 License

This project is licensed under the MIT License. Individual plugins may have their own licenses - please check each plugin's source repository.

---

**Built for the Lightning Network community** ⚡

Missing a plugin? [Open an issue](https://github.com/jjacke13/CLN-plugins/issues) or submit a PR!