From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Subject: cyclictest versus custom SPI based system
Date: Wed, 13 Jan 2016 17:06:50 +0000
Message-ID: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:51293 "EHLO
	dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753243AbcAMRGx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 12:06:53 -0500
Received: from mx2-us1.ppe-hosted.com (unknown [10.7.64.21])
	by dispatch1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTP id 9FF2620096
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 17:06:53 +0000 (UTC)
Received: from hyperion.ve.sbp.com (unknown [186.73.192.71])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx2-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id AA596200BC
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 17:06:51 +0000 (UTC)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
=20
I=92m using a linux-wandboard-rt 3.14.28, with a max latency of 114us [=
1].
=20
I would like include an IIO driver to acquire data from a SPI device @ =
1Hz.
=20
After disable some modules (as suggested two months ago by Mat and tglx=
 [2]) the acquisition is more stable, however it still losing data.
=20
Based on a scope and a couple of GPIO, I could find that the SPI handle=
r is not firing sometimes.
=20
I don=92t understand why the max latency (with cyclictest is 114us) and=
 the SPI handler @1ms is failing with delays of 3 to 5ms.
=20
There is a way to force the SPI handler over all others kernel process?
This could be related with the priority of the SPI (spi0)? In this case=
 the thread spi0 has PRI of 20 with a nice of 0 [3].
Do you suggest to continuing digging to find the cause in other modules=
?
=20
Thanks
Julio
=20
-----
[1] cyclictest result
cyclictest -t1 -p 80 -n -i 1000 -l 100000
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.11 0.25 0.14 1/94 549
T: 0 (  548) P:80 I:1000 C: 100000 Min:     10 Act:   15 Avg:   15 Max:=
     114
=20
-----
[2] [2015-09-26 9:38:02] Long max latencies on Wandbaord / Freescale i.=
MX6
=20
-----
[3] htop and system modules: http://postimg.org/image/jrvcw5v59/--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
