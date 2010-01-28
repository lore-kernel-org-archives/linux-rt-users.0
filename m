From: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Ooops 805 2.6.31.12-rt20
Date: Thu, 28 Jan 2010 20:41:30 +0100
Message-ID: <201001282041.30610.tstone@vlsi.informatik.tu-darmstadt.de>
References: <20100127140902.8EDEBE967@iss1.vlsi.informatik.tu-darmstadt.de> <20100128080125.GC13756@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?="
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:51062 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966Ab0A1Tlu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 14:41:50 -0500
In-Reply-To: <20100128080125.GC13756@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi 
> This is already fixed in mainline.  (And you were Cc:d for the two
> most relevant patches!)
Oh, then sorry for the noise. I really forgot it seems as if last year is like long ago...

> 84177a2 and 81538e7 are the important ones for you, I didn't check the
Ok thanks.

Btw. is there a up to date preempt rt git tree. I looked on git.kernel.org but i didn't 
find any recent preemt-rt linux tree? I mean one where the mainline 
fixes and the -rt patches are in one tree?

Best regards
Tim 

Btw heres a little typo fix (colon missing). Probably the wrong mailing list, but the right people 8-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
index 00b0ac1..c88d407 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
@@ -671,7 +671,7 @@
 #define MX35_PAD_LD8__SDMA_SDMA_DEBUG_PC_8                     IOMUX_PAD(0x634, 0x1d0, 6, 0x0,   0, NO_PAD_CTRL)

 #define MX35_PAD_LD9__IPU_DISPB_DAT_9                          IOMUX_PAD(0x638, 0x1d4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX35_PAD_LD9__GPIO2_9                                  IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4  0, NO_PAD_CTRL)
+#define MX35_PAD_LD9__GPIO2_9                                  IOMUX_PAD(0x638, 0x1d4, 5, 0x8e4, 0, NO_PAD_CTRL)
 #define MX35_PAD_LD9__SDMA_SDMA_DEBUG_PC_9                     IOMUX_PAD(0x638, 0x1d4, 6, 0x0,   0, NO_PAD_CTRL)

 #define MX35_PAD_LD10__IPU_DISPB_DAT_10                                IOMUX_PAD(0x63c, 0x1d8, 0, 0x0,   0, NO_PAD_CTRL)
