# CLN-plugins
## Nix packages for some plugins of Core lightning

Always start with WHY:

1. I am a Core Lightning node runner
2. I use nix and nixos
3. The provided package for Core Lightning in Nix packages does not build the rust plugins (clnrest / cln-grpc)
4. The above plugins are usefull for connecting remotely to your node through other apps (eg. Bitbanana, Zeus LN wallet)
5. Someone may want to install only one of those for their node (the default build procedure in Core lightning repo builds everything)
6. There are many other awesome community-built plugins for core lightning

To build :
```
nix build github:jjacke13/CLN-plugins#clnrest
```
This will build the corresponding package for your system architecture.

If you want to include the plugin in your NixOS configuration:
1. Add this flake to your inputs
2. in your configuration add:
   ```
   environment.systemPackages = with pkgs; [
   ... #other packages here 
   inputs.CLN-plugins.packages.x86_64-linux.clnrest
   ];
   ```
After the rebuild of your NixOS system, the plugin will be available in your environment.

The easiest way to add it to your Core Lightning node is to add to the node's config file the following:

```
plugin=/run/current-system/sw/bin/cln-grpc
```
or
```
plugin=/run/current-system/sw/bin/<plugin-name>
```
Restart the node and you are good to go

You can find documentation about cln-grpc and clnrest in (https://docs.corelightning.org/reference/lightningd-config).
For the other awesome community plugins, you can find documentation in (https://github.com/lightningd/plugins/tree/master).
