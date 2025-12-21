# Installtion Scripts

```
├── dnf.packages              -- Default packages to be installed from DNF
├── flatpak.packages          -- Default packages to be installed as flatpak
├── sysconf
│   ├── all.sh                 
│   ├── codecs.sh             -- Media & HW Codecs (AMD)
│   ├── dnf.sh                -- DNF optimisations & Automatic Installs
│   ├── dns.sh                -- DNS setup
│   ├── firmware.sh           -- Check for firmware updates
│   ├── repos.sh              -- Install RPMFusion and Terra repositories
│   └── startup.sh            -- Startup related setup (Plymouth, Greetd & Grub)
└── userconf
    ├── all.sh                 
    ├── base_packages.sh      -- Install default packages
    ├── dots.sh               -- Setup config files with stow
    └── gaming_packages.sh    -- Install gaming packages
```
