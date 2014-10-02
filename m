From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Thu, 02 Oct 2014 10:02:17 +0200
Message-ID: <542D0689.8050602@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de>	<alpine.DEB.2.11.1410010058160.4455@nanos>	<542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070604050708020006020709"
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Patrik Lundquist <patrik.lundquist@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54413 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaJBICY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Oct 2014 04:02:24 -0400
In-Reply-To: <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070604050708020006020709
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Patrik Lundquist schrieb:
> On 1 October 2014 09:27, Armin Steinhoff <armin@steinhoff.de> wrote:
>> Thomas Gleixner schrieb:
>>> On Tue, 30 Sep 2014, Armin Steinhoff wrote:
>>>> How to solve that problem ?
>>> Hint #1: 3.4.0-rc7-rt7-2.16
>> I'm using the vanilla kernel "linux-3.4-rc7.tar.gz" and the related(?)=

>> RT patch "patch-3.4-rt7.patch.xz" from "kernel.org"
> Try linux-3.4.97.tar.xz with patch-3.4.97-rt121.patch.xz

Yes, the version 3.4.97 + patch doesn't have any problems with the call
"pthread_setschedparam"! Thanks a lot!

I'm running the PCAP version of a MN node of openPOWERLINK. This app is
a plain userspace app ... it starts on core 0 and core 2
several threads which are using different RT priorities. ( core 1 "not
used" in that case)

But there are some sideeffects to other running processes/threads
related to their assigned priorities.
Here is the priority assignment after a fresh boot:  ps -elf  ->
Prio-After-OS-Restart.txt attached

If the app "demo_mn_console" has started its first RT thread,  a lot of
other processes/threads are jumping to the highest RT priority 99!!
Please have a look to: ps -elf -> Prio-after-app-start.txt

Do we have a problem with the RT kernel ? Or is simply the ps utility
broken ?

Best Regards

--Armin


--------------070604050708020006020709
Content-Type: text/plain; charset=UTF-8;
 name="Prio-After-OS-boot.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Prio-After-OS-boot.txt"

LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
 ps -elf
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIM=
E CMD
4 S root         1     0  0  80   0 - 10919 ep_pol 23:40 ?        00:00:0=
1 /sbin/init showopts x11failsafe
1 S root         2     0  0  80   0 -     0 kthrea 23:40 ?        00:00:0=
0 [kthreadd]
5 S root         3     2  0  58   - -     0 run_ks 23:40 ?        00:00:0=
1 [ksoftirqd/0]
1 S root         4     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/0:0]
1 S root         5     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:0]
1 S root         6     2  0 -40   - -     0 posix_ 23:40 ?        00:00:0=
0 [posixcputmr/0]
1 S root         7     2  0  80   0 -     0 run_cm 23:40 ?        00:00:0=
0 [kcmosdelayd]
1 S root         8     2  0 -40   - -     0 cpu_st 23:40 ?        00:00:0=
0 [migration/0]
1 S root         9     2  0  58   - -     0 rcu_cp 23:40 ?        00:00:0=
0 [rcuc/0]
1 S root        10     2  0 -40   - -     0 rcu_no 23:40 ?        00:00:0=
0 [rcun/0]
1 S root        11     2  0  58   - -     0 rcu_bo 23:40 ?        00:00:0=
0 [rcub/0]
1 S root        12     2  0 -40   - -     0 rcu_no 23:40 ?        00:00:0=
0 [rcun/1]
1 S root        13     2  0  58   - -     0 rcu_bo 23:40 ?        00:00:0=
0 [rcub/1]
1 S root        14     2  0 -40   - -     0 watchd 23:40 ?        00:00:0=
0 [watchdog/0]
1 S root        15     2  0 -40   - -     0 posix_ 23:40 ?        00:00:0=
0 [posixcputmr/1]
1 S root        16     2  0 -40   - -     0 cpu_st 23:40 ?        00:00:0=
0 [migration/1]
1 S root        17     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/1:0]
1 S root        18     2  0  58   - -     0 rcu_cp 23:40 ?        00:00:0=
0 [rcuc/1]
5 S root        19     2  0  58   - -     0 run_ks 23:40 ?        00:00:0=
1 [ksoftirqd/1]
1 S root        20     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/0:1]
1 S root        21     2  0 -40   - -     0 watchd 23:40 ?        00:00:0=
0 [watchdog/1]
1 S root        22     2  0 -40   - -     0 posix_ 23:40 ?        00:00:0=
0 [posixcputmr/2]
1 S root        23     2  0 -40   - -     0 cpu_st 23:40 ?        00:00:0=
0 [migration/2]
1 S root        24     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/2:0]
1 S root        25     2  0  58   - -     0 rcu_cp 23:40 ?        00:00:0=
0 [rcuc/2]
5 S root        26     2  0  58   - -     0 run_ks 23:40 ?        00:00:0=
1 [ksoftirqd/2]
1 S root        27     2  0 -40   - -     0 watchd 23:40 ?        00:00:0=
0 [watchdog/2]
1 S root        28     2  0 -40   - -     0 posix_ 23:40 ?        00:00:0=
0 [posixcputmr/3]
1 S root        29     2  0 -40   - -     0 cpu_st 23:40 ?        00:00:0=
0 [migration/3]
1 S root        30     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/3:0]
1 S root        31     2  0  58   - -     0 rcu_cp 23:40 ?        00:00:0=
0 [rcuc/3]
5 S root        32     2  0  58   - -     0 run_ks 23:40 ?        00:00:0=
1 [ksoftirqd/3]
1 S root        33     2  0 -40   - -     0 watchd 23:40 ?        00:00:0=
0 [watchdog/3]
1 S root        34     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [cpuset]
1 S root        35     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [khelper]
5 S root        36     2  0  80   0 -     0 devtmp 23:40 ?        00:00:0=
0 [kdevtmpfs]
1 S root        37     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [netns]
1 S root        38     2  0  80   0 -     0 bdi_sy 23:40 ?        00:00:0=
0 [sync_supers]
1 S root        39     2  0  80   0 -     0 bdi_fo 23:40 ?        00:00:0=
0 [bdi-default]
1 S root        40     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [kintegrityd]
1 S root        41     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [crypto]
1 S root        42     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [kblockd]
1 S root        43     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/9-acpi]
1 S root        44     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [ata_sff]
1 S root        45     2  0  80   0 -     0 hub_th 23:40 ?        00:00:0=
0 [khubd]
1 S root        46     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [md]
1 S root        47     2  0  80   0 -     0 mce_no 23:40 ?        00:00:0=
0 [mce-notify]
1 S root        48     2  0  80   0 -     0 watchd 23:40 ?        00:00:0=
0 [khungtaskd]
1 S root        49     2  0  80   0 -     0 kswapd 23:40 ?        00:00:0=
0 [kswapd0]
1 S root        50     2  0  85   5 -     0 ksm_sc 23:40 ?        00:00:0=
0 [ksmd]
1 S root        51     2  0  80   0 -     0 fsnoti 23:40 ?        00:00:0=
0 [fsnotify_mark]
1 S root        55     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [kthrotld]
1 S root        56     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/40-PCIe PME]
1 S root        57     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/41-PCIe PME]
1 S root        58     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/42-ahci]
1 S root        59     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_0]
1 S root        60     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_1]
1 S root        61     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_2]
1 S root        62     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_3]
1 S root        63     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_4]
1 S root        64     2  0  80   0 -     0 scsi_e 23:40 ?        00:00:0=
0 [scsi_eh_5]
1 S root        65     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:1]
1 S root        66     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:2]
1 S root        67     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:3]
1 S root        68     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:4]
1 S root        69     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:5]
1 S root        70     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:6]
1 S root        71     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/16-ehci_hcd]
1 S root        72     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/23-ehci_hcd]
1 S root        73     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/1-i8042]
1 S root        74     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [kpsmoused]
1 S root        75     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/0:2]
1 S root        76     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/8-rtc0]
1 S root        77     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/u:7]
1 S root        78     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/2:1]
1 S root        79     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/1:1]
1 S root        80     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [deferwq]
1 S root        81     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/3:1]
1 S root       137     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [kmpath_rdacd]
1 S root       174     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/43-i915]
1 S root       175     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/3:2]
1 S root       176     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/1:2]
1 S root       238     2  0  80   0 -     0 kjourn 23:40 ?        00:00:0=
0 [jbd2/sda6-8]
1 S root       239     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [ext4-dio-unwrit]
1 S root       246     2  0  80   0 -     0 bdi_wr 23:40 ?        00:00:0=
0 [flush-8:0]
4 S root       292     1  0  80   0 -  9019 ep_pol 23:40 ?        00:00:0=
0 /lib/systemd/systemd-journald
1 S root       294     2  0  80   0 -     0 kaudit 23:40 ?        00:00:0=
0 [kauditd]
4 S root       314     1  0  80   0 -  8480 ep_pol 23:40 ?        00:00:0=
0 /lib/udev/udevd
1 S root       325     2  0  80   0 -     0 worker 23:40 ?        00:00:0=
0 [kworker/2:2]
5 S root       384   314  0  80   0 -  8486 ep_pol 23:40 ?        00:00:0=
0 /lib/udev/udevd
5 S root       385   314  0  80   0 -  8457 ep_pol 23:40 ?        00:00:0=
0 /lib/udev/udevd
1 S root       429     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/44-mei]
1 S root       432     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/5-parport0]
1 S root       450     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/46-snd_hda_]
1 S root       453     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [hd-audio0]
1 S root       502     2  0  80   0 -     0 kjourn 23:40 ?        00:00:0=
0 [jbd2/sda7-8]
1 S root       503     2  0  60 -20 -     0 rescue 23:40 ?        00:00:0=
0 [ext4-dio-unwrit]
4 S root       537     1  0  80   0 -  2130 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/haveged -F 1 -w 1024 -v 0
4 S root       545     1  0  80   0 - 15663 ep_pol 23:40 ?        00:00:0=
0 /usr/sbin/cupsd -f
4 S avahi      548     1  0  80   0 -  7531 poll_s 23:40 ?        00:00:0=
0 avahi-daemon: running [LINUX4C.local]
4 S root       551     1  0  80   0 -  4199 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/nscd -d
5 S root       556     1  0  80   0 -  5297 hrtime 23:40 ?        00:00:0=
0 /usr/sbin/irqbalance
4 S root       558     1  0  80   0 -  5272 poll_s 23:40 ?        00:00:0=
0 /sbin/rpcbind -w -f
4 S root       561     1  0  80   0 -  6520 ep_pol 23:40 ?        00:00:0=
0 /lib/systemd/systemd-logind
5 S root       601     1  0  80   0 - 62804 poll_s 23:40 ?        00:00:0=
0 /sbin/rsyslogd -c 5 -f /etc/rsyslog.conf
1 S root       607     1  0  80   0 -  5490 poll_s 23:40 ?        00:00:0=
0 /usr/bin/vmware-usbarbitrator
1 S root       608     1  0  80   0 -  1054 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/acpid
4 S root       611     1  0  80   0 -  4891 hrtime 23:40 ?        00:00:0=
0 /usr/sbin/smartd -n
4 S 100        612     1  0  80   0 -  5107 ep_pol 23:40 ?        00:00:0=
0 /bin/dbus-daemon --system --address=3Dsystemd: --nofork --nopidfile --s=
ystemd-activation
5 S root       635     1  0  76  -4 -  4956 ep_pol 23:40 ?        00:00:0=
0 /sbin/auditd -s disable
1 S root      1128     2  0   9   - -     0 irq_th 23:40 ?        00:00:0=
0 [irq/45-eth0]
5 S root      1259     1  0  80   0 -  2133 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/xinetd -pidfile /var/run/xinetd.init.pid
1 S root      1407     1  0  80   0 - 29324 futex_ 23:40 ?        00:00:0=
0 /usr/lib/vmware/bin/vmware-vmblock-fuse -o subtype=3Dvmware-vmblock,def=
ault_permissions,allow_other /var/run/vmblock-fuse
5 S root      1442     1  0  80   0 -  5402 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/vmware-authdlauncher
5 S root      1581     1  0  80   0 - 53082 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

4 S wwwrun    1608     1  0  80   0 - 81042 futex_ 23:40 ?        00:00:0=
0 /usr/bin/mono /usr/lib/mono/2.0/mod-mono-server2.exe --filename /tmp/mo=
d_mono_server_global --nonstop --master
5 S wwwrun    1614  1581  0  80   0 - 53090 inet_c 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1615  1581  0  80   0 - 53090 inet_c 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1617  1581  0  80   0 - 53090 inet_c 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1618  1581  0  80   0 - 53090 inet_c 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1619  1581  0  80   0 - 53090 inet_c 23:40 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

4 S root      1666     1  0  80   0 -  1051 n_tty_ 23:40 tty1     00:00:0=
0 /sbin/agetty tty1 38400
5 S ntp       1939     1  0  80   0 -  6199 poll_s 23:40 ?        00:00:0=
0 /usr/sbin/ntpd -p /var/run/ntp/ntpd.pid -g -u ntp:ntp -i /var/lib/ntp -=
c /etc/ntp.conf
5 S root      2001     1  0  80   0 -  7232 poll_s 23:40 ?        00:00:0=
0 /usr/bin/kdm
4 S root      2019  2001  1  80   0 - 65270 poll_s 23:40 tty7     00:00:0=
4 /usr/bin/Xorg -br :0 vt7 -auth /var/lib/xdm/authdir/authfiles/A:0-5Zyuu=
b
4 S root      2066     1  0  80   0 -  5199 ep_pol 23:40 ?        00:00:0=
0 /usr/lib/postfix/master
4 S postfix   2082  2066  0  80   0 -  5191 ep_pol 23:40 ?        00:00:0=
0 pickup -l -t fifo -u
4 S postfix   2083  2066  0  80   0 -  5253 ep_pol 23:40 ?        00:00:0=
0 qmgr -l -t fifo -u
5 S root      2099  2001  0  80   0 - 18786 rt_sig 23:40 ?        00:00:0=
0 -:0        =20
4 S root      2115     1  0  80   0 - 522895 poll_s 23:40 ?       00:00:0=
0 /usr/sbin/console-kit-daemon --no-daemon
4 S root      2180     1  0  80   0 - 50026 poll_s 23:40 ?        00:00:0=
0 /usr/lib/polkit-1/polkitd --no-debug
4 S root      2194  2099  0  80   0 -  2939 wait   23:40 ?        00:00:0=
0 /bin/sh /usr/bin/startkde
1 S root      2263  2194  0  80   0 -  3417 poll_s 23:40 ?        00:00:0=
0 /usr/bin/gpg-agent --sh --daemon --write-env-file /root/.gnupg/agent.in=
fo /usr/bin/ssh-agent /etc/X11/xinit/xinitrc
1 S root      2264  2194  0  80   0 -  3071 poll_s 23:40 ?        00:00:0=
0 /usr/bin/ssh-agent /etc/X11/xinit/xinitrc
1 S root      2305     1  0  80   0 -  3972 poll_s 23:40 ?        00:00:0=
0 dbus-launch --sh-syntax --exit-with-session
5 S root      2306     1  0  80   0 -  5206 ep_pol 23:40 ?        00:00:0=
0 /bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
1 S root      2313     1  0  80   0 -  1011 pipe_w 23:40 ?        00:00:0=
0 /usr/lib64/kde4/libexec/start_kdeinit +kcminit_startup
1 S root      2314     1  0  80   0 - 77118 poll_s 23:40 ?        00:00:0=
0 kdeinit4: kdeinit4 Running...                 =20
1 S root      2315  2314  0  80   0 - 78180 poll_s 23:41 ?        00:00:0=
0 kdeinit4: klauncher [kdeinit] --fd=3D9          =20
5 S root      2317     1  0  80   0 - 184593 poll_s 23:41 ?       00:00:0=
0 kdeinit4: kded4 [kdeinit]                     =20
1 S root      2321     1  0  80   0 - 97803 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kglobalaccel [kdeinit]              =20
1 S root      2325     1  0  80   0 - 62127 poll_s 23:41 ?        00:00:0=
0 /usr/bin/kactivitymanagerd
4 S root      2327     1  0  80   0 - 59344 poll_s 23:41 ?        00:00:0=
0 /usr/lib/upower/upowerd
0 S root      2328  2194  0  80   0 -  1045 unix_s 23:41 ?        00:00:0=
0 kwrapper4 ksmserver
1 S root      2332  2314  0  80   0 - 116590 poll_s 23:41 ?       00:00:0=
0 kdeinit4: ksmserver [kdeinit]                 =20
0 S root      2367  2332  0  80   0 - 126414 poll_s 23:41 ?       00:00:0=
0 kwin -session 10a47d9155000137310114000000024450000_1412199561_893484
4 S root      2391     1  0  80   0 - 48371 poll_s 23:41 ?        00:00:0=
1 /usr/lib/udisks/udisks-daemon
1 S root      2393  2391  0  80   0 - 11383 poll_s 23:41 ?        00:00:0=
0 udisks-daemon: not polling any devices
5 S root      2411     1  0  80   0 - 235303 poll_s 23:41 ?       00:00:0=
0 /usr/bin/knotify4
5 S root      2426     1  1  80   0 - 227151 poll_s 23:41 ?       00:00:0=
2 kdeinit4: plasma-desktop [kdeinit]            =20
1 S root      2431     1  0  80   0 - 61738 poll_s 23:41 ?        00:00:0=
0 /usr/bin/kuiserver
1 S root      2463     1  0  80   0 - 97573 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kaccess [kdeinit]                   =20
1 S root      2471     1  0  80   0 - 172873 poll_s 23:41 ?       00:00:0=
0 kdeinit4: krunner [kdeinit]                   =20
1 S root      2472  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 1011dc9d2e6000134588144200000030=
560010_1412199561_885901
1 S root      2473  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20012_1412199561_886003
1 S root      2474  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20013_1412199561_886006
1 S root      2475  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20014_1412199561_886012
0 S root      2476  2314  0  80   0 - 89209 poll_s 23:41 ?        00:00:0=
0 kres-migrator -session 10a47d9155000139300665600000025640068_1412199561=
_886056
1 S root      2483     1  0  80   0 - 111217 poll_s 23:41 ?       00:00:0=
0 /usr/bin/kopete -session 10a47d9155000139308385800000035730047_14121995=
61_886064
5 S root      2494     1  0  80   0 - 107494 poll_s 23:41 ?       00:00:0=
0 /usr/bin/kget -session 10a47d9155000139809448100000050170028_1412199561=
_886115
5 S root      2510     1  0  80   0 - 103705 poll_s 23:41 ?       00:00:0=
0 /usr/bin/ktorrent -session 10a47d9155000139962581600000025140021_141219=
9561_886125
1 S root      2512     1  0  80   0 - 118387 poll_s 23:41 ?       00:00:0=
0 kdeinit4: kmix [kdeinit] -session 10a47d9155000140188735700000025220006=
_1412199561_886181
0 S root      2514  2314  0  80   0 - 59233 poll_s 23:41 ?        00:00:0=
0 /usr/bin/qasmixer -session 10a47d9155000140188752900000025220009_141219=
9561_886232
1 S root      2515  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407137605000000240=
00021_1412199561_886235
1 S root      2516  2314  0  80   0 - 99539 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407588518000000241=
00039_1412199561_886274
1 S root      2517  2314  0  80   0 - 99537 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407588761000000241=
00045_1412199561_886276
1 S root      2518  2314  0  80   0 - 99538 poll_s 23:41 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001409511288000000245=
80009_1412199561_886283
5 S root      2525     1  0  80   0 - 341238 poll_s 23:41 ?       00:00:0=
1 /usr/bin/amarok -session 10a47d9155000141199627500000025150040_14121995=
61_886536
1 S root      2538     1  0  80   0 - 83443 poll_s 23:41 ?        00:00:0=
0 /usr/lib64/kde4/libexec/polkit-kde-authentication-agent-1
1 S root      2584  2314  0  80   0 - 98842 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_http [kdeinit] http local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/amarokPE2525.slave-socket
1 S root      2585  2314  0  80   0 - 77686 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_file [kdeinit] file local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/amarokbZ2525.slave-socket
1 S root      2588  2314  0  80   0 - 98842 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_http [kdeinit] http local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/amarokEa2525.slave-socket
1 S root      2589  2314  0  80   0 - 77686 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_file [kdeinit] file local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/amarokqV2525.slave-socket
1 S root      2590  2314  0  80   0 - 98843 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_http [kdeinit] http local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/amarokSa2525.slave-socket
1 S root      2597  2314  1  80   0 - 131647 poll_s 23:41 ?       00:00:0=
2 kdeinit4: konqueror [kdeinit] --silent        =20
1 S root      2598  2314  0  80   0 - 77686 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_file [kdeinit] file local:/tmp/ksocket-root/klauncherMT23=
15.slave-socket local:/tmp/ksocket-root/konquerorhZ2597.slave-socket
1 S root      2604  2314  0  80   0 - 98434 poll_s 23:41 ?        00:00:0=
0 kdeinit4: kio_thumbnail [kdeinit] thumbnail local:/tmp/ksocket-root/kla=
uncherMT2315.slave-socket local:/tmp/ksocket-root/konqueroruI2597.slave-s=
ocket
0 S root      2623     1  0  80   0 -  9846 poll_s 23:41 ?        00:00:0=
0 /usr/lib/gvfs/gvfsd
4 S root      2625     1  0  80   0 - 50426 futex_ 23:41 ?        00:00:0=
0 /usr/lib/gvfs//gvfs-fuse-daemon -f /root/.cache/gvfs
5 R root      4986     1  1  80   0 - 123513 poll_s 23:43 ?       00:00:0=
0 kdeinit4: konsole [kdeinit] --workdir /home/opt/openPOWERLINK-V2.0.1/ap=
ps/demo_mn_console/build/linux
0 S root      4988  4986  0  80   0 -  3330 wait   23:43 pts/1    00:00:0=
0 /bin/bash
0 R root      5088  4988  0  80   0 -  1230 -      23:44 pts/1    00:00:0=
0 ps -elf
LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
 uname -a
Linux LINUX4C 3.4.97-rt121-2.16-desktop #1 SMP PREEMPT RT Wed Oct 1 16:31=
:42 CEST 2014 x86_64 x86_64 x86_64 GNU/Linux
LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
=20

--------------070604050708020006020709
Content-Type: text/plain; charset=UTF-8;
 name="Prio-after-app-start.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Prio-after-app-start.txt"

LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
 ps -elf
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIM=
E CMD
4 S root         1     0  0  99  19 - 10920 ep_pol 08:58 ?        00:00:0=
1 /sbin/init showopts x11failsafe
1 S root         2     0  0  99  19 -     0 kthrea 08:58 ?        00:00:0=
0 [kthreadd]
5 S root         3     2  0  58   - -     0 run_ks 08:58 ?        00:00:2=
0 [ksoftirqd/0]
1 S root         6     2  0 -40   - -     0 posix_ 08:58 ?        00:00:0=
0 [posixcputmr/0]
1 S root         7     2  0  99  19 -     0 run_cm 08:58 ?        00:00:0=
0 [kcmosdelayd]
1 S root         8     2  0 -40   - -     0 cpu_st 08:58 ?        00:00:0=
0 [migration/0]
1 S root         9     2  0  58   - -     0 rcu_cp 08:58 ?        00:00:0=
0 [rcuc/0]
1 S root        10     2  0 -40   - -     0 rcu_no 08:58 ?        00:00:0=
0 [rcun/0]
1 S root        11     2  0  58   - -     0 rcu_bo 08:58 ?        00:00:0=
0 [rcub/0]
1 S root        12     2  0 -40   - -     0 rcu_no 08:58 ?        00:00:0=
0 [rcun/1]
1 S root        13     2  0  58   - -     0 rcu_bo 08:58 ?        00:00:0=
0 [rcub/1]
1 S root        14     2  0 -40   - -     0 watchd 08:58 ?        00:00:0=
0 [watchdog/0]
1 S root        15     2  0 -40   - -     0 posix_ 08:58 ?        00:00:0=
0 [posixcputmr/1]
1 S root        16     2  0 -40   - -     0 cpu_st 08:58 ?        00:00:0=
0 [migration/1]
1 S root        18     2  0  58   - -     0 rcu_cp 08:58 ?        00:00:0=
1 [rcuc/1]
5 S root        19     2  0  58   - -     0 run_ks 08:58 ?        00:00:1=
9 [ksoftirqd/1]
1 S root        21     2  0 -40   - -     0 watchd 08:58 ?        00:00:0=
0 [watchdog/1]
1 S root        22     2  0 -40   - -     0 posix_ 08:58 ?        00:00:0=
0 [posixcputmr/2]
1 S root        23     2  0 -40   - -     0 cpu_st 08:58 ?        00:00:0=
0 [migration/2]
1 S root        25     2  0  58   - -     0 rcu_cp 08:58 ?        00:00:0=
0 [rcuc/2]
5 S root        26     2  0  58   - -     0 run_ks 08:58 ?        00:00:2=
0 [ksoftirqd/2]
1 S root        27     2  0 -40   - -     0 watchd 08:58 ?        00:00:0=
0 [watchdog/2]
1 S root        28     2  0 -40   - -     0 posix_ 08:58 ?        00:00:0=
0 [posixcputmr/3]
1 S root        29     2  0 -40   - -     0 cpu_st 08:58 ?        00:00:0=
0 [migration/3]
1 S root        31     2  0  58   - -     0 rcu_cp 08:58 ?        00:00:0=
0 [rcuc/3]
5 S root        32     2  0  58   - -     0 run_ks 08:58 ?        00:00:1=
8 [ksoftirqd/3]
1 S root        33     2  0 -40   - -     0 watchd 08:58 ?        00:00:0=
0 [watchdog/3]
1 S root        34     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [cpuset]
1 S root        35     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [khelper]
5 S root        36     2  0  99  19 -     0 devtmp 08:58 ?        00:00:0=
0 [kdevtmpfs]
1 S root        37     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [netns]
1 S root        38     2  0  99  19 -     0 bdi_sy 08:58 ?        00:00:0=
0 [sync_supers]
1 S root        39     2  0  99  19 -     0 bdi_fo 08:58 ?        00:00:0=
0 [bdi-default]
1 S root        40     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [kintegrityd]
1 S root        41     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [crypto]
1 S root        42     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [kblockd]
1 S root        43     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/9-acpi]
1 S root        44     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [ata_sff]
1 S root        45     2  0  99  19 -     0 hub_th 08:58 ?        00:00:0=
0 [khubd]
1 S root        46     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [md]
1 S root        47     2  0  99  19 -     0 mce_no 08:58 ?        00:00:0=
0 [mce-notify]
1 S root        48     2  0  99  19 -     0 watchd 08:58 ?        00:00:0=
0 [khungtaskd]
1 S root        49     2  0  99  19 -     0 kswapd 08:58 ?        00:00:0=
6 [kswapd0]
1 S root        50     2  0  99  19 -     0 ksm_sc 08:58 ?        00:00:0=
0 [ksmd]
1 S root        51     2  0  99  19 -     0 fsnoti 08:58 ?        00:00:0=
0 [fsnotify_mark]
1 S root        55     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [kthrotld]
1 S root        56     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/40-PCIe PME]
1 S root        57     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/41-PCIe PME]
1 S root        58     2  0   9   - -     0 irq_th 08:58 ?        00:00:1=
4 [irq/42-ahci]
1 S root        59     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_0]
1 S root        60     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_1]
1 S root        61     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_2]
1 S root        62     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_3]
1 S root        63     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_4]
1 S root        64     2  0  99  19 -     0 scsi_e 08:58 ?        00:00:0=
0 [scsi_eh_5]
1 S root        67     2  0  99  19 -     0 worker 08:58 ?        00:00:0=
0 [kworker/u:3]
1 S root        69     2  0  99  19 -     0 worker 08:58 ?        00:00:0=
0 [kworker/u:5]
1 S root        71     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
2 [irq/16-ehci_hcd]
1 S root        72     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/23-ehci_hcd]
1 S root        73     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/1-i8042]
1 S root        75     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [kpsmoused]
1 S root        76     2  0  99  19 -     0 worker 08:58 ?        00:00:0=
0 [kworker/1:2]
1 S root        77     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/8-rtc0]
1 S root        80     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [deferwq]
1 S root        81     2  0  99  19 -     0 worker 08:58 ?        00:00:0=
0 [kworker/3:1]
1 S root       137     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [kmpath_rdacd]
1 S root       187     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/43-i915]
1 S root       249     2  0  99  19 -     0 kjourn 08:58 ?        00:00:0=
0 [jbd2/sda6-8]
1 S root       250     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [ext4-dio-unwrit]
1 S root       257     2  0  99  19 -     0 bdi_wr 08:58 ?        00:00:0=
0 [flush-8:0]
4 S root       303     1  0  99  19 -  9043 ep_pol 08:58 ?        00:00:0=
0 /lib/systemd/systemd-journald
1 S root       305     2  0  99  19 -     0 kaudit 08:58 ?        00:00:0=
0 [kauditd]
4 S root       325     1  0  99  19 -  8622 ep_pol 08:58 ?        00:00:0=
0 /lib/udev/udevd
5 S root       448   325  0  99  19 -  8589 ep_pol 08:58 ?        00:00:0=
0 /lib/udev/udevd
1 S root       492     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/44-mei]
1 S root       501     2  0  99  19 -     0 worker 08:58 ?        00:00:0=
0 [kworker/3:2]
1 S root       516     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/5-parport0]
1 S root       529     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
3 [irq/46-snd_hda_]
1 S root       530     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [hd-audio0]
1 S root       566     2  0  99  19 -     0 kjourn 08:58 ?        00:00:0=
0 [jbd2/sda7-8]
1 S root       567     2  0  99  19 -     0 rescue 08:58 ?        00:00:0=
0 [ext4-dio-unwrit]
4 S root       602     1  0  99  19 -  2130 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/haveged -F 1 -w 1024 -v 0
4 S root       610     1  0  99  19 - 17769 ep_pol 08:58 ?        00:00:0=
0 /usr/sbin/cupsd -f
4 S avahi      612     1  0  80   0 -  5427 poll_s 08:58 ?        00:00:0=
0 avahi-daemon: running [LINUX4C.local]
4 S root       614     1  0  99  19 -  4199 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/nscd -d
4 S root       618     1  0  99  19 -  5272 poll_s 08:58 ?        00:00:0=
0 /sbin/rpcbind -w -f
4 S root       622     1  0  99  19 -  6520 ep_pol 08:58 ?        00:00:0=
0 /lib/systemd/systemd-logind
5 S root       652     1  0  99  19 -  5363 hrtime 08:58 ?        00:00:0=
0 /usr/sbin/irqbalance
5 S root       666     1  0  99  19 - 62805 poll_s 08:58 ?        00:00:0=
0 /sbin/rsyslogd -c 5 -f /etc/rsyslog.conf
1 S root       672     1  0  99  19 -  1054 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/acpid
1 S root       677     1  0  99  19 -  5490 poll_s 08:58 ?        00:00:0=
0 /usr/bin/vmware-usbarbitrator
4 S root       678     1  0  99  19 -  4891 hrtime 08:58 ?        00:00:0=
0 /usr/sbin/smartd -n
4 S 100        679     1  0  80   0 -  5042 ep_pol 08:58 ?        00:00:0=
5 /bin/dbus-daemon --system --address=3Dsystemd: --nofork --nopidfile --s=
ystemd-activation
5 S root       690     1  0  99  19 -  4956 ep_pol 08:58 ?        00:00:0=
0 /sbin/auditd -s disable
1 S root      1191     2  0   9   - -     0 irq_th 08:58 ?        00:00:0=
0 [irq/45-eth0]
5 S root      1323     1  0  99  19 -  2133 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/xinetd -pidfile /var/run/xinetd.init.pid
1 S root      1419     1  0  99  19 - 45708 futex_ 08:58 ?        00:00:0=
0 /usr/lib/vmware/bin/vmware-vmblock-fuse -o subtype=3Dvmware-vmblock,def=
ault_permissions,allow_other /var/run/vmblock-fuse
5 S root      1440     1  0  99  19 -  5402 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/vmware-authdlauncher
5 S root      1594     1  0  99  19 - 53082 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

4 S wwwrun    1655     1  0  80   0 - 81037 futex_ 08:58 ?        00:00:0=
0 /usr/bin/mono /usr/lib/mono/2.0/mod-mono-server2.exe --filename /tmp/mo=
d_mono_server_global --nonstop --master
5 S wwwrun    1658  1594  0  80   0 - 53090 inet_c 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1659  1594  0  80   0 - 53090 inet_c 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1663  1594  0  80   0 - 53090 inet_c 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1665  1594  0  80   0 - 53090 inet_c 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

5 S wwwrun    1666  1594  0  80   0 - 53090 inet_c 08:58 ?        00:00:0=
0 /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf -D SYSTEMD -k start=

4 S root      1714     1  0  99  19 -  1051 n_tty_ 08:58 tty1     00:00:0=
0 /sbin/agetty tty1 38400
5 S ntp       2003     1  0  80   0 -  6199 poll_s 08:58 ?        00:00:0=
0 /usr/sbin/ntpd -p /var/run/ntp/ntpd.pid -g -u ntp:ntp -i /var/lib/ntp -=
c /etc/ntp.conf
5 S root      2062     1  0  99  19 -  7232 poll_s 08:58 ?        00:00:0=
0 /usr/bin/kdm
4 S root      2081  2062  1  99  19 - 76883 poll_s 08:58 tty7     00:00:2=
7 /usr/bin/Xorg -br :0 vt7 -auth /var/lib/xdm/authdir/authfiles/A:0-Ltzht=
a
4 S root      2130     1  0  99  19 -  5199 ep_pol 08:58 ?        00:00:0=
0 /usr/lib/postfix/master
4 S postfix   2148  2130  0  80   0 -  5191 ep_pol 08:58 ?        00:00:0=
0 pickup -l -t fifo -u
4 S postfix   2149  2130  0  80   0 -  5253 ep_pol 08:58 ?        00:00:0=
0 qmgr -l -t fifo -u
5 S root      2165  2062  0  99  19 - 18785 rt_sig 08:58 ?        00:00:0=
0 -:0        =20
4 S root      2184     1  0  99  19 - 522896 poll_s 08:58 ?       00:00:0=
0 /usr/sbin/console-kit-daemon --no-daemon
4 S root      2249     1  0  99  19 - 50026 poll_s 08:58 ?        00:00:0=
0 /usr/lib/polkit-1/polkitd --no-debug
4 S root      2260  2165  0  99  19 -  2939 wait   08:58 ?        00:00:0=
0 /bin/sh /usr/bin/startkde
1 S root      2329  2260  0  99  19 -  3417 poll_s 08:58 ?        00:00:0=
0 /usr/bin/gpg-agent --sh --daemon --write-env-file /root/.gnupg/agent.in=
fo /usr/bin/ssh-agent /etc/X11/xinit/xinitrc
1 S root      2330  2260  0  99  19 -  3071 poll_s 08:58 ?        00:00:0=
0 /usr/bin/ssh-agent /etc/X11/xinit/xinitrc
1 S root      2371     1  0  99  19 -  3972 poll_s 08:58 ?        00:00:0=
0 dbus-launch --sh-syntax --exit-with-session
5 S root      2372     1  0  99  19 -  5206 ep_pol 08:58 ?        00:00:0=
0 /bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
1 S root      2379     1  0  99  19 -  1011 pipe_w 08:58 ?        00:00:0=
0 /usr/lib64/kde4/libexec/start_kdeinit +kcminit_startup
1 S root      2380     1  0  99  19 - 77118 poll_s 08:58 ?        00:00:0=
0 kdeinit4: kdeinit4 Running...                 =20
1 S root      2381  2380  0  99  19 - 78178 poll_s 08:58 ?        00:00:0=
0 kdeinit4: klauncher [kdeinit] --fd=3D9          =20
5 S root      2383     1  0  99  19 - 186042 poll_s 08:58 ?       00:00:0=
0 kdeinit4: kded4 [kdeinit]                     =20
1 S root      2387     1  0  99  19 - 97818 poll_s 08:58 ?        00:00:0=
0 kdeinit4: kglobalaccel [kdeinit]              =20
1 S root      2391     1  0  99  19 - 62127 poll_s 08:58 ?        00:00:0=
0 /usr/bin/kactivitymanagerd
4 S root      2393     1  0  99  19 - 59343 poll_s 08:58 ?        00:00:0=
0 /usr/lib/upower/upowerd
0 S root      2430  2260  0  99  19 -  1045 unix_s 08:58 ?        00:00:0=
0 kwrapper4 ksmserver
1 S root      2431  2380  0  99  19 - 116589 poll_s 08:58 ?       00:00:0=
0 kdeinit4: ksmserver [kdeinit]                 =20
4 S root      2459     1  0  99  19 - 48369 poll_s 08:58 ?        00:00:1=
8 /usr/lib/udisks/udisks-daemon
1 S root      2460  2459  0  99  19 - 11383 poll_s 08:58 ?        00:00:0=
0 udisks-daemon: not polling any devices
0 S root      2466  2431  0  99  19 - 126523 poll_s 08:58 ?       00:00:0=
1 kwin -session 10a47d9155000137310114000000024450000_1412200732_238637
5 S root      2489     1  0  99  19 - 235317 poll_s 08:58 ?       00:00:0=
0 /usr/bin/knotify4
5 S root      2492     1  0  99  19 - 229184 poll_s 08:58 ?       00:00:0=
6 kdeinit4: plasma-desktop [kdeinit]            =20
1 S root      2497     1  0  99  19 - 61737 poll_s 08:59 ?        00:00:0=
0 /usr/bin/kuiserver
1 S root      2529     1  0  99  19 - 97573 poll_s 08:59 ?        00:00:0=
0 kdeinit4: kaccess [kdeinit]                   =20
1 S root      2538  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 1011dc9d2e6000134588144200000030=
560010_1412200732_232885
1 S root      2539  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20012_1412200732_233139
1 S root      2540  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20013_1412200732_232893
1 S root      2541  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001360751392000000216=
20014_1412200732_233176
0 S root      2542  2380  0  99  19 - 89218 poll_s 08:59 ?        00:00:0=
0 kres-migrator -session 10a47d9155000139300665600000025640068_1412200732=
_233216
1 S root      2543     1  0  99  19 - 191304 poll_s 08:59 ?       00:00:0=
1 kdeinit4: krunner [kdeinit]                   =20
1 S root      2548     1  0  99  19 - 111223 poll_s 08:59 ?       00:00:0=
0 /usr/bin/kopete -session 10a47d9155000139308385800000035730047_14122007=
32_233261
5 S root      2565     1  0  99  19 - 107494 poll_s 08:59 ?       00:00:0=
0 /usr/bin/kget -session 10a47d9155000139809448100000050170028_1412200732=
_233305
5 S root      2576     1  0  99  19 - 103705 poll_s 08:59 ?       00:00:0=
1 /usr/bin/ktorrent -session 10a47d9155000139962581600000025140021_141220=
0732_233350
1 S root      2588     1  0  99  19 - 118422 poll_s 08:59 ?       00:00:0=
0 kdeinit4: kmix [kdeinit] -session 10a47d9155000140188735700000025220006=
_1412200732_233397
0 S root      2589  2380  0  99  19 - 59232 poll_s 08:59 ?        00:00:0=
0 /usr/bin/qasmixer -session 10a47d9155000140188752900000025220009_141220=
0732_233441
1 S root      2596  2380  0  99  19 - 99538 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407137605000000240=
00021_1412200732_233488
1 S root      2597  2380  0  99  19 - 99532 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407588518000000241=
00039_1412200732_233528
1 S root      2598  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001407588761000000241=
00045_1412200732_233568
1 S root      2599  2380  0  99  19 - 99539 poll_s 08:59 ?        00:00:0=
0 kdeinit4: konqueror [kdeinit] -session 10a47d91550001409511288000000245=
80009_1412200732_233598
5 S root      2618     1  0  99  19 - 341218 poll_s 08:59 ?       00:00:1=
5 /usr/bin/amarok -session 10a47d9155000141199627500000025150040_14122007=
32_233645
1 S root      2624     1  0  99  19 - 83443 poll_s 08:59 ?        00:00:0=
0 /usr/lib64/kde4/libexec/polkit-kde-authentication-agent-1
1 S root      2672  2380  0  99  19 - 130346 poll_s 09:03 ?       00:00:0=
0 kdeinit4: konqueror [kdeinit] --silent        =20
5 S root      2674  2380  1  99  19 - 136641 poll_s 09:03 ?       00:00:2=
6 kdeinit4: konqueror [kdeinit] --silent        =20
0 S root      2794  2380  0  99  19 - 196131 poll_s 09:05 ?       00:00:0=
6 /usr/lib64/firefox/firefox
0 S root      2806     1  0  99  19 - 10471 poll_s 09:05 ?        00:00:0=
0 /usr/lib/GConf/2/gconfd-2
0 S root      2822     1  0  99  19 -  9846 poll_s 09:05 ?        00:00:0=
0 /usr/lib/gvfs/gvfsd
4 S root      2824     1  0  99  19 - 66810 futex_ 09:05 ?        00:00:0=
0 /usr/lib/gvfs//gvfs-fuse-daemon -f /root/.cache/gvfs
0 S root      2831  2794  0  99  19 - 61063 poll_s 09:05 ?        00:00:0=
0 /usr/lib/mozilla/kmozillahelper
5 R root      2873     1  0  99  19 - 129708 poll_s 09:07 ?       00:00:0=
3 kdeinit4: konsole [kdeinit]                   =20
0 S root      2875  2873  0  99  19 -  3330 n_tty_ 09:07 pts/1    00:00:0=
0 /bin/bash
1 S root      2902     2  0  99  19 -     0 worker 09:09 ?        00:00:0=
0 [kworker/2:0]
1 S root      3068     2  0  99  19 -     0 worker 09:13 ?        00:00:0=
0 [kworker/1:0]
0 S root      3076  2873  0  99  19 -  3330 n_tty_ 09:13 pts/2    00:00:0=
0 /bin/bash
1 S root      3228     2  0  99  19 -     0 worker 09:26 ?        00:00:0=
0 [kworker/0:1]
1 S root      3237     2  0  99  19 -     0 worker 09:31 ?        00:00:0=
0 [kworker/0:0]
1 S root      3240     2  0  99  19 -     0 worker 09:33 ?        00:00:0=
0 [kworker/2:2]
1 S root      3247     2  0  99  19 -     0 worker 09:39 ?        00:00:0=
0 [kworker/0:2]
1 S root      3248  2380  0  99  19 - 77686 poll_s 09:40 ?        00:00:0=
0 kdeinit4: kio_file [kdeinit] file local:/tmp/ksocket-root/klauncherNT23=
81.slave-socket local:/tmp/ksocket-root/konqueroryX2674.slave-socket
1 S root      3251  2380  0  99  19 - 98485 poll_s 09:40 ?        00:00:0=
0 kdeinit4: kio_thumbnail [kdeinit] thumbnail local:/tmp/ksocket-root/kla=
uncherNT2381.slave-socket local:/tmp/ksocket-root/konquerorNL2674.slave-s=
ocket
0 S root      3262  2873  0  99  19 -  3330 wait   09:40 pts/3    00:00:0=
0 /bin/bash
5 S root      3291   325  0  99  19 -  8457 ep_pol 09:40 ?        00:00:0=
0 /lib/udev/udevd
0 R root      3373  3262  0  99  19 -  1230 -      09:41 pts/3    00:00:0=
0 ps -elf
LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
 uname -a
Linux LINUX4C 3.4.97-rt121-2.16-desktop #1 SMP PREEMPT RT Wed Oct 1 16:31=
:42 CEST 2014 x86_64 x86_64 x86_64 GNU/Linux
LINUX4C:/home/opt/openPOWERLINK-V2.0.1/apps/demo_mn_console/build/linux #=
=20

--------------070604050708020006020709--
