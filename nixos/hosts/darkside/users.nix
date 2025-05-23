{ config, ... }:

{
  config = {
    users = {
      users = {
        buber = {
          extraGroups = [
            "libvirt"
            "kvm"
          ];
        };
      };

      groups = {
        libvirtd = {
          members = [
            "root"
            "buber"
          ];
        };
      };
    };
  };
}
