From: Michael Hewitt <mhewitt@aha.com>
Subject: Eliminating Packet Latency
Date: Mon, 14 Mar 2016 14:02:27 -0700
Message-ID: <262920A1-2716-4D46-9A0F-7E7DC93EE24D@aha.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.comtechefdata.org ([206.223.8.40]:50373 "EHLO
	mail.comtechefdata.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933687AbcCNVKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 17:10:03 -0400
Received: from gwia.comtechefdata.com ([10.6.2.47]:58302)
	by mail.comtechefdata.com with esmtp (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <mhewitt@aha.com>)
	id 1afZdM-00086d-0d
	for linux-rt-users@vger.kernel.org; Mon, 14 Mar 2016 14:02:36 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Folks,

Please forgive me if this is an inappropriate forum for my question. 

We are using a real time Linux kernel (3.10.0) in a network appliance in order to achieve extremely consistent packet delivery times.  Generally, we see packet delivery variations of less than 100 microseconds, which is fabulous.  Occasionally, we see a packet delivery delay in excess of 1000 microseconds.  We are hoping to eliminate these spikes, which occur perhaps 1-2 times in a 24 hour period.

The machine configuration is as follows.  Thread IRQs are enabled, and we have elevated the priority of both the irq threads that service the specific network interface to 55.  We have also elevated the priority of the relevant user space thread to 49.  We are running on a 4 core Intel Xeon E3-1220v3 with an Intel NIC and the igb version 5.3.2 driver.  We disabled interrupt throttling in the Intel driver (rx-usecs = 0, tx-usecs = 0).  SE Linux is disabled, eliminating a huge packet latency spike during login.  We are running CentOS 7.1 tuned for network latency ("tuned-adm profile network-latency").  IRQ balancing is disabled.  BIOS CPU power management is set to maximum performance.

Any help you can provide would be greatly appreciated.

Thanks,
Mike


