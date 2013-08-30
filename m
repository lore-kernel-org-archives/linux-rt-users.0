From: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free
 already-free IRQ 1"
Date: Fri, 30 Aug 2013 11:18:19 +0000
Message-ID: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wapice.fi ([81.209.51.2]:61649 "EHLO brando.wapice.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755234Ab3H3L3i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 07:29:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by brando.wapice.com (Postfix) with ESMTP id 71F6F17843E5
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Aug 2013 14:18:20 +0300 (EEST)
Received: from brando.wapice.com ([127.0.0.1])
 by localhost (brando.wapice.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11702-09 for <linux-rt-users@vger.kernel.org>;
 Fri, 30 Aug 2013 14:18:20 +0300 (EEST)
Received: from edb0.wapice.localdomain (unknown [10.0.4.32])
	by brando.wapice.com (Postfix) with ESMTP id 129D0174C2F2
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Aug 2013 14:18:20 +0300 (EEST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Michael

We have encountered the same warnings with the Atmel SAMA5D35 processor=
 when using the RT_PREEMPT patch. We get the same warnings with both 3.=
6.9-rt21 and 3.10.9-rt5 kernels. However, the 3.6.9-rt21 kernel boots j=
ust fine, and we also had problems booting the 3.10.9-rt5 kernel. There=
fore these warnings and boot hanging might be unrelated.

What's causing these warnings is still unknown, but at least we got the=
 3.10.9-rt5 kernel to boot. The boot problem seems to be caused by the =
TCB clock source (tcb_clksrc). You could try to unset the CONFIG_ATMEL_=
TCB_CLKSRC option, but this is not optimal configuration for rt.=20

I have attached a patch which goes on top of the rt5 patch that seems t=
o fix the boot hang issue. Could you please report the results if you h=
ave time to test this patch? Please note that I have not yet done any r=
t-tests with this patch.

BR,
Sami Pietik=E4inen
Software Developer
Wapice Ltd.

--- a/drivers/clocksource/tcb_clksrc.c	2013-08-29 16:14:14.611335823 +0=
300
+++ b/drivers/clocksource/tcb_clksrc.c	2013-08-29 16:16:28.129657272 +0=
300
@@ -192,9 +192,13 @@
 	clkevt.clk =3D t2_clk;
 	tc_irqaction.dev_id =3D &clkevt;
=20
-	timer_clock =3D clk32k_divisor_idx;
+	timer_clock =3D divisor_idx;
=20
-	clkevt.clkevt.cpumask =3D cpumask_of(0);
+	if (!divisor)
+		clkevt.freq =3D 32768;
+	else
+		clkevt.freq =3D clk_get_rate(t2_clk)/divisor;
+	clkevt.clkevt.cpumask =3D cpumask_of(0);
=20
 	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
