From: Manfred Gruber <m.gruber@tirol.com>
Subject: timer patch for ep93xx
Date: Wed, 27 Jun 2007 16:33:30 +0200
Message-ID: <200706271633.30518.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 85-126-107-146.static.sdsl-line.inode.at ([85.126.107.146]:3662
	"EHLO mail.contec.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbXF0Odc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2007 10:33:32 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi !

this patch is necessary to get latencies < 1ms for ep93xx armv4t with 
2.6.21.5-rt18.
Index: linux-2.6/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6/arch/arm/mach-ep93xx/core.c
@@ -108,7 +108,17 @@ static int ep93xx_timer_interrupt(int ir
 static int ep93xx_set_next_event(unsigned long evt,
                                  struct clock_event_device *unused)
 {
+       u32 tmode;
+       tmode = __raw_readl(EP93XX_TIMER1_CONTROL);
+       tmode &= ~EP93XX_TC123_ENABLE;
+
+       /* stop timer */
+       __raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+       /* program timer */
        __raw_writel(evt, EP93XX_TIMER1_LOAD);
+       /* start timer */
+       tmode |= EP93XX_TC123_ENABLE;
+       __raw_writel(tmode, EP93XX_TIMER1_CONTROL);
        return 0;
 }

i have now disabled all kernel hacking things, and get this latencies with 
2.6.21.5-rt18. i run top with delay 0 over serial and ping -f. cyclictest is 
run over ssh.
[root@micro9]\# ./cyclictest_new -i 10000 -n -p 80 -t 10
5.56 4.16 1.94 1/69 1199          

T: 0(1122) P:80 I:10000 C:  56041 Min:     24 Act:  106 Avg:  176 Max:     466
T: 1(1123) P:79 I:10500 C:  53372 Min:     24 Act:  309 Avg:  190 Max:     668
T: 2(1124) P:78 I:11000 C:  50946 Min:     23 Act:  241 Avg:  186 Max:     645
T: 3(1125) P:77 I:11500 C:  48731 Min:     24 Act:  228 Avg:  186 Max:     663
T: 4(1126) P:76 I:12000 C:  46701 Min:     24 Act:   36 Avg:  197 Max:     683
T: 5(1127) P:75 I:12500 C:  44833 Min:     25 Act:   34 Avg:  189 Max:     659
T: 6(1128) P:74 I:13000 C:  43109 Min:     24 Act:  293 Avg:  192 Max:     630
T: 7(1129) P:73 I:13500 C:  41512 Min:     23 Act:   31 Avg:  195 Max:     773
T: 8(1130) P:72 I:14000 C:  40029 Min:     24 Act:  223 Avg:  179 Max:     712
T: 9(1131) P:71 I:14500 C:  38649 Min:     24 Act:  101 Avg:  206 Max:     738

does someone have some latencies to compare? what do you think about this 
latencies, is this the the end what is possible ?

-- 
regards
	Manfred Gruber
