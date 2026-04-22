.PHONY: build clean config run rel sbm_up

CONF ?= m533ia.conf

build: ./syscfg ./conf
./syscfg: ./lib/syscfg/src/syscfg.sh
	(cd lib/syscfg && $(MAKE))
	cp lib/syscfg/syscfg ./syscfg
./conf: ./src/units/ ./src/devices/main.conf ./src/devices/$(CONF)
	sh ./scripts/build.sh ./src/units/ ./src/devices/main.conf ./src/devices/$(CONF)

clean:
	rm ./lib/syscfg/syscfg ./syscfg ./conf

config: ./syscfg ./conf
	@test -n "$(CN)" || { echo 'CN is empty'; exit 2; }
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_alacritty_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_alsa_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_bash_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_dhcpcd_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_dnsmasq_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_doas_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_emacs_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_env
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_face_bin
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_featherpad_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_firefox_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_fontconfig_conf
	rm -f /etc/fstab
	sh ./syscfg --no-color --status-pager -So /etc/fstab -s ./conf -- ./src/_fstab
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_fuse_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_gai_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_git_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_gpg_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_grub
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_grub_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_gtk_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_hostname
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_hosts
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_initramfs_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_kvantum_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_locale
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_makepkg_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_mpv_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_mutt_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_nano_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_openal_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_pacman_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_pam_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_pipewire_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_pipewire_media_session_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_ranger_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_resolv_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_sh
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_sudo_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_sway_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_swayimg_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_swaylock_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_systemd
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_systemd_conf
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_tz_$(CN)
	sh ./syscfg --no-color --status-pager -s ./conf -- ./src/_xdg_conf

run: ./syscfg ./conf
	@test -n "$(FUNC)" || { echo 'FUNC is empty'; exit 2; }
	sh ./scripts/run.sh ./src/$(FUNC) "$(OUT)"

rel:
	@test -n "$(REL)" || { echo 'REL is empty'; exit 2; }
	@test -n "$(PRE)" || { echo 'PRE is empty'; exit 2; }
	@test -n "$(CUR)" || { echo 'CUR is empty'; exit 2; }
	sh ./scripts/rel.sh "$(REL)" "$(PRE)" "$(CUR)"

sbm_up:
	@test -n "$(SUB)" || { echo 'SUB is empty'; exit 2; }
	@test -n "$(TAG)" || { echo 'TAG is empty'; exit 2; }
	sh ./scripts/sbm_up.sh "$(SUB)" "$(TAG)"
