From: =?ISO-8859-15?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Issue with sched-no-work-when-pi-blocked.patch
Date: Wed, 29 Aug 2012 18:04:58 +0200
Message-ID: <503E3DAA.10309@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.238]:48816 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab2H2QNZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Aug 2012 12:13:25 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

on a system running 3.2.23-rt37 the boot time is increased by two
minutes because of commit 4b03ee27 (sched-no-work-when-pi-blocked.patch=
)
when booting with ip=3Ddhcp. This is due to ic_open_devs taking rtnl_mu=
tex
before it ups the network interfaces. The ndo_open function then calls
netif_carrier_off which queues a work that as well takes rtnl_mutex. Th=
is
stalls the workqueue (tsk_is_pi_blocked()) and prevents phy_state_machi=
ne
and thus netif_carrier_on from being run. ic_open_devs waits for two mi=
nutes
for a link before it gives up and releases rtnl_mutex.

So, what is the rationale behind sched-no-work-when-pi-blocked.patch?

On the other hand, I think I'll just drop rtnl_mutex in ic_open_devs
while it is waiting for a link.

  Daniel

--=20
Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Stra=DFe 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
