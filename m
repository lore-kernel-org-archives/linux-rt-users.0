From: Raphael Hertzog <raphael@ouaza.com>
Subject: Changing real time priority of interrupt handler thread
Date: Wed, 5 May 2010 15:08:45 +0200
Message-ID: <20100505130845.GA9118@rivendell>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arrakeen.ouaza.com ([212.85.152.62]:51346 "EHLO
	arrakeen.ouaza.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934725Ab0EENTE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 May 2010 09:19:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by arrakeen.ouaza.com (Postfix) with ESMTP id E337F332B7
	for <linux-rt-users@vger.kernel.org>; Wed,  5 May 2010 15:09:10 +0200 (CEST)
Received: from arrakeen.ouaza.com ([127.0.0.1])
	by localhost (arrakeen.ouaza.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id imhJwtqrGCj1 for <linux-rt-users@vger.kernel.org>;
	Wed,  5 May 2010 15:09:10 +0200 (CEST)
Received: from soleymieux.ouaza.com (soleymieux.ouaza.com [78.225.60.32])
	by arrakeen.ouaza.com (Postfix) with ESMTPA id B4817331A4
	for <linux-rt-users@vger.kernel.org>; Wed,  5 May 2010 15:09:10 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[ Please cc me on answer, I'm not subscribed to the list, I tried to as=
k
this question on the #linux-rt channel but got no answers so I try on t=
he
list ]

Hello,

with 2.6.33.2-rt13 the IRQ handler thread for serial devices is
no longer persistent after its creation. Up to now I had a startup
script opening the serial device in order to create the IRQ handler
thread that would run chrt on $(pidof IRQ-4) and the setting would be
persistent until next reboot.

This is no longer possible, I would have to run chrt every time that I
open the serial port and I would like to avoid modifying all my
applications to do this.

Is there any other alternative like making the thread persistent with s=
ome
options (/sys or /proc tuning)?

Or is there a kernel config option for this ?

In case it was not clear, I want to run the IRQ handler of the serial
ports at a higher priority than the other ones (like network, disk,
etc.) to avoid buffer overruns.

Cheers,
--=20
Rapha=EBl Hertzog -+- http://www.ouaza.com

=46reexian : des d=E9veloppeurs Debian au service des entreprises
http://www.freexian.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
