From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Wed, 17 Aug 2011 11:54:46 -0500
Message-ID: <CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com>
	<CAFQPvXfAhvw+TGmHC910ObkAmt2ZE_QsyGxWWAByzvVYf3+R+g@mail.gmail.com>
	<4E4AB90E.10805@am.sony.com>
	<4E4ACD2D.80802@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec548a8e98f0bea04aab65acb
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63618 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1HQQyr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2011 12:54:47 -0400
Received: by vxi9 with SMTP id 9so1015632vxi.19
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Aug 2011 09:54:47 -0700 (PDT)
In-Reply-To: <4E4ACD2D.80802@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--bcaec548a8e98f0bea04aab65acb
Content-Type: text/plain; charset=ISO-8859-1

>On Tue, Aug 16, 2011 at 3:03 PM, Frank Rowand <frank.rowand@am.sony.com> wrote:
> On 08/16/11 11:38, Frank Rowand wrote:
>> SMP Panda is booting fine for me on a slightly older version: 3.0.0-rt6
>>
>> gcc 4.3.3
>>
>> Config is attached.
>>
>> I used make omap2plus_defconfig then tweaked a few items:

> And 3.0.1-rt11 also boots SMP CONFIG_PREEMPT_RT_FULL on panda board for
> me, with the same recipe I gave for 3.0.0-rt6.

Thanks Frank. I first tried your suggestion of "make
omap2plus_defconfig" with additional config options to enable USB
ethernet with rt8 patch but could not get SMP kernel to boot. Then, I
applied rt11 patch and used the exact same .config file that you had
posted in this thread and the SMP kernel is booting fine now. I have
applied the following high-resolution timer patch that is posted in
the OMAP mailing list:

************ PATCH START **************
diff -rupN a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
--- a/arch/arm/mach-omap2/timer-gp.c	2011-06-06 10:42:45.964924603 -0500
+++ b/arch/arm/mach-omap2/timer-gp.c	2011-06-06 10:44:03.725422077 -0500
@@ -230,6 +230,12 @@ static void __init omap2_gp_clocksource_
 	static char err2[] __initdata = KERN_ERR
 		"%s: can't register clocksource!\n";

+	char clocksource_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
+
+	/* XXX: This may not be always true, we might get different timer */
+	sprintf(clocksource_hwmod_name, "timer%d", gptimer_id + 1);
+	omap_hwmod_setup_one(clocksource_hwmod_name);
+
 	gpt = omap_dm_timer_request();
 	if (!gpt)
 		printk(err1, clocksource_gpt.name);
************ PATCH END **************
The cyclic test results are not acceptable (attached the output of
cyclictest). I am seeing maximum latency of 757 us on core-0 and 1905
us on core-1. Are you (Is anyone) seeing better results on latency
with SMP kernel with RT patch on ARM (OMAP4 processors)? I have seen
~25 us of latency with single core kernel (though I have used a
different kernel configuration).

PS: The kernels that I build especially with RT patch don't boot the
first time on the panda board. Sometimes, it takes 2 or 3 resets and
sometimes 10 to 15 times. When it hangs, it always hangs right after
"Uncompressing Linux... done, booting the kernel." It looks like it is
probably due to some race conditions in kernel during initial boot. I
am hoping it is not a hardware issue. Has anyone else been
experiencing flakiness and early hangs on panda board? I am using code
sourcery toolchain (Sourcery G++ Lite 2010.09-50 for ARM GNU/Linux )
to build the kernel. The Linux kernels at some point in the past month
or so that I built with the latest code sourcery toolchain (Sourcery
G++ Lite 2011.03-41 for ARM GNU/Linux) did not boot. That said, it is
hard to blame the toolchain, because of the flakiness in booting the
same kernel image (boots fine after 15 resets).

Thanks,
Sankara Muthukrishnan

--bcaec548a8e98f0bea04aab65acb
Content-Type: application/octet-stream; name="cyclicTestSMP.log"
Content-Disposition: attachment; filename="cyclicTestSMP.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grgj16p30

My4wLjEtcnQxMS1kaXJ0eSAjMTMgU01QIFBSRUVNUFQgUlQgVHVlIEF1ZyAxNiAxNjo0NzozMSBD
RFQgMjAxMQouL2N5Y2xpY3Rlc3QgLWwxMDAwMDAwMCAtbSAtU3A5OSAtaTIwMCAtaDYwIC1xIC1u
CiMgSGlzdG9ncmFtCjAwMDAwMCAwMDAwMDAJMDAwMDAwCjAwMDAwMSAwMDAwMDAJMDAwMDAwCjAw
MDAwMiAwMDAwMDAJMDAwMDAwCjAwMDAwMyAwMDAwMDAJMDAwMDAwCjAwMDAwNCAwMDAwMDAJMDAw
MDAwCjAwMDAwNSAwMDAwMDAJMDAwMDAwCjAwMDAwNiAwMDAwMDAJMDAwMDAwCjAwMDAwNyAwMDAw
MDAJMDAwMDAwCjAwMDAwOCAwMDAwMDAJMDAwMDAwCjAwMDAwOSAwMDAwMDAJMDAwMDAwCjAwMDAx
MCAwMDAwMDAJMDAwMDAxCjAwMDAxMSAwMDAwMDAJMDAwMDAxCjAwMDAxMiAwMDAwMDIJMDAwMDAy
CjAwMDAxMyA1ODE2MjIJNDAyNzgyCjAwMDAxNCA4ODU1MTYyCTkyNjM2MTMKMDAwMDE1IDM5NjM5
MQkyNjkyNTIKMDAwMDE2IDA5Njc3NgkwMzMyMjcKMDAwMDE3IDAwMTMzMQkwMDQ1MDIKMDAwMDE4
IDAwMDYyOAkwMTk1MTQKMDAwMDE5IDA1OTY4NAkwMDI2NTMKMDAwMDIwIDAwNjg5NQkwMDIyOTQK
MDAwMDIxIDAwMTIwNgkwMDA2OTgKMDAwMDIyIDAwMDE3OAkwMDA0MzQKMDAwMDIzIDAwMDA2MAkw
MDAyOTAKMDAwMDI0IDAwMDAyOAkwMDAyOTAKMDAwMDI1IDAwMDAwOQkwMDAyNDgKMDAwMDI2IDAw
MDAwNgkwMDAwNDAKMDAwMDI3IDAwMDAwNQkwMDAwMjAKMDAwMDI4IDAwMDAwMAkwMDAwMDcKMDAw
MDI5IDAwMDAwMAkwMDAwMDYKMDAwMDMwIDAwMDAwMQkwMDAwMDAKMDAwMDMxIDAwMDAwMQkwMDAw
MDAKMDAwMDMyIDAwMDAwMAkwMDAwMDAKMDAwMDMzIDAwMDAwMAkwMDAwMDEKMDAwMDM0IDAwMDAw
MAkwMDAwMDAKMDAwMDM1IDAwMDAwMAkwMDAwMDEKMDAwMDM2IDAwMDAwMAkwMDAwMDAKMDAwMDM3
IDAwMDAwMAkwMDAwMDAKMDAwMDM4IDAwMDAwMAkwMDAwMDAKMDAwMDM5IDAwMDAwMAkwMDAwMDAK
MDAwMDQwIDAwMDAwMAkwMDAwMDAKMDAwMDQxIDAwMDAwMAkwMDAwMDAKMDAwMDQyIDAwMDAwMAkw
MDAwMDAKMDAwMDQzIDAwMDAwMQkwMDAwMDAKMDAwMDQ0IDAwMDAwMAkwMDAwMDAKMDAwMDQ1IDAw
MDAwMAkwMDAwMDAKMDAwMDQ2IDAwMDAwMAkwMDAwMDAKMDAwMDQ3IDAwMDAwMQkwMDAwMDAKMDAw
MDQ4IDAwMDAwMAkwMDAwMDAKMDAwMDQ5IDAwMDAwMAkwMDAwMDAKMDAwMDUwIDAwMDAwMAkwMDAw
MDAKMDAwMDUxIDAwMDAwMQkwMDAwMDAKMDAwMDUyIDAwMDAwMAkwMDAwMDAKMDAwMDUzIDAwMDAw
MAkwMDAwMDAKMDAwMDU0IDAwMDAwMAkwMDAwMDAKMDAwMDU1IDAwMDAwMAkwMDAwMDAKMDAwMDU2
IDAwMDAwMAkwMDAwMDAKMDAwMDU3IDAwMDAwMAkwMDAwMDAKMDAwMDU4IDAwMDAwMAkwMDAwMDAK
MDAwMDU5IDAwMDAwMAkwMDAwMDAKIyBUb3RhbDogMDA5OTk5OTg4IDAwOTk5OTg3NgojIE1pbiBM
YXRlbmN5czogMDAwMTIgMDAwMTAKIyBBdmcgTGF0ZW5jeXM6IDAwMDE0IDAwMDE0CiMgTWF4IExh
dGVuY2llczogMDA3NTcgMDE5MDUKIyBIaXN0b2dyYW0gT3ZlcmZsb3dzOiAwMDAxMiAwMDEyNAo=
--bcaec548a8e98f0bea04aab65acb--
