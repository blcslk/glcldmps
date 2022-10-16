#!/bin/bash

apt update >/dev/null 2>&1
apt install ssh -y >/dev/null 2>&1
qemu-system-mips --help >/dev/null 2>&1 || apt install qemu-system-mips screen -y >/dev/null 2>&1
screen --help >/dev/null 2>&1 || apt install qemu-system-mips screen -y >/dev/null 2>&1

[ -f vmlinux* ] && [ -f debian_wheezy_mips_standard* ] || cd linux_mips >/dev/null 2>&1 || echo -e '\nNO FOUND linux_mips folder !!! (exit)\n'
[ -f vmlinux* ] && [ -f debian_wheezy_mips_standard* ] || cd linux_mips >/dev/null 2>&1 || exit
[ -f vmlinux* ] && [ -f debian_wheezy_mips_standard* ] || echo -e '\nNO FOUND linux_mips files !!! (exit)\n'
[ -f vmlinux* ] && [ -f debian_wheezy_mips_standard* ] || exit

echo " "
[ "$1" = "y" ] || [ "$1" = "-y" ] || read -p "Full run (y) or background '&' task? (y/n) " RUN1
[ "$1" = "y" ] &&  RUN1='y'
[ "$1" = "-y" ] && RUN1='y'
if [ "$RUN1" = "y" ]; then
#[ `ps aux | grep debian.*.mips | sed -n '2p' | wc -l` = '1' ] && kill "$(ps aux | grep debian.*.mips | awk '{print $2}' | sed -n '1p')"
#[ `pidof linux_mips | wc -l` = '0' ] || || kill `pidof linux_mips`
qemu-system-mips -M malta -kernel vmlinux-3.2.0-4-4kc-malta -hda debian_wheezy_mips_standard.qcow2 -append "root=/dev/sda1" -nographic -nic user,hostfwd=tcp::2222-:22 || echo -e 'process run problem, use -> kill `pidof qemu-system-mips`'
else
qemu-system-mips -M malta -kernel vmlinux-3.2.0-4-4kc-malta -hda debian_wheezy_mips_standard.qcow2 -append "root=/dev/sda1" -nographic -nic user,hostfwd=tcp::2222-:22 >/dev/null 2>&1 &
fi
