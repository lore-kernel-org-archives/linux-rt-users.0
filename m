From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 16:32:49 +0100
Message-ID: <201202021632.50065.tim.sander@hbm.com>
References: <4F292FE0.7090302@digi.com> <4F2A8850.4080201@digi.com> <201202021525.05606.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>, <lclaudio@uudg.org>,
	<rostedt@goodmis.org>, <efault@gmx.de>
To: "Hector Palacios" <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:24498 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932081Ab2BBPeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 10:34:00 -0500
Content-Class: urn:content-classes:message
In-reply-to: <201202021525.05606.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Attached you will find a hacky patch which should just verify that the =
problem=20
hypothesis can be validated.
It just initializes the phy with driver initialisation and should work =
around=20
this ksoftirq/sirq-net-tx problem.

Best regards
Tim


=46rom 5dda8d2f7d068ca2534441215d9437f3bbb0c652 Mon Sep 17 00:00:00 200=
1

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the commer=
cial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregist=
er des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhor=
st | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely fo=
r the addressee. If you are not the intended recipient, please let me k=
now and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und ledigli=
ch f=FCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Emp=
faenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail=
=2E
=46rom: Tim Sander <tim.sander@hbm.com>
Date: Thu, 2 Feb 2012 15:51:06 +0100
Subject: [PATCH] fec: hack around ksoftirqd problem

---
 drivers/net/fec.c |   58 ++++++++++++++++++++++++++++-----------------=
-------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 885d8ba..292ae7e 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -231,6 +231,7 @@ static void *swap_buffer(void *bufaddr, int len)
        return bufaddr;
 }
=20
+
 static netdev_tx_t
 fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -1135,24 +1136,6 @@ static int
 fec_enet_open(struct net_device *ndev)
 {
        struct fec_enet_private *fep =3D netdev_priv(ndev);
-       int ret;
-
-       /* I should reset the ring buffers here, but I don't yet know
-        * a simple way to do that.
-        */
-
-       ret =3D fec_enet_alloc_buffers(ndev);
-       if (ret)
-               return ret;
-
-       /* Probe and connect to PHY when open the interface */
-       ret =3D fec_enet_mii_probe(ndev);
-       if (ret) {
-               fec_enet_free_buffers(ndev);
-               return ret;
-       }
-       phy_start(fep->phy_dev);
-       netif_start_queue(ndev);
        fep->opened =3D 1;
        return 0;
 }
@@ -1164,15 +1147,6 @@ fec_enet_close(struct net_device *ndev)
=20
        /* Don't know what to do yet. */
        fep->opened =3D 0;
-       netif_stop_queue(ndev);
-       fec_stop(ndev);
-
-       if (fep->phy_dev) {
-               phy_stop(fep->phy_dev);
-               phy_disconnect(fep->phy_dev);
-       }
-
-       fec_enet_free_buffers(ndev);
=20
        return 0;
 }
@@ -1432,10 +1406,32 @@ fec_probe(struct platform_device *pdev)
        netif_carrier_off(ndev);
=20
        ret =3D register_netdev(ndev);
+
        if (ret)
                goto failed_register;
=20
+// Tim: very hacky for testing
+       /* I should reset the ring buffers here, but I don't yet know
+        * a simple way to do that.
+        */
+
+       ret =3D fec_enet_alloc_buffers(ndev);
+       if (ret)
+               return ret;
+
+       /* Probe and connect to PHY when open the interface */
+       ret =3D fec_enet_mii_probe(ndev);
+       if (ret) {
+               fec_enet_free_buffers(ndev);
+               return ret;
+       }
+       phy_start(fep->phy_dev);
+       netif_start_queue(ndev);
+       fep->opened =3D 1;
+// end hacky=20
+
        return 0;
+
=20
 failed_register:
        fec_enet_mii_remove(fep);
@@ -1466,7 +1462,15 @@ fec_drv_remove(struct platform_device *pdev)
        struct fec_enet_private *fep =3D netdev_priv(ndev);
        struct resource *r;
=20
+       netif_stop_queue(ndev);
        fec_stop(ndev);
+
+       if (fep->phy_dev) {
+               phy_stop(fep->phy_dev);
+               phy_disconnect(fep->phy_dev);
+       }
+
+       fec_enet_free_buffers(ndev);
        fec_enet_mii_remove(fep);
        clk_disable(fep->clk);
        clk_put(fep->clk);
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
