From: Hector Palacios <hector.palacios@digi.com>
Subject: infinite spin in RT when booting with DHCP on
Date: Wed, 01 Feb 2012 13:28:16 +0100
Message-ID: <4F292FE0.7090302@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lclaudio@uudg.org, rostedt@goodmis.org, efault@gmx.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33758 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349Ab2BAMfL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Feb 2012 07:35:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1RsZOx-0001Bu-I3
	for linux-rt-users@vger.kernel.org; Wed, 01 Feb 2012 13:35:03 +0100
Received: from 217.151.242.14 ([217.151.242.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Feb 2012 13:35:03 +0100
Received: from hector.palacios by 217.151.242.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Feb 2012 13:35:03 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm working on a 2.6.31.14 kernel on ARM where I applied the RT PREEMPT=
 patch=20
2.6.31.12-rt21.

When booting my platform with DHCP on, the DHCP request is sent by the =
network driver=20
before the PHY has even started the autonegotiation.
Since the PHY is not ready, the TX interrupt returns with NETDEV_TX_BUS=
Y but the=20
softirq [sirq-net-tx] seems to have entered an infinite spin, as my sys=
tem is=20
practically hung and 'top' reveals [sirq-net-tx/0] is consuming 95% of =
CPU. This is=20
preventing the PHY autonegotiation (which is scheduled as a delayed wor=
k) to start, so=20
the PHY is never ready and the packet never reaches the network.

I was wondering if this situation resembles what the patch by Ingo Moln=
ar "tasklet/rt:=20
Prevent tasklets from going into infinite spin in RT" describes.

This patch is already in 2.6.31.12-rt21 patch which I'm using so either=
 it is a=20
different problem or a corner case of the same issue.

Could anyone tell whether it is the same or a different problem?
Thank you
--=20
H=E9ctor Palacios

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
