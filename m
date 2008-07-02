From: "Tobias Knutsson" <tobias.knutsson@gmail.com>
Subject: Not so RT Linux
Date: Wed, 2 Jul 2008 10:12:14 +0200
Message-ID: <ccb913ac0807020112w6d135110sdf7a7df76738e0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:17412 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYGBIMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jul 2008 04:12:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so267927wfd.4
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Jul 2008 01:12:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

=46irst of all, this is my first time posting on a mailing list so
forgive me if I get a couple of things wrong.

I am currently doing my master thesis project on the real-time aspects
of the Linux kernel. My first goal is to build a real-time kernel
using the PREEMPT_RT patch. However when comparing the results of a
standard kernel with preemption (CONFIG_PREEMPT) with a kernel using
PREEMPT_RT, the numbers seems to tell me that the PREEMPT_RT kernel
has a worst-case response time way higher then the one using
CONFIG_PREEMPT. The numbers comes from using the cyclictest in the
following manner:

cyclictest -t 1 -p 80 -n -i 10000 -l 10000 -v > some_log_file.log

The tests are run on a Compulab CM-X270 (PXA270 based) board.
Everything is built using OpenEmbedded including the kernel, rootfs,
toolchain and cyclictest. The rootfs is on a JFFS2 partition on a 512
MB NAND flash, and the kernel is stored in a 4 MB NOR flash.


The standard kernel is 2.6.25 using this config:
http://user.it.uu.se/~tokn1493/std_config

Using that kernel I collected this data from cyclictest:
http://user.it.uu.se/~tokn1493/cyclictest-preempt-noload.log


The real-time kernel is 2.6.25.8-rt7 using this config:
http://user.it.uu.se/~tokn1493/rt_config

Using that kernel I collected this data from cyclictest:
http://user.it.uu.se/~tokn1493/cyclictest-preempt_rt-noload.log


I plotted the data for easy viewing:
http://user.it.uu.se/~tokn1493/plot.png


I do not know if it is related, but it might be a clue, after the
kernel has booted I get to the login prompt via the serial connection
(ttyS1). On the monitor however (tty1), the login prompt does not
appear until after I get the following printed to my console (ttyS1):

BUG: sleeping function called from invalid context psplash(799) at
kernel/rtmutex.c:742
in_atomic():0 [00000000], irqs_disabled():128
[<c002b818>] (dump_stack+0x0/0x14) from [<c003c0d8>] (__might_sleep+0xe=
8/0x110)
[<c003bff0>] (__might_sleep+0x0/0x110) from [<c025fbc0>]
(__rt_spin_lock+0x38/0x98)
 r4:c7c17a40
[<c025fb88>] (__rt_spin_lock+0x0/0x98) from [<c025fc30>]
(rt_spin_lock+0x10/0x14)
 r4:c7563b20
[<c025fc20>] (rt_spin_lock+0x0/0x14) from [<c0054c04>] (__queue_work+0x=
20/0x40)
[<c0054be4>] (__queue_work+0x0/0x40) from [<c0054cb4>] (queue_work+0x64=
/0x6c)
 r6:000001e0 r5:00000000 r4:20000013
[<c0054c50>] (queue_work+0x0/0x6c) from [<c0054cd8>] (schedule_work+0x1=
c/0x24)
[<c0054cbc>] (schedule_work+0x0/0x24) from [<c0177084>]
(pxafb_set_par+0x5a0/0x5e8)
[<c0176ae4>] (pxafb_set_par+0x0/0x5e8) from [<c016a4f8>]
(fb_set_var+0x1ac/0x250)
[<c016a34c>] (fb_set_var+0x0/0x250) from [<c0173270>] (fbcon_blank+0x8c=
/0x210)
[<c01731e4>] (fbcon_blank+0x0/0x210) from [<c018a6c4>]
(do_unblank_screen+0xf0/0x180)
[<c018a5d4>] (do_unblank_screen+0x0/0x180) from [<c0181f6c>]
(vt_ioctl+0x48c/0x1ba4)
 r7:00000001 r6:c0355755 r5:00000000 r4:00004b3a
[<c0181ae0>] (vt_ioctl+0x0/0x1ba4) from [<c017d58c>] (tty_ioctl+0xce0/0=
xd9c)
[<c017c8ac>] (tty_ioctl+0x0/0xd9c) from [<c00a4904>] (do_ioctl+0x7c/0x9=
8)
[<c00a4888>] (do_ioctl+0x0/0x98) from [<c00a4bc8>] (vfs_ioctl+0x2a8/0x2=
cc)
 r6:00000000 r5:c76f47a0 r4:c78169c0
[<c00a4920>] (vfs_ioctl+0x0/0x2cc) from [<c00a4c2c>] (sys_ioctl+0x40/0x=
64)
 r9:c7784000 r8:c0027168 r6:00004b3a r5:00000000 r4:00000004
[<c00a4bec>] (sys_ioctl+0x0/0x64) from [<c0026fc0>] (ret_fast_syscall+0=
x0/0x2c)
 r7:00000036 r6:00000004 r5:0001c210 r4:000000cd

=46rom what i understand this is some type of soft deadlock detection,
but I cannot decode meaning of it.

It would be greatly appreciated if someone could give my some pointers
on how to get the worst-case response times down to a decent level. My
guess is that i have missed something in the config but I do not have
the experience to know what it is.

--

H=E4lsningar/Regards
Tobias Knutsson
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
