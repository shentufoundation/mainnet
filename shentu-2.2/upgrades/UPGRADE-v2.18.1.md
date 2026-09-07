# Shentu v2.18.1 — Security Hardening Upgrade (static-PIE)

v2.18.1 rebuilds `shentud` as a **static-PIE** binary per an upstream security advisory. 
**Not consensus-breaking**: no upgrade height, no state migration — swap the binary and restart at your earliest convenience.

## 1. Download

```bash
wget https://snapshot-light.shentu.org/shentud_2.18.1_linux_amd64
sha256sum shentud_2.18.1_linux_amd64
# must be: 43f743366419d769d20497bdd3f484de330e36e07f2d54cdfd8cbfc4826fe602
```

## 2. Enable full ASLR on the host

```bash
sysctl kernel.randomize_va_space   # must be 2
```

If not `2`:

```bash
sudo sysctl -w kernel.randomize_va_space=2
echo "kernel.randomize_va_space=2" | sudo tee /etc/sysctl.d/99-aslr.conf   # persist across reboots
```

## 3. Swap the binary and restart as usual

Replace your existing `shentud` with the new binary and restart.

## 4. Verify after restart — all three must pass

```bash
shentud version                                        # v2.18.1
readelf -h /proc/$(pgrep -x shentud)/exe | grep Type   # DYN
sysctl kernel.randomize_va_space                       # 2
```

If the running process still shows `EXEC`, your service is launching a different binary — check `ExecStart=` / `ls -l /proc/$(pgrep -x shentud)/exe` and restart.