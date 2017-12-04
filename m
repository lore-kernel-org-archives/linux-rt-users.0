From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: better performance during stress
Date: Mon, 4 Dec 2017 20:11:29 +0100
Message-ID: <6257f93e-449f-659a-fbe4-8dd7b3941d50@bristot.me>
References: <CAJ2oMhJX7hVzB0DEjvtuCmP+AAenYhR_yQZWCbGD2pOjOpFzNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ran Shalit <ranshalit@gmail.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-247.kinghost.net ([177.185.201.247]:40034 "EHLO
        smtpi-sp-247.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbdLDTSx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 14:18:53 -0500
In-Reply-To: <CAJ2oMhJX7hVzB0DEjvtuCmP+AAenYhR_yQZWCbGD2pOjOpFzNg@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/04/2017 06:06 PM, Ran Shalit wrote:
> Hello,
> 
> 
> I would like to ask if anyone familiar with results showing better
> performance during stress.
> We expected (and seen) usually degraded performance during stress, so
> such result is a surprise.
> I use cyclictest and see that both average and maximum have lower
> value during stress.
> The chip is i7.

Stress runs a busy loop in user-space, hence the preempt/irqs are 
always enabled. Moreover, it avoids letting the processor going to idle, 
avoiding "exit from idle" latencies.

Using a stress thread per CPU will probably give you better results than 
just letting the system going idle.

You should use rteval as a workload:

https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/rteval

-- Daniel
> Thank you.
> Ran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
