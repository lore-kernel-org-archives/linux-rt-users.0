From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.9.6-rt4: big latency due to a kworker upon serial interrupts
Date: Fri, 3 Feb 2017 16:50:32 +0100
Message-ID: <20170203155031.xb5jhptsktfwhcb3@linutronix.de>
References: <488a615d-8256-3dc6-9e9d-8101adca3126@pixelsurmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: thierry bultel <tbultel@pixelsurmer.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdBCPuf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2017 10:50:35 -0500
Content-Disposition: inline
In-Reply-To: <488a615d-8256-3dc6-9e9d-8101adca3126@pixelsurmer.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-31 17:05:28 [+0100], thierry bultel wrote:
> Hi,
Hi,

…
> To reproduce this very easily, I generate interrupts by just keeping
> the return key pressed in the serial console.
> It it also reproducible, by performing a 'ping -f' from another machine.
> 
…

> #define MY_PRIORITY (49) /* we use 49 as the PRREMPT_RT use 50
>                                 as the priority of kernel tasklets
>                                 and interrupt handler by default */
> 
…
> 	param.sched_priority = MY_PRIORITY;
> 	if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {

If I read this right your application has a lower priority than the
threaded interrupt which means the interrupt will be preferred over the
application. This in turn means the your application won't wake up in
time if there is an interrupt pending. However the kworker should not
block the application.

Sebastian
