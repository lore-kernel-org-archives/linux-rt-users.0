From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Long max latencies on Wandbaord / Freescale i.MX6
Date: Fri, 2 Oct 2015 08:48:00 +0200
Message-ID: <560E28A0.4010203@gmx.net>
References: <5606677A.1020705@gmx.net>
 <alpine.DEB.2.11.1509271346160.4500@nanos> <560A3020.5090909@gmx.net>
 <alpine.DEB.2.11.1509300909240.4500@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:50241 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbbJBGsF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2015 02:48:05 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0M1F72-1aWhNB2H2O-00tDSs for
 <linux-rt-users@vger.kernel.org>; Fri, 02 Oct 2015 08:48:01 +0200
In-Reply-To: <alpine.DEB.2.11.1509300909240.4500@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Comming to the end of my CONFIG_PROVE_LOCKING / "max latency" story:

It is not a spurious interrupt...

The source of problem is the WiFi driver (brcmfmac via SDIO) which 
produces up to 6k interrupts per second, which when 
CONFIG_PROOVE_LOCKING is enabled, results sporadically in very long 
latencies (up to 10ms). (Possible because pending interrupts were queued).

Further after exactly 1600001 interrupts, the kernel disables this mmc 
interrupt with "__report_bad_irq"
(The mmc driver is not only used for SD-cards but also for the SDIO 
attached devices.)

Or with other words: never use (this) WiFi on a realtime system...

Regards and sorry for the noise I produced on this list
	Matthias

