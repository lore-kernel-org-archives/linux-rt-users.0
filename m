From: Robert Barrows <Robert.Barrows@metriainnovation.com>
Subject: Problems with X crashing
Date: Thu, 14 Feb 2013 10:30:07 -0600
Message-ID: <CAOHJ0jQVzhk83whMa6k6MWoAoifRKuj-a6foDgcE8DZT+DtZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ct23.fastbighost.net ([194.28.84.96]:43164 "EHLO
	ct23.fastbighost.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758482Ab3BNSTq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Feb 2013 13:19:46 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52291)
	by ct23.fastbighost.net with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.80)
	(envelope-from <Robert.Barrows@metriainnovation.com>)
	id 1U61ha-0007RR-9h
	for linux-rt-users@vger.kernel.org; Thu, 14 Feb 2013 16:30:26 +0000
Received: by mail-ie0-f172.google.com with SMTP id c10so3529885ieb.31
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Feb 2013 08:30:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  I have been using the the 3.2.12-rt22 kernel since it was released.  I have
recently had the need to turn my kernel installations into RPMs and figured it
would be a good time to upgrade.  Given that the 3rd number in the kernel
is only supposed to indicate bug/security fixes I figured 3.2.38-rt56 would be
no problem.
  I used my .config from 3.2.12-rt22 to build 3.2.38-rt56 (I also tried rt57)
and while everything works fine at fist blush, X eventually freezes. The
3.2.12-rt22 kernel has no problems on this machine.
  I was hoping someone could point me in the correct direction to fix/diagnose
this issue. Included is the tail of my /var/log/Xorg.0.log. The backtrace is
coincident with the freezing, ans seems to originate in evdev_drv.so.

Thanks for any help.

-Robb

[    10.448] (II) intel(0): Modeline "640x480"x0.0   25.18  640 656
752 800  480 490 492 525 -hsync -vsync (31.5 kHz)
[    10.448] (II) intel(0): Modeline "720x400"x0.0   28.32  720 738
846 900  400 412 414 449 -hsync +vsync (31.5 kHz)
[    10.448] (II) intel(0): Modeline "1024x768"x0.0   75.00  1024 1048
1184 1328  768 771 777 806 -hsync -vsync (56.5 kHz)
[    10.448] (II) intel(0): Modeline "1024x768"x0.0   65.00  1024 1048
1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz)
[    10.448] (II) intel(0): Modeline "1152x864"x0.0  108.00  1152 1216
1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz)
[    10.448] (II) intel(0): Modeline "1280x800"x0.0   83.50  1280 1352
1480 1680  800 803 809 831 -hsync +vsync (49.7 kHz)
[    10.448] (II) intel(0): Modeline "1280x1024"x0.0  108.00  1280
1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz)
[    10.448] (II) intel(0): Modeline "1440x900"x0.0  106.50  1440 1520
1672 1904  900 903 909 934 -hsync +vsync (55.9 kHz)
[    10.448] (II) intel(0): Modeline "1680x1050"x0.0  146.25  1680
1784 1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz)
[    10.448] (II) intel(0): Modeline "1920x1080"x60.0  172.80  1920
2040 2248 2576  1080 1081 1084 1118 -hsync +vsync (67.1 kHz)
[   272.184] [mi] EQ overflowing. The server is probably stuck in an
infinite loop.
[   272.184]
Backtrace:
[   272.184] 0: /usr/bin/Xorg (xorg_backtrace+0x2f) [0x462e8f]
[   272.184] 1: /usr/bin/Xorg (mieqEnqueue+0x17d) [0x557aed]
[   272.184] 2: /usr/bin/Xorg (0x400000+0x46e73) [0x446e73]
[   272.184] 3: /usr/lib64/xorg/modules/input/evdev_drv.so
(0x7f1b5720b000+0x54f9) [0x7f1b572104f9]
[   272.184] 4: /usr/bin/Xorg (0x400000+0x7f618) [0x47f618]
[   272.184] 5: /usr/bin/Xorg (0x400000+0xa4e4b) [0x4a4e4b]
[   272.184] 6: /lib64/libpthread.so.0 (0x3fee800000+0xf500) [0x3fee80f500]
[   272.184] 7: /lib64/libc.so.6 (ioctl+0x7) [0x3fee4e9f27]
[   272.184] 8: /usr/lib64/libdrm.so.2 (drmIoctl+0x28) [0x300a2034b8]
[   272.184] 9: /usr/lib64/libdrm_intel.so.1 (0x7f1b58a93000+0x7dd9)
[0x7f1b58a9add9]
[   272.184] 10: /usr/lib64/xorg/modules/drivers/intel_drv.so
(0x7f1b58cb0000+0xf840) [0x7f1b58cbf840]
[   272.184] 11: /usr/bin/Xorg (_CallCallbacks+0x3c) [0x43835c]
[   272.184] 12: /usr/bin/Xorg (FlushAllOutput+0x2e) [0x46675e]
[   272.184] 13: /usr/bin/Xorg (0x400000+0x33a06) [0x433a06]
[   272.184] 14: /usr/bin/Xorg (0x400000+0x22ea5) [0x422ea5]
[   272.184] 15: /lib64/libc.so.6 (__libc_start_main+0xed) [0x3fee42169d]
[   272.184] 16: /usr/bin/Xorg (0x400000+0x23191) [0x423191]
                                                                               ^
