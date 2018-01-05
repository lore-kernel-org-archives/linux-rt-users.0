From: Tim Sander <tim.sander@hbm.com>
Subject: Re: Kernel config options that impact latency
Date: Fri, 5 Jan 2018 11:09:00 +0100
Message-ID: <5088098.7Ckg0tM8a2@dabox>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com> <CANGgnMb_EdRP7pUFktSMEC5n4MYbMytMoruR-dTrVAJ7a0dbyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Hindman, Gavin" <gavin.hindman@intel.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx-relay08-hz1.antispameurope.com ([94.100.132.208]:34560 "EHLO
        mx-relay08-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750787AbeAEKOE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jan 2018 05:14:04 -0500
In-Reply-To: <CANGgnMb_EdRP7pUFktSMEC5n4MYbMytMoruR-dTrVAJ7a0dbyA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Am Donnerstag, 4. Januar 2018, 11:24:37 CET schrieben Sie:
> On Thu, Jan 4, 2018 at 10:29 AM, Hindman, Gavin <gavin.hindman@intel.com> wrote:
> For ARM platforms, we've found turning off power management helps.
> The book-keeping was costing a lot of time in latency critical spots.
Its not only the book-keeping. I also patched out wfi on i.mx3x since waking
up from sleeping took some considerable delays. But that depends on your latency
requirements and your actual cpu.

The patch below is for an older 3.4.x kernel as example for further tuning power vs. latency.

Best regards
Tim

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 7412738..7b3d312 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -33,33 +33,6 @@
 
 static void imx3_idle(void)
 {
-       unsigned long reg = 0;
-
-       mx3_cpu_lp_set(MX3_WAIT);
-
-       __asm__ __volatile__(
-               /* disable I and D cache */
-               "mrc p15, 0, %0, c1, c0, 0\n"
-               "bic %0, %0, #0x00001000\n"
-               "bic %0, %0, #0x00000004\n"
-               "mcr p15, 0, %0, c1, c0, 0\n"
-               /* invalidate I cache */
-               "mov %0, #0\n"
-               "mcr p15, 0, %0, c7, c5, 0\n"
-               /* clear and invalidate D cache */
-               "mov %0, #0\n"
-               "mcr p15, 0, %0, c7, c14, 0\n"
-               /* WFI */
-               "mov %0, #0\n"
-               "mcr p15, 0, %0, c7, c0, 4\n"
-               "nop\n" "nop\n" "nop\n" "nop\n"
-               "nop\n" "nop\n" "nop\n"
-               /* enable I and D cache */
-               "mrc p15, 0, %0, c1, c0, 0\n"
-               "orr %0, %0, #0x00001000\n"
-               "orr %0, %0, #0x00000004\n"
-               "mcr p15, 0, %0, c1, c0, 0\n"
-               : "=r" (reg));
 }
 
 static void __iomem *imx3_ioremap_caller(unsigned long phys_addr, size_t size,

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | Managing Director: Andreas Huellhorst | Chairman of the board: Eoghan O?Lionaird

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: Eoghan O?Lionaird

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fuer den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
