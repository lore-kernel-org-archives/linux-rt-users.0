From: "Paul-Ehrlich@gmx.de" <Paul-Ehrlich@gmx.de>
Subject: Realtime System only works after running cyclictest with -b option
Date: Thu, 01 Aug 2013 19:34:31 +0200
Message-ID: <51FA9C27.7050409@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:55398 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab3HARee (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Aug 2013 13:34:34 -0400
Received: from [192.168.0.100] ([146.52.2.203]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MB1C4-1UxHG02ykW-00A27q for
 <linux-rt-users@vger.kernel.org>; Thu, 01 Aug 2013 19:34:32 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello linux-rt-users,
I have a question concerning RT-Patch, which shows strange behavior=20
discoverd using cyclictest. I have an embedded system with patched RT.=20
The max latency of the cyclictest isn=92t as low as expected and my onl=
y=20
application hangs to, so I included tracing abilities to the kernel to=20
use the =93-b=94 switch of cyclictest. But the kernel behaves different=
 if=20
switched on (detailed below)? Maybe you can give me a hint what the=20
cyclictest does when using the =96b switch. It somehow persists after t=
he=20
option is used once and my own application runs fine afterwards too. So=
=20
in order to run my application right now I have to run cyclictest with=20
the -b option after each reboot.
Many Thanks in Advance
Paul Ehrlich


=46irst test run after boot - showing huge latencies:
linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
10000 -a 1
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.74 0.34 0.13 1/144 1966
T: 0 ( 1966) P:80 I:250 C: 10000 Min: 18 Act: 27 Avg: 36 Max: 1590

Secound test run after boot - just to make sure:
linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
10000 -a 1
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.93 0.30 0.10 1/142 1948
T: 0 ( 1948) P:80 I:250 C: 10000 Min: 18 Act: 46 Avg: 38 Max: 3639

Third test run after boot now using -b option - result looks ok for the=
=20
system:
linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
10000 -a 1 -b 1000
# /dev/cpu_dma_latency set to 0us
INFO: debugfs mountpoint: /sys/kernel/debug/tracing/
policy: fifo: loadavg: 0.51 0.32 0.13 1/144 1979
T: 0 ( 1979) P:80 I:250 C: 10000 Min: 85 Act: 101 Avg: 114 Max: 179

=46ourth run after boot - now without -b even faster?:
# Thread Ids: 01979
linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
10000 -a 1
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.66 0.38 0.16 1/157 2283
T: 0 ( 2279) P:80 I:250 C: 10000 Min: 6 Act: 27 Avg: 27 Max: 51
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
