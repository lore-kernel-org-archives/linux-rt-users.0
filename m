From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: better performance during stress
Date: Tue, 5 Dec 2017 12:16:18 +0100
Message-ID: <18ac2e10-1c2b-966d-448e-dda3c98aca71@bristot.me>
References: <CAJ2oMhJX7hVzB0DEjvtuCmP+AAenYhR_yQZWCbGD2pOjOpFzNg@mail.gmail.com>
 <6257f93e-449f-659a-fbe4-8dd7b3941d50@bristot.me>
 <CAJ2oMhJr9tneahx0B=Dx8ZxbRna15zhr3+BUh3OwQ8iBMTx_CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-226.kinghost.net ([177.185.201.226]:53631 "EHLO
        smtpi-sp-226.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdLELQ2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 06:16:28 -0500
In-Reply-To: <CAJ2oMhJr9tneahx0B=Dx8ZxbRna15zhr3+BUh3OwQ8iBMTx_CA@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/04/2017 09:29 PM, Ran Shalit wrote:
>> Stress runs a busy loop in user-space, hence the preempt/irqs are
>> always enabled.
> I understand the comments that comes later, but not this one above.
> Can you please explain?
> 

A "latency" you see on cyclictest is a side effect of either IRQs being
masked, or the preemption being disabled.

However, a process always returns to user-space with both interrupts and
preemption enabled. So, a task in user-space will not cause latencies.

As stress runs a busy loop in user-space... it will not cause latencies.

-- Daniel
