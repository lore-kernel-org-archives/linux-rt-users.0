From: Giuliano Colla <giuliano.colla@fastwebnet.it>
Subject: Re: Eliminating Packet Latency
Date: Tue, 15 Mar 2016 20:22:36 +0100
Message-ID: <56E860FC.70706@fastwebnet.it>
References: <262920A1-2716-4D46-9A0F-7E7DC93EE24D@aha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Hewitt <mhewitt@aha.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mr004msr.fastwebnet.it ([85.18.95.67]:39235 "EHLO
	mr004msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbcCOT2W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Mar 2016 15:28:22 -0400
In-Reply-To: <262920A1-2716-4D46-9A0F-7E7DC93EE24D@aha.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 14/03/2016 22:02, Michael Hewitt ha scritto:
> We are using a real time Linux kernel (3.10.0) in a network appliance in order to achieve extremely consistent packet delivery times.  Generally, we see packet delivery variations of less than 100 microseconds, which is fabulous.  Occasionally, we see a packet delivery delay in excess of 1000 microseconds.  We are hoping to eliminate these spikes, which occur perhaps 1-2 times in a 24 hour period.
>
> The machine configuration is as follows.  Thread IRQs are enabled, and we have elevated the priority of both the irq threads that service the specific network interface to 55.  We have also elevated the priority of the relevant user space thread to 49.  We are running on a 4 core Intel Xeon E3-1220v3 with an Intel NIC and the igb version 5.3.2 driver.  We disabled interrupt throttling in the Intel driver (rx-usecs = 0, tx-usecs = 0).  SE Linux is disabled, eliminating a huge packet latency spike during login.  We are running CentOS 7.1 tuned for network latency ("tuned-adm profile network-latency").  IRQ balancing is disabled.  BIOS CPU power management is set to maximum performance.
>

I'm using a 3.10 line kernel four our real-time applications (actually a 
3.10.10). We have experienced (quite unexpectedly) a better overall 
performance (reduced latency) with the on demand governor than with the 
performance governor. As the performance achieved was sufficient four 
our purposes in both cases we didn't investigate further. Maybe it's 
worth a try.

Giuliano

