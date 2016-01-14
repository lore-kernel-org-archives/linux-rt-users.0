From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Subject: RE: cyclictest versus custom SPI based system
Date: Thu, 14 Jan 2016 08:11:00 +0000
Message-ID: <AF04265A3FC2B144B9892F621A394E13D5C0C98E@tethys>
References: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
 <5696992E.703@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Daniel Bristot de Oliveira <daniel@bristot.me>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36084 "EHLO
	dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbcANILF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jan 2016 03:11:05 -0500
In-Reply-To: <5696992E.703@bristot.me>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Daniel,

Thanks for your suggestion. 

I changed the policy:priority as you suggested and the system is stable now!! I will prepare an application to measure the latency with some loads during long periods (but this is another thing).

For reference, in my case (iMX6), the priority adjustment was done at spi.c (master->rt). A patch was suggested to implement this by device tree but other opinion said that this sound like a Linux specific feature/implementation [4]. Anyways, this is another issue.

Thanks,

Julio

[4] Patch to implement SPI RT in device tree: http://www.spinics.net/lists/arm-kernel/msg348713.html


-----Original Message-----
From: Daniel Bristot de Oliveira [mailto:daniel@bristot.me] 
Sent: Thursday, January 14, 2016 2:37 AM
To: Julio Cruz Barroso <julio.cruz@smartmatic.com>; linux-rt-users@vger.kernel.org
Subject: Re: cyclictest versus custom SPI based system



On 01/13/2016 03:06 PM, Julio Cruz Barroso wrote:
> This could be related with the priority of the SPI (spi0)?
In this case the thread spi0 has PRI of 20 with a nice of 0 [3].

Hi Julio,

You must run SPI's IRQ thread on a real-time policy:priority. For instance, chrt -p -f 50 $(pidof spi0).

I used work with an ARM processor running kernel-rt on both master and slave side of a SPI bus, and it worked fine when using threaded IRQ.

If you continue facing long latencies, you can use the (big hammer) IRQF_NO_THREAD flag on SPI's IRQ handler registry. This will force the SPI handler to run as a traditional - non threaded - IRQ handler.

I did it on a very special case of a 200MHz ARM running kernel-rt on the slave side of a SPI bus. As it was on the slave side, any additional overhead (like the scheduling overhead of the threaded handler) was impacting on master's side performance, that was a very busy DSP (ADBF @500Mhz). It worked fine! But the SPI's IRQ was the "highest priority"
task, on a very controlled env.

-- Daniel
