From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: cyclictest versus custom SPI based system
Date: Fri, 15 Jan 2016 13:31:43 +0200
Message-ID: <5698D89F.9020203@ti.com>
References: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
 <5696992E.703@bristot.me> <AF04265A3FC2B144B9892F621A394E13D5C0C98E@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: Julio Cruz Barroso <julio.cruz@smartmatic.com>,
	Daniel Bristot de Oliveira <daniel@bristot.me>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33629 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbcAOLbu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:31:50 -0500
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13D5C0C98E@tethys>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julio,
On 01/14/2016 10:11 AM, Julio Cruz Barroso wrote:
> 
> I changed the policy:priority as you suggested and the system is stable now!! I will prepare
 an application to measure the latency with some loads during long periods (but this is another thing).
> 
> For reference, in my case (iMX6), the priority adjustment was done at spi.c (master->rt). A patch 
was suggested to implement this by device tree but other opinion said that this sound like a Linux
 specific feature/implementation [4]. Anyways, this is another issue.
> 

Just curios, is it possible for you to achieve the same results from User space using chrt/taskset utils?
(without Kernel modification).

For example, I can see below processes on my system:
  184 root         0 SW   [spi32766]
and our QSPI driver don't use IRQs.
 

> [4] Patch to implement SPI RT in device tree: http://www.spinics.net/lists/arm-kernel/msg348713.html
> 

-- 
regards,
-grygorii
