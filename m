From: "t-v.k@gmx.net" <t-v.k@gmx.net>
Subject: Building the Raspberry Pi kernel with RT PREEMPT
Date: Wed, 7 Feb 2018 00:02:52 +0100
Message-ID: <e5469b0b-fc0e-95b1-0a80-69a6afab3f12@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:50613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753711AbeBFXCy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 18:02:54 -0500
Received: from localhost.localdomain ([77.7.131.240]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MGB7j-1eWlnn3Rn5-00FC0l for <linux-rt-users@vger.kernel.org>; Wed, 07 Feb
 2018 00:02:52 +0100
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

this is my first time on a mailing list. I'm not sure how this works.
The FAQ linked on this page:
https://wiki.linuxfoundation.org/realtime/communication/mailinglists
just says "Page not found". I hope I can just ask a question this way.

I'm currently trying to automate the build of a Linux kernel with the RT
PREEMPT patch. The kernel that I'm trying to build is in this git
repository: https://github.com/raspberrypi/linux (branch rpi-4.14.y)

It's the official kernel for the Raspberry Pi.

But at the moment I am stuck. There are two problems. When I apply the
patch "patch-4.14.15-rt13.patch.gz", I get errors like:

Hunk #9 FAILED at 795.
...
1 out of 20 hunks FAILED -- saving rejects to file kernel/softirq.c.rej
...

and as a result of this it exits with code 1.

Here is the full build process output:
https://gitlab.com/T-vK/rpi-rt-kernel/-/jobs/51343435

When I just ignore it and continue I get to the point where I can run
"make zImage", which then fails with this:

kernel/softirq.c: In function 'invoke_softirq':
kernel/softirq.c:801:3: error: implicit declaration of function
'do_softirq_own_stack' [-Werror=implicit-function-declaration]
   do_softirq_own_stack();
   ^
kernel/softirq.c:806:2: error: #else without #if
 #else /* PREEMPT_RT_FULL */
  ^
kernel/softirq.c:807:2: warning: ISO C90 forbids mixed declarations and
code [-Wdeclaration-after-statement]
  unsigned long flags;
  ^
kernel/softirq.c:817:2: error: #endif without #if
 #endif
  ^
cc1: some warnings being treated as errors
scripts/Makefile.build:320: recipe for target 'kernel/softirq.o' failed
make[1]: *** [kernel/softirq.o] Error 1
Makefile:1028: recipe for target 'kernel' failed
make: *** [kernel] Error 2


The full log is in the build output linked above.
I've been trying to follow this guide: http://www.frank-durr.de/?p=203
This is my "build script" if you will:
https://gitlab.com/T-vK/rpi-rt-kernel/blob/master/.gitlab-ci.yml
The docker image it runs on has been build from this file:
https://gitlab.com/T-vK/rpi-rt-kernel/blob/master/Dockerfile

I should mention, the patch that I apply right before "make zImage"
(patch < rt-config.patch) simply applies this menuconfig setting:

Kernel Features → Preemption Model (Fully Preemptible Kernel (RT)) →
Fully Preemptible Kernel (RT)

(I just created the default config for rpi-4.14.y using "make
bcm2709_defconfig" and then copied it and modified the above mentioned
option using "make menuconfig" and then I just ran a "diff -u ..." on it
to create the patch)

Can anyone help me with these issues?


Best regards
T-vK
