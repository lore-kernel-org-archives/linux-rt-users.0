From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Subject: Re: cyclictest versus custom SPI based system
Date: Fri, 15 Jan 2016 11:45:05 +0000
Message-ID: <84F252D5-8D16-481A-ABB7-907F7F2A39EA@smartmatic.com>
References: <AF04265A3FC2B144B9892F621A394E13D5C0B43F@tethys>
 <5696992E.703@bristot.me>
 <AF04265A3FC2B144B9892F621A394E13D5C0C98E@tethys>,<5698D89F.9020203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:32855 "EHLO
	dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755868AbcAOLpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:45:12 -0500
In-Reply-To: <5698D89F.9020203@ti.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Griygirii,

Yes, I got the same results. 

Julio

On Jan 15, 2016, at 7:31 PM, Grygorii Strashko <grygorii.strashko@ti.com> wrote:

Hi Julio,
> On 01/14/2016 10:11 AM, Julio Cruz Barroso wrote:
> 
> I changed the policy:priority as you suggested and the system is stable now!! I will prepare
an application to measure the latency with some loads during long periods (but this is another thing).
> 
> For reference, in my case (iMX6), the priority adjustment was done at spi.c (master->rt). A patch
was suggested to implement this by device tree but other opinion said that this sound like a Linux
specific feature/implementation [4]. Anyways, this is another issue.

Just curios, is it possible for you to achieve the same results from User space using chrt/taskset utils?
(without Kernel modification).

For example, I can see below processes on my system:
 184 root         0 SW   [spi32766]
and our QSPI driver don't use IRQs.


> [4] Patch to implement SPI RT in device tree: http://www.spinics.net/lists/arm-kernel/msg348713.html

-- 
regards,
-grygorii
