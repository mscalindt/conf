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
./conf: $(BUILD_CONF) ./src/units/ ./src/devices/main.conf ./src/devices/$(CONF) ./src/devices/readonly
	sh ./scripts/build.sh ./src/units/ ./src/devices/main.conf ./src/devices/$(CONF) ./src/devices/readonly
./run: ./scripts/run.sh
	cp scripts/run.sh ./run

clean:
	-(cd lib/syscfg && $(MAKE) clean)
	rm -fv ./$(BUILD_CONF) ./syscfg ./conf ./run

config:
	@test -n "$(CN)" || { echo 'CN is empty'; exit 2; }
	./run --no-color --status-pager -- ./src/_alacritty_conf
	./run --no-color --status-pager -- ./src/_alsa_conf
	./run --no-color --status-pager -- ./src/_bash_conf
	./run --no-color --status-pager -- ./src/_dhcpcd_conf
	./run --no-color --status-pager -- ./src/_dnsmasq_conf
	./run --no-color --status-pager -- ./src/_doas_conf
	./run --no-color --status-pager -- ./src/_emacs_conf
	./run --no-color --status-pager -- ./src/_face
	./run --no-color --status-pager -- ./src/_featherpad_conf
	./run --no-color --status-pager -- ./src/_firefox_conf
	./run --no-color --status-pager -- ./src/_fontconfig_conf
	rm -f /etc/fstab
	./run --no-color --status-pager -o /etc/fstab -- ./src/_fstab
	./run --no-color --status-pager -- ./src/_fuse_conf
	./run --no-color --status-pager -- ./src/_git_conf
	# First configure locales before generation.
	# {
	./run --no-color --status-pager -- ./src/_glibc_conf "$(CN)"
	./run --no-color --status-pager -- ./src/_locale
	# }
	./run --no-color --status-pager -- ./src/_gpg_conf
	# First configure GRUB before install.
	# {
	./run --no-color --status-pager -- ./src/_grub_conf
	./run --no-color --status-pager -- ./src/_grub
	# }
	./run --no-color --status-pager -- ./src/_gtk_conf
	./run --no-color --status-pager -- ./src/_hostname
	./run --no-color --status-pager -- ./src/_hosts
	./run --no-color --status-pager -- ./src/_initramfs
	./run --no-color --status-pager -- ./src/_kvantum_conf
	./run --no-color --status-pager -- ./src/_modprobe_conf
	./run --no-color --status-pager -- ./src/_mpv_conf
	./run --no-color --status-pager -- ./src/_mutt_conf
	./run --no-color --status-pager -- ./src/_nano_conf
	./run --no-color --status-pager -- ./src/_openal_conf
	./run --no-color --status-pager -- ./src/_pacman_conf
	./run --no-color --status-pager -- ./src/_pam_conf
	./run --no-color --status-pager -- ./src/_pulseaudio_conf
	./run --no-color --status-pager -- ./src/_ranger_conf
	./run --no-color --status-pager -- ./src/_resolv
	./run --no-color --status-pager -- ./src/_sh
	./run --no-color --status-pager -- ./src/_sudo_conf
	./run --no-color --status-pager -- ./src/_sway_conf
	./run --no-color --status-pager -- ./src/_swayimg_conf
	./run --no-color --status-pager -- ./src/_swaylock_conf
	./run --no-color --status-pager -- ./src/_sysctl_conf
	./run --no-color --status-pager -- ./src/_systemd
	./run --no-color --status-pager -- ./src/_systemd_conf
	./run --no-color --status-pager -- ./src/_xdg_conf

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
