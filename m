From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: 1 of 23 peformance problems at 30 to 40 percent system load
Date: Fri, 17 Jul 2015 22:05:54 +0200
Message-ID: <CA+Owze7RC95-OD+bQi_M0zAJRke+WVf1t4nL+PF-k5iPg0gS7g@mail.gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33816 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbGQUFy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jul 2015 16:05:54 -0400
Received: by ykax123 with SMTP id x123so98346709yka.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2015 13:05:54 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

My name is Jo=C3=ABl Kr=C3=A4hemann, I'm developing:

http://gsequencer.org

and I'm using:

Linux debian 4.0.5 #1 SMP PREEMPT Sat Jul 11 16:32:49 CEST 2015 x86_64 =
GNU/Linux

=46or now I encounter on my system performance problems at a load of 30
to 40 % system load, all 8 virtual cpu's have same average load.

* `chrt` to higher priority doesn't give wished throughput.
* `taskset` has ff as default.
* `cpufreq-set -g performance` brings a little improvement for first se=
conds

This is my CPU:

Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 58
Model name:            Intel(R) Core(TM) i7-3740QM CPU @ 2.70GHz
Stepping:              9
CPU MHz:               3275.648
CPU max MHz:           3700.0000
CPU min MHz:           1200.0000
BogoMIPS:              5387.58
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              6144K
NUMA node0 CPU(s):     0-7


GSequencer uses many threads but doesn't stay in realtime. What am I
doing wrong? Or how to gain more Performance out of the system?

I could imagine on my code side that vary frequency segmentation would
bring better throughput. By modeifing AGS_THREAD_DEFAULT_JIFFIE,
AGS_THREAD_MAX_PRECISION and related.

But for now I search for documentation about linux kernel performance c=
ounters.

Best regards,
Jo=C3=ABl Kr=C3=A4hemann
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
