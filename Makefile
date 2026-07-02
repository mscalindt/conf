.PHONY: build clean config rel sbm_up srcs

CONF = m533ia.conf
BUILD_CONF = .build.tmp

build: ./syscfg ./conf ./run
BUILD_TS:
$(BUILD_CONF): BUILD_TS
	@sh ./scripts/build_ts.sh "$(BUILD_CONF)" "$(CONF)"
./syscfg: ./lib/syscfg/src/syscfg.sh
	(cd lib/syscfg && $(MAKE))
	cp lib/syscfg/syscfg ./syscfg
./conf: $(BUILD_CONF) ./src/units/ ./src/configs/main.conf ./src/configs/$(CONF) ./src/configs/readonly
	sh ./scripts/build.sh ./src/units/ ./src/configs/main.conf ./src/configs/$(CONF) ./src/configs/readonly
./run: ./scripts/run.sh
	cp scripts/run.sh ./run

clean:
	-(cd lib/syscfg && $(MAKE) clean)
	rm -fv ./$(BUILD_CONF) ./syscfg ./conf ./run

# The order is explicit while alphabetical; /sys configuration shall be last,
# as it depends on prior entries. Examples:
# - GRUB must first be configured (sw/grub) before installation (sys/grub);
# - Locales must first be configured (sw/glibc) before generation (sys/locale).
#
# If it so happens that the alphabetical convention cannot naturally
# accommodate a conditional, any conditionals shall be placed at the top of
# the recipe.
config:
	@test -n "$(cc)" || { echo 'Define $cc (ISO 3166-1 alpha-2)'; exit 2; }
	./run --no-color --status-pager -- src/fs/face
	./run --no-color --status-pager -- src/fs/fstab
	./run --no-color --status-pager -- src/fs/hostname
	./run --no-color --status-pager -- src/fs/hosts
	./run --no-color --status-pager -- src/fs/locale
	./run --no-color --status-pager -- src/fs/resolv
	./run --no-color --status-pager -- src/sw/alacritty
	./run --no-color --status-pager -- src/sw/alsa
	./run --no-color --status-pager -- src/sw/bash
	./run --no-color --status-pager -- src/sw/dhcpcd
	./run --no-color --status-pager -- src/sw/dnsmasq
	./run --no-color --status-pager -- src/sw/doas
	./run --no-color --status-pager -- src/sw/emacs
	./run --no-color --status-pager -- src/sw/featherpad
	./run --no-color --status-pager -- src/sw/firefox
	./run --no-color --status-pager -- src/sw/fontconfig
	./run --no-color --status-pager -- src/sw/fuse
	./run --no-color --status-pager -- src/sw/git
	./run --no-color --status-pager -- src/sw/glibc "$(cc)"
	./run --no-color --status-pager -- src/sw/gpg
	./run --no-color --status-pager -- src/sw/grub
	./run --no-color --status-pager -- src/sw/gtk
	./run --no-color --status-pager -- src/sw/kvantum
	./run --no-color --status-pager -- src/sw/modprobe
	./run --no-color --status-pager -- src/sw/mpv
	./run --no-color --status-pager -- src/sw/mutt
	./run --no-color --status-pager -- src/sw/nano
	./run --no-color --status-pager -- src/sw/openal
	./run --no-color --status-pager -- src/sw/pacman
	./run --no-color --status-pager -- src/sw/pam
	./run --no-color --status-pager -- src/sw/pulseaudio
	./run --no-color --status-pager -- src/sw/ranger
	./run --no-color --status-pager -- src/sw/sudo
	./run --no-color --status-pager -- src/sw/sway
	./run --no-color --status-pager -- src/sw/swayimg
	./run --no-color --status-pager -- src/sw/swaylock
	./run --no-color --status-pager -- src/sw/sysctl
	./run --no-color --status-pager -- src/sw/systemd
	./run --no-color --status-pager -- src/sw/xdg
	./run --no-color --status-pager -- src/sys/grub
	./run --no-color --status-pager -- src/sys/initramfs
	./run --no-color --status-pager -- src/sys/locale
	./run --no-color --status-pager -- src/sys/sh
	./run --no-color --status-pager -- src/sys/systemd

rel:
	@test -n "$(REL)" || { echo 'REL is empty'; exit 2; }
	@test -n "$(PRE)" || { echo 'PRE is empty'; exit 2; }
	@test -n "$(CUR)" || { echo 'CUR is empty'; exit 2; }
	sh ./scripts/rel.sh "$(REL)" "$(PRE)" "$(CUR)"

sbm_up:
	@test -n "$(SUB)" || { echo 'SUB is empty'; exit 2; }
	@test -n "$(TAG)" || { echo 'TAG is empty'; exit 2; }
	sh ./scripts/sbm_up.sh "$(SUB)" "$(TAG)"

srcs:
	sh ./scripts/srcs.sh
