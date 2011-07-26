From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Tue, 26 Jul 2011 11:19:17 +0200
Message-ID: <20110726091917.GQ16561@pengutronix.de>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
 <4E2E3089.5070600@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44391 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1GZJTU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2011 05:19:20 -0400
Content-Disposition: inline
In-Reply-To: <4E2E3089.5070600@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 25, 2011 at 08:12:09PM -0700, Frank Rowand wrote:
> On 07/24/11 03:33, Thomas Gleixner wrote:
> > Dear RT Folks,
> >=20
> > I'm pleased to announce the 3.0-rt3 release.
>=20
> ARM panda board boots for PREEMPT_RT_FULL, with a BUG:
>=20
> Freeing init memory: 308K
> BUG: sleeping function called from invalid context at kernel/rtmutex.=
c:645
> in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper
> 1 lock held by swapper/0:
>  #0:  (&irq_desc_lock_class){-.....}, at: [<c00ed470>] handle_fasteoi=
_irq+0x14/0x10c
> irq event stamp: 21292
> hardirqs last  enabled at (21291): [<c0061ee0>] default_idle+0x2c/0x3=
c
> hardirqs last disabled at (21292): [<c0484bb4>] __irq_svc+0x34/0x138
> softirqs last  enabled at (0): [<  (null)>]   (null)
> softirqs last disabled at (0): [<  (null)>]   (null)
> [<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483d20>] (rt_spin_l=
ock+0x24/0x5c)
> [<c0483d20>] (rt_spin_lock+0x24/0x5c) from [<c006df74>] (gic_mask_irq=
+0x28/0x7c)
> [<c006df74>] (gic_mask_irq+0x28/0x7c) from [<c00ece20>] (mask_irq+0x1=
c/0x2c)
> [<c00ece20>] (mask_irq+0x1c/0x2c) from [<c00ed514>] (handle_fasteoi_i=
rq+0xb8/0x10c)
> [<c00ed514>] (handle_fasteoi_irq+0xb8/0x10c) from [<c00ea724>] (gener=
ic_handle_irq+0x34/0x50)
> [<c00ea724>] (generic_handle_irq+0x34/0x50) from [<c0055048>] (asm_do=
_IRQ+0x48/0xa8)
> [<c0055048>] (asm_do_IRQ+0x48/0xa8) from [<c0484bd0>] (__irq_svc+0x50=
/0x138)
I guess you need something like the patch below.

Best regards
Uwe

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4ddd0a6..5c1dd07 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -33,7 +33,7 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
=20
-static DEFINE_SPINLOCK(irq_controller_lock);
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
=20
 /* Address of GIC 0 CPU interface */
 void __iomem *gic_cpu_base_addr __read_mostly;
@@ -88,30 +88,30 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask =3D 1 << (d->irq % 32);
=20
-	spin_lock(&irq_controller_lock);
+	raw_spin_lock(&irq_controller_lock);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_=
irq(d) / 32) * 4);
 	if (gic_arch_extn.irq_mask)
 		gic_arch_extn.irq_mask(d);
-	spin_unlock(&irq_controller_lock);
+	raw_spin_unlock(&irq_controller_lock);
 }
=20
 static void gic_unmask_irq(struct irq_data *d)
 {
 	u32 mask =3D 1 << (d->irq % 32);
=20
-	spin_lock(&irq_controller_lock);
+	raw_spin_lock(&irq_controller_lock);
 	if (gic_arch_extn.irq_unmask)
 		gic_arch_extn.irq_unmask(d);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_ir=
q(d) / 32) * 4);
-	spin_unlock(&irq_controller_lock);
+	raw_spin_unlock(&irq_controller_lock);
 }
=20
 static void gic_eoi_irq(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_eoi) {
-		spin_lock(&irq_controller_lock);
+		raw_spin_lock(&irq_controller_lock);
 		gic_arch_extn.irq_eoi(d);
-		spin_unlock(&irq_controller_lock);
+		raw_spin_unlock(&irq_controller_lock);
 	}
=20
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
@@ -135,7 +135,7 @@ static int gic_set_type(struct irq_data *d, unsigne=
d int type)
 	if (type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
=20
-	spin_lock(&irq_controller_lock);
+	raw_spin_lock(&irq_controller_lock);
=20
 	if (gic_arch_extn.irq_set_type)
 		gic_arch_extn.irq_set_type(d, type);
@@ -160,7 +160,7 @@ static int gic_set_type(struct irq_data *d, unsigne=
d int type)
 	if (enabled)
 		writel_relaxed(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);
=20
-	spin_unlock(&irq_controller_lock);
+	raw_spin_unlock(&irq_controller_lock);
=20
 	return 0;
 }
@@ -188,11 +188,11 @@ static int gic_set_affinity(struct irq_data *d, c=
onst struct cpumask *mask_val,
 	mask =3D 0xff << shift;
 	bit =3D 1 << (cpu + shift);
=20
-	spin_lock(&irq_controller_lock);
+	raw_spin_lock(&irq_controller_lock);
 	d->node =3D cpu;
 	val =3D readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
-	spin_unlock(&irq_controller_lock);
+	raw_spin_unlock(&irq_controller_lock);
=20
 	return 0;
 }
@@ -222,9 +222,9 @@ static void gic_handle_cascade_irq(unsigned int irq=
, struct irq_desc *desc)
=20
 	chained_irq_enter(chip, desc);
=20
-	spin_lock(&irq_controller_lock);
+	raw_spin_lock(&irq_controller_lock);
 	status =3D readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
-	spin_unlock(&irq_controller_lock);
+	raw_spin_unlock(&irq_controller_lock);
=20
 	gic_irq =3D (status & 0x3ff);
 	if (gic_irq =3D=3D 1023)
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
