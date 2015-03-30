From: Mikhail Avkhimenia <mikhail.avkhimenia@emlid.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Mon, 30 Mar 2015 13:40:41 +0300
Message-ID: <3863561427712041@web3j.yandex.ru>
References: <3671201425478878@web10j.yandex.ru>
	 <loom.20150306T043408-818@post.gmane.org>
	 <loom.20150309T025355-426@post.gmane.org> <20150309141038.GC13768@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julien Ciesla <jciesla@resologis.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward15j.cmail.yandex.net ([5.255.227.179]:57561 "EHLO
	forward15j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbbC3Kse (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Mar 2015 06:48:34 -0400
In-Reply-To: <20150309141038.GC13768@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I think I found the solution.=20
The problem is that new USB driver for Raspberry Pi uses FIQ in a manne=
r that leads to lockups on SMP systems, while booting of the older non-=
=46IQ driver was broken.=20
The following patch fixes an error and allows to boot the non-FIQ drive=
r:

---
 drivers/usb/host/dwc_otg/dwc_otg_hcd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/dwc_otg/dwc_otg_hcd.c b/drivers/usb/host/=
dwc_otg/dwc_otg_hcd.c
index 68534d4..6a006c5 100644
--- a/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
+++ b/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
@@ -1414,8 +1414,12 @@ static void assign_and_init_hc(dwc_otg_hcd_t * h=
cd, dwc_otg_qh_t * qh)
 	dwc_otg_hc_init(hcd->core_if, hc);
=20
 	local_irq_save(flags);
-	local_fiq_disable();
-	fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+
+	if (fiq_enable) {
+		local_fiq_disable();
+		fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+	}
+
 	/* Enable the top level host channel interrupt. */
 	intr_enable =3D (1 << hc->hc_num);
 	DWC_MODIFY_REG32(&hcd->core_if->host_if->host_global_regs->haintmsk, =
0, intr_enable);
@@ -1423,8 +1427,12 @@ static void assign_and_init_hc(dwc_otg_hcd_t * h=
cd, dwc_otg_qh_t * qh)
 	/* Make sure host channel interrupts are enabled. */
 	gintmsk.b.hcintr =3D 1;
 	DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, 0, gintmsk=
=2Ed32);
-	fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-	local_fiq_enable();
+
+	if (fiq_enable) {
+		fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
+		local_fiq_enable();
+	}
+=09
 	local_irq_restore(flags);
 	hc->qh =3D qh;
 }
--


To boot the with the non-FIQ driver add this to the /boot/cmdline.txt:
dwc_otg.fiq_enable=3D0 dwc_otg.fiq_fsm_enable=3D0 dwc_otg.nak_holdoff=3D=
0
=9A

Best regards,
Mikhail Avkhimenia


09.03.2015, 17:13, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> * Julien Ciesla | 2015-03-09 01:55:49 [+0000]:
>> Same issue on linux raspberrypi 3.18.9 with patch rt4.
>
> Then disable USB completely.
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
