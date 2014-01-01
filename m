From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: 3.12.6-rt9 on AM335x (armv7)
Date: Wed, 01 Jan 2014 17:37:28 +0100
Message-ID: <52C44448.3030405@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:15628 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbaAAQny (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jan 2014 11:43:54 -0500
Received: from bunny.home (p57BCD8C2.dip0.t-ipconnect.de [87.188.216.194])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (TLSv1:DHE-RSA-AES256-SHA encrypted) ESMTPSA id 603240q01GbW9jS
	for <linux-rt-users@vger.kernel.org>;
	Wed, 1 Jan 2014 17:37:32 +0100 (CET)
Received: from [192.168.2.13] (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 430F515800F
	for <linux-rt-users@vger.kernel.org>; Wed,  1 Jan 2014 17:37:34 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I did a setup with 3.12.6-rt9 kernel on a Beaglebone board
with an TI AM335x CPU running at fixed 720MHz. The kernel uses the 
omap2plus_defconfig configuration that comes with this kernel with 
additional CONFIG_PREEMPT_RT_FULL switched on.

I am observing some strange max. latencies when comparing with kernel 
3.2.45-rt66. The results of a similiar system can be found on the OSADL lab
site (https://www.osadl.org/Latency-plot-of-system-in-rack-7-slot.qa-latencyplot-r7s5.0.html).

With "cyclictest -p99 -m -n -i200 -h400 -q -l10000000" I get
...
# Min Latencies: 00013
# Avg Latencies: 00062
# Max Latencies: 04664
...

Also the latency does not differ much from that when doing a flood ping against 
the system as simple stress.

3.2.45-rt66 comes with a max. latency of 118us! So I expect something to be wrong with 3.12.6-rt9
at least on armv7 or especially this device (max. lat. 4664us).

I also noticed an issue with the on-chip ethernet when CONFIG_PREEMPT_RT_FULL is
switched on with this kernel:

I also noticed that the 3.12.6-rt9 with enabled 
[    2.817024] net eth0: initializing cpsw version 1.12 (0)
[    2.825269] net eth0: phy found : id is : 0x7c0f1
[    2.830713] libphy: PHY 4a101000.mdio:01 not found
[    2.835777] net eth0: phy 4a101000.mdio:01 not found on slave 1
[   12.846394] Waiting up to 110 more seconds for network.
[   22.846147] Waiting up to 100 more seconds for network.
...

Finally networking is fine. But I need to wait for 110 seconds :-)

Prior testing with 3.12.6-rt9 I did the same test with 3.12.5-rt7. Same results.
But without CONFIG_PREEMPT_RT_FULL I do not get this bringup delay. I could not do this 
test with rt9 because it does not build without CONFIG_PREEMPT_RT_FULL!

Any ideas?

Matthias
