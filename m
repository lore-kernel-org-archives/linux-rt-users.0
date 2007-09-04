From: Alessio Igor Bogani <abogani@texware.it>
Subject: PowerPC G4
Date: Tue, 04 Sep 2007 09:39:47 +0200
Message-ID: <1188891587.10407.6.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:59207 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbXIDH7x (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 03:59:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 5013F6081E4
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 09:39:51 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id olfhJ-LWsVZk for <linux-rt-users@vger.kernel.org>;
	Tue,  4 Sep 2007 09:39:48 +0200 (CEST)
Received: from [192.168.100.121] (host3-146-static.189-82-b.business.telecomitalia.it [82.189.146.3])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id 10E956081E1
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 09:39:47 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

My friend have a PowerPC G4 with a rt kernel (2.6.22) and during booting
obtain these errors:

[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 512MB; using 1024kB for hash table (at
cff00000)
[    0.000000] Linux version 2.6.22-10-rt (root@midget) (gcc version
4.1.3 20070825 (prerelease) (Ubuntu 4.1.2-15ubuntu3)) #1 PREEMPT RT Fri
Aug 31 14:38:10 EST 2007 (Ubuntu 2.6.22-10.30-powerpc)

[...]

[    0.000000] PowerMac motherboard: Mac mini

[...]

[   36.811281] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12)
initialised: dm-devel@redhat.com
[   37.440173] BUG: scheduling while atomic: udevd/0x00000002/1193,
CPU#0
[   37.440390] Call Trace:
[   37.440393] [c1aafc70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   37.440408] [c1aafca0] [c002d2c8] __schedule_bug+0x38/0x48
[   37.440418] [c1aafcb0] [c0266690] __schedule+0x3d8/0x47c
[   37.440425] [c1aafce0] [c02669f8] schedule+0x54/0xf0
[   37.440430] [c1aafcf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   37.440437] [c1aafd50] [c007b130] lru_cache_add_active+0x20/0xa0
[   37.440444] [c1aafd60] [c0080edc] do_wp_page+0x34c/0xdfc
[   37.440451] [c1aafda0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   37.440458] [c1aafe10] [c02695f4] do_page_fault+0x1e0/0x56c
[   37.440465] [c1aaff40] [c00130f4] handle_page_fault+0xc/0x80
[   37.440476] --- Exception: 301 at 0x10004888
[   37.440483]     LR = 0x10005468

[...]

[   42.751963] kjournald starting.  Commit interval 5 seconds
[   42.751994] EXT3-fs: mounted filesystem with ordered data mode.
[   52.417842] eth0: Link is up at 100 Mbps, full-duplex.
[   52.417853] eth0: Pause is disabled
[   55.236136] BUG: scheduling while atomic: modprobe/0x00000002/3330,
CPU#0
[   55.236370] Call Trace:
[   55.236373] [de7e3c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.236389] [de7e3ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.236399] [de7e3cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.236406] [de7e3ce0] [c02669f8] schedule+0x54/0xf0
[   55.236411] [de7e3cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.236418] [de7e3d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.236425] [de7e3d60] [c0080edc] do_wp_page+0x34c/0xdfc
[   55.236432] [de7e3da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   55.236439] [de7e3e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.236446] [de7e3f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.236457] --- Exception: 301 at 0xfea11e0
[   55.236471]     LR = 0xfea116c
[   55.236509] BUG: scheduling while atomic: modprobe/0x00000002/3332,
CPU#0
[   55.236721] Call Trace:
[   55.236724] [df4c5c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.236731] [df4c5ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.236737] [df4c5cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.236742] [df4c5ce0] [c02669f8] schedule+0x54/0xf0
[   55.236747] [df4c5cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.236753] [df4c5d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.236758] [df4c5d60] [c0080edc] do_wp_page+0x34c/0xdfc
[   55.236763] [df4c5da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   55.236769] [df4c5e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.236775] [df4c5f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.236781] --- Exception: 301 at 0xfea11e0
[   55.236786]     LR = 0xfea116c
[   55.236821] BUG: scheduling while atomic: modprobe/0x00000002/3334,
CPU#0
[   55.237032] Call Trace:
[   55.237034] [deb19c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.237041] [deb19ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.237047] [deb19cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.237052] [deb19ce0] [c02669f8] schedule+0x54/0xf0
[   55.237057] [deb19cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.237062] [deb19d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.237068] [deb19d60] [c0080edc] do_wp_page+0x34c/0xdfc
[   55.237073] [deb19da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   55.237079] [deb19e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.237084] [deb19f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.237090] --- Exception: 301 at 0xfea11e0
[   55.237095]     LR = 0xfea116c
[   55.237129] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3295, CPU#0
[   55.237362] Call Trace:
[   55.237365] [cfd2bc70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.237372] [cfd2bca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.237378] [cfd2bcb0] [c0266690] __schedule+0x3d8/0x47c
[   55.237383] [cfd2bce0] [c02669f8] schedule+0x54/0xf0
[   55.237388] [cfd2bcf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.237394] [cfd2bd50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.237399] [cfd2bd60] [c0080edc] do_wp_page+0x34c/0xdfc
[   55.237405] [cfd2bda0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   55.237410] [cfd2be10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.237416] [cfd2bf40] [c00130f4] handle_page_fault+0xc/0x80
[   55.237422] --- Exception: 301 at 0x30008000
[   55.237427]     LR = 0x30008358
[   55.237465] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3320, CPU#0
[   55.237698] Call Trace:
[   55.237700] [dff37c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.237707] [dff37ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.237713] [dff37cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.237718] [dff37ce0] [c02669f8] schedule+0x54/0xf0
[   55.237723] [dff37cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.237728] [dff37d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.237734] [dff37d60] [c00807bc] do_anonymous_page+0x3e8/0x560
[   55.237739] [dff37da0] [c0085364] __handle_mm_fault+0x79c/0xc9c
[   55.237745] [dff37e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.237751] [dff37f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.237757] --- Exception: 301 at 0x100ad73c
[   55.237761]     LR = 0x100ad6f8
[   55.237817] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3312, CPU#0
[   55.238050] Call Trace:
[   55.238052] [df1f7cb0] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.238061] [df1f7ce0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.238067] [df1f7cf0] [c0266690] __schedule+0x3d8/0x47c
[   55.238072] [df1f7d20] [c02669f8] schedule+0x54/0xf0
[   55.238077] [df1f7d30] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.238083] [df1f7d90] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.238088] [df1f7da0] [c0084e9c] __handle_mm_fault+0x2d4/0xc9c
[   55.238094] [df1f7e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.238100] [df1f7f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.238106] --- Exception: 301 at 0x30019630
[   55.238112]     LR = 0x300083b0
[   55.238135] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3303, CPU#0
[   55.238366] Call Trace:
[   55.238368] [cfca1cb0] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.238375] [cfca1ce0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.238381] [cfca1cf0] [c0266690] __schedule+0x3d8/0x47c
[   55.238386] [cfca1d20] [c02669f8] schedule+0x54/0xf0
[   55.238391] [cfca1d30] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.238397] [cfca1d90] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.238402] [cfca1da0] [c0084e9c] __handle_mm_fault+0x2d4/0xc9c
[   55.238408] [cfca1e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.238413] [cfca1f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.238419] --- Exception: 301 at 0x30019630
[   55.238423]     LR = 0x300083b0
[   55.238435] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3337, CPU#0
[   55.238666] Call Trace:
[   55.238668] [df60bcd0] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.238675] [df60bd00] [c002d2c8] __schedule_bug+0x38/0x48
[   55.238680] [df60bd10] [c0266690] __schedule+0x3d8/0x47c
[   55.238685] [df60bd40] [c02669f8] schedule+0x54/0xf0
[   55.238690] [df60bd50] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.238696] [df60bdb0] [c007ac28] put_page+0x88/0x154
[   55.238701] [df60bdd0] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   55.238710] [df60bde0] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   55.238715] [df60be70] [c00877e4] exit_mmap+0x78/0x10c
[   55.238721] [df60bea0] [c00301a4] mmput+0x54/0xf4
[   55.238728] [df60bec0] [c0034884] exit_mm+0xc0/0x124
[   55.238736] [df60bee0] [c00362dc] do_exit+0x174/0x8c8
[   55.238741] [df60bf20] [c0036a68] do_group_exit+0x38/0x84
[   55.238746] [df60bf40] [c0012cc8] ret_from_syscall+0x0/0x38
[   55.238752] --- Exception: c01 at 0xfe95fe8
[   55.238756]     LR = 0xfe95fb8
[   55.238849] BUG: scheduling while atomic: modprobe/0x00000002/3330,
CPU#0
[   55.239060] Call Trace:
[   55.239062] [de7e3c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.239070] [de7e3ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.239076] [de7e3cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.239082] [de7e3ce0] [c02669f8] schedule+0x54/0xf0
[   55.239087] [de7e3cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.239092] [de7e3d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.239098] [de7e3d60] [c00807bc] do_anonymous_page+0x3e8/0x560
[   55.239104] [de7e3da0] [c0085364] __handle_mm_fault+0x79c/0xc9c
[   55.239110] [de7e3e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.239116] [de7e3f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.239122] --- Exception: 301 at 0xff485b0
[   55.239127]     LR = 0xff4857c
[   55.239191] BUG: scheduling while atomic: modprobe/0x00000002/3332,
CPU#0
[   55.239636] Call Trace:
[   55.239639] [df4c5c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.239646] [df4c5ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.239652] [df4c5cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.239657] [df4c5ce0] [c02669f8] schedule+0x54/0xf0
[   55.239662] [df4c5cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.239668] [df4c5d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.239673] [df4c5d60] [c00807bc] do_anonymous_page+0x3e8/0x560
[   55.239679] [df4c5da0] [c0085364] __handle_mm_fault+0x79c/0xc9c
[   55.239685] [df4c5e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.239691] [df4c5f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.239697] --- Exception: 301 at 0xff485b0
[   55.239702]     LR = 0xff4857c
[   55.239768] BUG: scheduling while atomic: modprobe/0x00000002/3334,
CPU#0
[   55.240211] Call Trace:
[   55.240214] [deb19c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.240222] [deb19ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.240228] [deb19cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.240233] [deb19ce0] [c02669f8] schedule+0x54/0xf0
[   55.240238] [deb19cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.240243] [deb19d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.240249] [deb19d60] [c00807bc] do_anonymous_page+0x3e8/0x560
[   55.240255] [deb19da0] [c0085364] __handle_mm_fault+0x79c/0xc9c
[   55.240261] [deb19e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.240266] [deb19f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.240272] --- Exception: 301 at 0xff485b0
[   55.240277]     LR = 0xff4857c
[   55.240517] BUG: scheduling while atomic:
check-ptp-camer/0x00000002/3320, CPU#0
[   55.241218] Call Trace:
[   55.241221] [dff37c70] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   55.241230] [dff37ca0] [c002d2c8] __schedule_bug+0x38/0x48
[   55.241236] [dff37cb0] [c0266690] __schedule+0x3d8/0x47c
[   55.241242] [dff37ce0] [c02669f8] schedule+0x54/0xf0
[   55.241247] [dff37cf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   55.241253] [dff37d50] [c007b130] lru_cache_add_active+0x20/0xa0
[   55.241258] [dff37d60] [c0080edc] do_wp_page+0x34c/0xdfc
[   55.241265] [dff37da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   55.241271] [dff37e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   55.241276] [dff37f40] [c00130f4] handle_page_fault+0xc/0x80
[   55.241284] --- Exception: 301 at 0xfe740f0
[   55.241290]     LR = 0xfe7408c
[   56.047511] NET: Registered protocol family 17
[   57.038393] Linux agpgart interface v0.102 (c) Dave Jones
[   57.157631] agpgart: Detected Apple UniNorth 2 chipset
[   57.157786] agpgart: configuring for size idx: 8
[   57.157844] agpgart: AGP aperture is 32M @ 0x0
[   57.355922] ieee80211_crypt: registered algorithm 'NULL'
[   57.455714] ieee80211: 802.11 data/management/control stack,
git-1.1.13
[   57.455724] ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
[   57.924968] BUG: scheduling while atomic: modprobe/0x00000002/3448,
CPU#0
[   57.925436] Call Trace:
[   57.925439] [cfcffcb0] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   57.925455] [cfcffce0] [c002d2c8] __schedule_bug+0x38/0x48
[   57.925464] [cfcffcf0] [c0266690] __schedule+0x3d8/0x47c
[   57.925472] [cfcffd20] [c02669f8] schedule+0x54/0xf0
[   57.925477] [cfcffd30] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   57.925484] [cfcffd90] [c0076738] get_zone_pcp+0x2c/0x58
[   57.925495] [cfcffdb0] [c0076e14] free_hot_cold_page+0x104/0x204
[   57.925501] [cfcffde0] [c007abf0] put_page+0x50/0x154
[   57.925507] [cfcffe00] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   57.925518] [cfcffe10] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   57.925524] [cfcffea0] [c0087668] unmap_region+0xac/0x140
[   57.925530] [cfcffee0] [c0088328] do_munmap+0x17c/0x234
[   57.925535] [cfcfff20] [c008841c] sys_munmap+0x3c/0x60
[   57.925541] [cfcfff40] [c0012cc8] ret_from_syscall+0x0/0x38
[   57.925552] --- Exception: c01 at 0xff609b4
[   57.925567]     LR = 0xfefca28
[   57.943516] bcm43xx driver
[   58.040121] PCI: Enabling device 0001:10:12.0 (0004 -> 0006)
[   60.162627] pmac_zilog: 0.6 (Benjamin Herrenschmidt
<benh@kernel.crashing.org>)
[   60.162737] ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC -
Serial port
[   60.165854] ttyS1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC -
Serial port
[   60.495390] snd-aoa-fabric-layout: found bus with layout 58
[   60.495401] snd-aoa-fabric-layout: Using direct GPIOs
[   60.513181] snd-aoa-fabric-layout: can use this codec
[   61.331923] apm_emu: PMU APM Emulation initialized.
[   61.421748] SCSI subsystem initialized
[   61.501805] fuse init (API version 7.8)
[   61.719287] BUG: scheduling while atomic: sleep/0x00000002/3855,
CPU#0
[   61.719750] Call Trace:
[   61.719753] [df5c1c80] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   61.719769] [df5c1cb0] [c002d2c8] __schedule_bug+0x38/0x48
[   61.719779] [df5c1cc0] [c0266690] __schedule+0x3d8/0x47c
[   61.719786] [df5c1cf0] [c02669f8] schedule+0x54/0xf0
[   61.719791] [df5c1d00] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   61.719798] [df5c1d60] [c0076738] get_zone_pcp+0x2c/0x58
[   61.719809] [df5c1d80] [c0076e14] free_hot_cold_page+0x104/0x204
[   61.719816] [df5c1db0] [c007abf0] put_page+0x50/0x154
[   61.719821] [df5c1dd0] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   61.719833] [df5c1de0] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   61.719838] [df5c1e70] [c00877e4] exit_mmap+0x78/0x10c
[   61.719844] [df5c1ea0] [c00301a4] mmput+0x54/0xf4
[   61.719851] [df5c1ec0] [c0034884] exit_mm+0xc0/0x124
[   61.719859] [df5c1ee0] [c00362dc] do_exit+0x174/0x8c8
[   61.719864] [df5c1f20] [c0036a68] do_group_exit+0x38/0x84
[   61.719869] [df5c1f40] [c0012cc8] ret_from_syscall+0x0/0x38
[   61.719880] --- Exception: c01 at 0xff2bfe8
[   61.719908]     LR = 0xff2bfb8
[   61.751033] Adding 999992k swap on /dev/hda4.  Priority:-1 extents:1
across:999992k
[   62.229503] EXT3 FS on hda5, internal journal
[   63.062412] kjournald starting.  Commit interval 5 seconds
[   63.062568] EXT3 FS on hda6, internal journal
[   63.062577] EXT3-fs: mounted filesystem with ordered data mode.
[   65.255226] BUG: scheduling while atomic: ntpdate/0x00000002/4341,
CPU#0
[   65.255902] Call Trace:
[   65.255906] [df23dc40] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   65.255921] [df23dc70] [c002d2c8] __schedule_bug+0x38/0x48
[   65.255931] [df23dc80] [c0266690] __schedule+0x3d8/0x47c
[   65.255939] [df23dcb0] [c02669f8] schedule+0x54/0xf0
[   65.255944] [df23dcc0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   65.255950] [df23dd20] [c007a7d0] __pagevec_lru_add_active+0x7c/0x12c
[   65.255957] [df23dd50] [c007b18c] lru_cache_add_active+0x7c/0xa0
[   65.255963] [df23dd60] [c00807bc] do_anonymous_page+0x3e8/0x560
[   65.255970] [df23dda0] [c0085364] __handle_mm_fault+0x79c/0xc9c
[   65.255977] [df23de10] [c02695f4] do_page_fault+0x1e0/0x56c
[   65.255984] [df23df40] [c00130f4] handle_page_fault+0xc/0x80
[   65.255995] --- Exception: 301 at 0x30008fac
[   65.256025]     LR = 0x30008f64
[   65.577536] NET: Registered protocol family 10
[   65.577655] lo: Disabled Privacy Extensions
[   67.320563] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4480, CPU#0
[   67.320572] Call Trace:
[   67.320575] [dd831c10] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.320591] [dd831c40] [c002d2c8] __schedule_bug+0x38/0x48
[   67.320601] [dd831c50] [c0266690] __schedule+0x3d8/0x47c
[   67.320608] [dd831c80] [c02669f8] schedule+0x54/0xf0
[   67.320613] [dd831c90] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.320620] [dd831cf0] [c0076738] get_zone_pcp+0x2c/0x58
[   67.320631] [dd831d10] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.320637] [dd831d40] [c007abf0] put_page+0x50/0x154
[   67.320643] [dd831d60] [c0080f0c] do_wp_page+0x37c/0xdfc
[   67.320651] [dd831da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   67.320657] [dd831e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   67.320664] [dd831f40] [c00130f4] handle_page_fault+0xc/0x80
[   67.320676] --- Exception: 301 at 0xff2beb0
[   67.320706]     LR = 0xff2bcf4
[   67.321239] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4480, CPU#0
[   67.321244] Call Trace:
[   67.321246] [dd831c10] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.321258] [dd831c40] [c002d2c8] __schedule_bug+0x38/0x48
[   67.321264] [dd831c50] [c0266690] __schedule+0x3d8/0x47c
[   67.321270] [dd831c80] [c02669f8] schedule+0x54/0xf0
[   67.321276] [dd831c90] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.321282] [dd831cf0] [c0076738] get_zone_pcp+0x2c/0x58
[   67.321289] [dd831d10] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.321295] [dd831d40] [c007abf0] put_page+0x50/0x154
[   67.321300] [dd831d60] [c0080f0c] do_wp_page+0x37c/0xdfc
[   67.321307] [dd831da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   67.321313] [dd831e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   67.321319] [dd831f40] [c00130f4] handle_page_fault+0xc/0x80
[   67.321327] --- Exception: 301 at 0xfefca70
[   67.321340]     LR = 0xff2beb8
[   67.322045] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4480, CPU#0
[   67.322050] Call Trace:
[   67.322053] [dd831c10] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.322063] [dd831c40] [c002d2c8] __schedule_bug+0x38/0x48
[   67.322070] [dd831c50] [c0266690] __schedule+0x3d8/0x47c
[   67.322077] [dd831c80] [c02669f8] schedule+0x54/0xf0
[   67.322082] [dd831c90] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.322088] [dd831cf0] [c0076738] get_zone_pcp+0x2c/0x58
[   67.322096] [dd831d10] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.322102] [dd831d40] [c007abf0] put_page+0x50/0x154
[   67.322107] [dd831d60] [c0080f0c] do_wp_page+0x37c/0xdfc
[   67.322113] [dd831da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   67.322119] [dd831e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   67.322125] [dd831f40] [c00130f4] handle_page_fault+0xc/0x80
[   67.322132] --- Exception: 301 at 0xfeff6cc
[   67.322146]     LR = 0xff2bf14
[   67.322600] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4482, CPU#0
[   67.322605] Call Trace:
[   67.322608] [ddf43c10] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.322618] [ddf43c40] [c002d2c8] __schedule_bug+0x38/0x48
[   67.322625] [ddf43c50] [c0266690] __schedule+0x3d8/0x47c
[   67.322631] [ddf43c80] [c02669f8] schedule+0x54/0xf0
[   67.322636] [ddf43c90] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.322642] [ddf43cf0] [c0076738] get_zone_pcp+0x2c/0x58
[   67.322649] [ddf43d10] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.322655] [ddf43d40] [c007abf0] put_page+0x50/0x154
[   67.322660] [ddf43d60] [c0080f0c] do_wp_page+0x37c/0xdfc
[   67.322666] [ddf43da0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
[   67.322672] [ddf43e10] [c02695f4] do_page_fault+0x1e0/0x56c
[   67.322678] [ddf43f40] [c00130f4] handle_page_fault+0xc/0x80
[   67.322686] --- Exception: 301 at 0x10009e80
[   67.322698]     LR = 0x10009e70
[   67.323852] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4482, CPU#0
[   67.323859] Call Trace:
[   67.323861] [ddf43b80] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.323875] [ddf43bb0] [c002d2c8] __schedule_bug+0x38/0x48
[   67.323883] [ddf43bc0] [c0266690] __schedule+0x3d8/0x47c
[   67.323889] [ddf43bf0] [c02669f8] schedule+0x54/0xf0
[   67.323894] [ddf43c00] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.323900] [ddf43c60] [c0076738] get_zone_pcp+0x2c/0x58
[   67.323909] [ddf43c80] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.323915] [ddf43cb0] [c007abf0] put_page+0x50/0x154
[   67.323920] [ddf43cd0] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   67.323930] [ddf43ce0] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   67.323936] [ddf43d70] [c00877e4] exit_mmap+0x78/0x10c
[   67.323942] [ddf43da0] [c00301a4] mmput+0x54/0xf4
[   67.323949] [ddf43dc0] [c00a25cc] flush_old_exec+0x214/0x820
[   67.323955] [ddf43e20] [c00d76c4] load_elf_binary+0x2bc/0x148c
[   67.323964] [ddf43eb0] [c00a1d14] search_binary_handler+0xf4/0x2e0
[   67.323970] [ddf43ef0] [c00a3470] do_execve+0x218/0x248
[   67.323975] [ddf43f20] [c0008d84] sys_execve+0x58/0xa8
[   67.323981] [ddf43f40] [c0012cc8] ret_from_syscall+0x0/0x38
[   67.323990] --- Exception: c01 at 0xff2c088
[   67.324009]     LR = 0x10005df4
[   67.324869] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4482, CPU#0
[   67.324874] Call Trace:
[   67.324877] [ddf43b80] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.324888] [ddf43bb0] [c002d2c8] __schedule_bug+0x38/0x48
[   67.324895] [ddf43bc0] [c0266690] __schedule+0x3d8/0x47c
[   67.324901] [ddf43bf0] [c02669f8] schedule+0x54/0xf0
[   67.324906] [ddf43c00] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.324912] [ddf43c60] [c0076738] get_zone_pcp+0x2c/0x58
[   67.324920] [ddf43c80] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.324926] [ddf43cb0] [c007abf0] put_page+0x50/0x154
[   67.324931] [ddf43cd0] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   67.324940] [ddf43ce0] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   67.324945] [ddf43d70] [c00877e4] exit_mmap+0x78/0x10c
[   67.324951] [ddf43da0] [c00301a4] mmput+0x54/0xf4
[   67.324957] [ddf43dc0] [c00a25cc] flush_old_exec+0x214/0x820
[   67.324963] [ddf43e20] [c00d76c4] load_elf_binary+0x2bc/0x148c
[   67.324970] [ddf43eb0] [c00a1d14] search_binary_handler+0xf4/0x2e0
[   67.324975] [ddf43ef0] [c00a3470] do_execve+0x218/0x248
[   67.324981] [ddf43f20] [c0008d84] sys_execve+0x58/0xa8
[   67.324986] [ddf43f40] [c0012cc8] ret_from_syscall+0x0/0x38
[   67.324994] --- Exception: c01 at 0xff2c088
[   67.325009]     LR = 0x10005df4
[   67.325073] BUG: scheduling while atomic:
S10powernowd.ea/0x00000002/4482, CPU#0
[   67.325076] Call Trace:
[   67.325079] [ddf43b80] [c000864c] show_stack+0x3c/0x194 (unreliable)
[   67.325086] [ddf43bb0] [c002d2c8] __schedule_bug+0x38/0x48
[   67.325092] [ddf43bc0] [c0266690] __schedule+0x3d8/0x47c
[   67.325097] [ddf43bf0] [c02669f8] schedule+0x54/0xf0
[   67.325102] [ddf43c00] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
[   67.325108] [ddf43c60] [c0076738] get_zone_pcp+0x2c/0x58
[   67.325114] [ddf43c80] [c0076e14] free_hot_cold_page+0x104/0x204
[   67.325120] [ddf43cb0] [c007abf0] put_page+0x50/0x154
[   67.325125] [ddf43cd0] [c008e6c4] free_page_and_swap_cache+0x44/0x80
[   67.325133] [ddf43ce0] [c00825e4] unmap_vmas+0x2ac/0x6f0
[   67.325139] [ddf43d70] [c00877e4] exit_mmap+0x78/0x10c
[   67.325144] [ddf43da0] [c00301a4] mmput+0x54/0xf4
[   67.325150] [ddf43dc0] [c00a25cc] flush_old_exec+0x214/0x820
[   67.325155] [ddf43e20] [c00d76c4] load_elf_binary+0x2bc/0x148c
[   67.325161] [ddf43eb0] [c00a1d14] search_binary_handler+0xf4/0x2e0
[   67.325166] [ddf43ef0] [c00a3470] do_execve+0x218/0x248
[   67.325171] [ddf43f20] [c0008d84] sys_execve+0x58/0xa8
[   67.325177] [ddf43f40] [c0012cc8] ret_from_syscall+0x0/0x38
[   67.325183] --- Exception: c01 at 0xff2c088
[   67.325191]     LR = 0x10005df4

Do you have a some suggestions?

Thanks in advance.

Ciao,
Alessio
