From: ulmo@sonic.net
Subject: 2.6.31.12-rt20:  BUG: sleeping function called from invalid
 context at kernel/rtmutex.c:684
Date: Sun, 14 Feb 2010 10:26:48 -0800
Message-ID: <f1abefc50f3730ba8ff4b099170c9a85.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ulmo@sonic.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:32851 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab0BNSo3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Feb 2010 13:44:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm getting plenty of dmesg errors in 2.6.31.12-rt20, a stock 2.6.31.12
with rt20 patch applied.  Reviewing lkml (google pointed me that way, not
surprisingly), I see that it's been happening variously for a few years.

My first theory is that it is started by X somehow.  I noted the "tainted"
in the output, so I do have to mention I have nvidia driver 190.53-r1
installed.  It happened first at 3266.451642 seconds kernel running, at
Feb 13 13:25:04.  Looking for processes aged that much, I see that "kdm"
started at 13:23, and some others:

ps -ax -Obsdstart
[...]
11843  13:23 S ?        00:00:00 kdm
11847  13:23 S tty6     00:01:56  \_ X
11851  13:23 S ?        00:00:00  \_ kdm
11876  13:23 S ?        00:00:00      \_ eternity
11859  13:23 S ?        00:00:00 dbus-launch
11860  13:23 S ?        00:00:00 dbus-daemon
11937  13:23 R ?        01:01:26 lwm
[...]

It happened well after I loaded the nvidia driver, but perhaps using it is
what causes it, since it happened first two minutes after starting X.  The
fact that the kernel ran for 3266.451641 seconds without trouble then
suddenly starts having lots of them when X starts indicates that X is very
related to the problem.

I left a copy of various output at <http://tinyurl.com/yhayonp/>,
including dmesg, kernel log, config, lsmod, and the above ps.  Here's one
excerpt:

[16130.519908] BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
[16130.519913] in_atomic(): 1, irqs_disabled(): 1, pid: 23, name:
sirq-tasklet/1
[16130.519918] Pid: 23, comm: sirq-tasklet/1 Tainted: P          
2.6.31.12-rt20-rtulmo #35
[16130.519921] Call Trace:
[16130.519926]  [<ffffffff8103d647>] 0xffffffff8103d647
[16130.519930]  [<ffffffff813f4c94>] 0xffffffff813f4c94
[16130.519934]  [<ffffffff810412f0>] 0xffffffff810412f0
[16130.519943]  [<ffffffffa06e7bef>] 0xffffffffa06e7bef
[16130.519946]  [<ffffffffa0600b4f>] 0xffffffffa0600b4f
[16130.519950]  [<ffffffffa0386118>] ? 0xffffffffa0386118
[16130.519954]  [<ffffffffa0573672>] ? 0xffffffffa0573672
[16130.519958]  [<ffffffffa057363e>] ? 0xffffffffa057363e
[16130.519962]  [<ffffffffa04b825a>] ? 0xffffffffa04b825a
[16130.519965]  [<ffffffffa04b7f1e>] ? 0xffffffffa04b7f1e
[16130.519969]  [<ffffffffa0544b15>] ? 0xffffffffa0544b15
[16130.519973]  [<ffffffffa0543fc6>] ? 0xffffffffa0543fc6
[16130.519977]  [<ffffffffa0602bc0>] ? 0xffffffffa0602bc0
[16130.519980]  [<ffffffffa0608853>] ? 0xffffffffa0608853
[16130.519984]  [<ffffffffa06e8e52>] ? 0xffffffffa06e8e52
[16130.519988]  [<ffffffff81051942>] ? 0xffffffff81051942
[16130.519991]  [<ffffffff81051af0>] ? 0xffffffff81051af0
[16130.519995]  [<ffffffff81051637>] ? 0xffffffff81051637
[16130.519998]  [<ffffffff810514cf>] ? 0xffffffff810514cf
[16130.520002]  [<ffffffff810514cf>] ? 0xffffffff810514cf
[16130.520005]  [<ffffffff8106436d>] ? 0xffffffff8106436d
[16130.520009]  [<ffffffff8100ceca>] ? 0xffffffff8100ceca
[16130.520013]  [<ffffffff810642cf>] ? 0xffffffff810642cf
[16130.520017]  [<ffffffff8100cec0>] ? 0xffffffff8100cec0

Here's lsmod:

Module                  Size  Used by
sit                     8668  0
tunnel4                 1880  1 sit
cifs                  198800  2
dahdi_dummy             2072  0
wctdm                  32656  0
wcfxo                   8832  0
wcte11xp               21312  0
wct1xxp                12608  0
wct4xxp               307152  0
dahdi                 187392  8
dahdi_dummy,wctdm,wcfxo,wcte11xp,wct1xxp,wct4xxp
crc_ccitt               1192  1 dahdi
ipv6                  243984  41 sit
iptable_raw             1032  0
xt_state                1144  24
iptable_filter          1256  1
ipt_MASQUERADE          1384  1
xt_tcpudp               2168  56
iptable_nat             3256  1
nf_nat                 13092  2 ipt_MASQUERADE,iptable_nat
nf_conntrack_ipv4       9392  27 iptable_nat,nf_nat
nf_conntrack           47424  5
xt_state,ipt_MASQUERADE,iptable_nat,nf_nat,nf_conntrack_ipv4
nf_defrag_ipv4           936  1 nf_conntrack_ipv4
iptable_mangle          1528  0
ip_tables              13480  4
iptable_raw,iptable_filter,iptable_nat,iptable_mangle
x_tables               12640  5
xt_state,ipt_MASQUERADE,xt_tcpudp,iptable_nat,ip_tables
snd_pcm_oss            30224  0
snd_mixer_oss          12072  1 snd_pcm_oss
snd_seq_oss            22688  0
snd_seq_midi_event      4424  1 snd_seq_oss
snd_seq                40384  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          4348  2 snd_seq_oss,snd_seq
nvidia               8760488  28
snd_hda_codec_realtek   230412  1
snd_hda_intel          17480  0
snd_hda_codec          44872  2 snd_hda_codec_realtek,snd_hda_intel
snd_hwdep               5216  1 snd_hda_codec
snd_pcm                54432  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              15456  2 snd_seq,snd_pcm
snd                    44504  11
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
rtc_cmos                7628  0
uhci_hcd               18240  0
rtc_core               12116  1 rtc_cmos
i2c_i801                7396  0
r8169                  27004  0
soundcore               4272  1 snd
intel_agp              23216  0
pcspkr                  1528  0
snd_page_alloc          5800  2 snd_hda_intel,snd_pcm
i2c_core               14656  2 nvidia,i2c_i801
sg                     21472  0
floppy                 48760  0
rtc_lib                 1608  1 rtc_core
processor              28756  2
button                  3912  0
thermal                11368  0
btrfs                 369904  2
libcrc32c                784  1 btrfs
crc32c                  2424  1
zlib_deflate           17912  1 btrfs
dm_snapshot            18184  8
dm_mirror              11088  13
dm_region_hash          6488  1 dm_mirror
dm_log                  7256  15 dm_mirror,dm_region_hash
sata_nv                19060  0
dm_crypt                9952  3
dm_mod                 53192  298 dm_snapshot,dm_mirror,dm_log,dm_crypt
ohci_hcd               20404  0
ssb                    31240  1 ohci_hcd
pcmcia                 26140  1 ssb
firmware_class          5880  2 wct4xxp,pcmcia
pcmcia_core            24100  2 ssb,pcmcia
usb_storage            38112  0
ehci_hcd               29640  0


