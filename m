Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:47100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQS1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Dec 2018 11:18:27 -0500
Date: Thu, 13 Dec 2018 17:18:24 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: outliers when measuring boost msqueues latency v4.14.79-rt47
 RT-Preempt
Message-ID: <20181213161824.nuookwzlmgshz4vq@linutronix.de>
References: <VI1PR06MB44627C92EA94534421191FEBCEA90@VI1PR06MB4462.eurprd06.prod.outlook.com>
 <20181207114450.pypgcipls27f3izw@linutronix.de>
 <AM0PR06MB445132FA3FB5915AFB3A736ECEAA0@AM0PR06MB4451.eurprd06.prod.outlook.com>
 <20181210140828.ytut6wktdjsbopze@linutronix.de>
 <VI1PR06MB4462D090E47B81C7B207D152CEA50@VI1PR06MB4462.eurprd06.prod.outlook.com>
 <VI1PR06MB4462F8F06850961618D318C1CEA60@VI1PR06MB4462.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR06MB4462F8F06850961618D318C1CEA60@VI1PR06MB4462.eurprd06.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Andreas Hoefler <andreas.hoefler@ch.abb.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-12-11 08:28:12 [+0000], Andreas Hoefler wrote:
> Hi all
Him

> I finally found the root cause of my problem! What made me very suspicious was the fact, that the spikes occur pretty much exactly after 950ms each time. 
> It turns out that throttling was activated having sched_rt_runtime_us set to 950000. Switching it to -1 and everything runs just fine!

Be aware that once a RT task forgets to go to sleep, it may lockup /
starve the whole system.

> Just out of curiosity: in case the throttling kicks in, are all the rt task just in a suspended state?

All RT tasks. This includes threaded interrupts which usually run at
FIFO 50.

> Again thanx to Sebastian for helping me out here!
> 
> BR
> Andy

Sebastian
