Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeKHVZc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Nov 2018 16:25:32 -0500
Date: Thu, 8 Nov 2018 12:50:22 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT Summit 2018 & some advice on my application running ARM
 big.LITTLE
Message-ID: <20181108115022.qcgup4rttyuxfjdk@linutronix.de>
References: <CAP03XeopC7CYd9BxNpKe63q+FqW+Vs2iQ93r1a0gxHRZ5zfVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP03XeopC7CYd9BxNpKe63q+FqW+Vs2iQ93r1a0gxHRZ5zfVQg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Christopher Obbard <chris@64studio.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-10-26 18:53:45 [+0100], Christopher Obbard wrote:
> Hi Everyone,
Hi,

> One of the questions which came up yesterday was the scheduler and
> something I have not yet thought much around:
> We are just setting the audio DMA interrupt (edma_ccint) to a priority
> of around 95 with SCHED_FIFO, the jack server to 90 with also
> SCHED_FIFO.
> Now this seems to work quite well on the single core 1 GHz Beaglebone system.
> My first question: is there anything I am doing glaringly wrong here?

The default priority is 50 for threaded interrupts. If edma_ccint is the
only one responsible for audio processing then lifting it should be fine.
You could try to use the sched_switch tracer and check if there is some
forth-and-back switching between edma_ccint and another interrupt (in
case there is another one involved in audio processing).

> So now I am working on a project that needs much more performance so
> naturally I want to throwing multiple cores at it.
> I have found the Rockchip RK3399 which has two cores CortexA72 & four
> cores CortexA53 in a big.LITTLE style arrangement.
> 
> The story yesterday seemed that SMT is very bad and should be disabled
> with RT & ARM does not have this function so I am okay.
I wouldn't say "very bad" but yes, the actual performance of one HT may
vary depending how busy the other HT is and what it is doing. It depends
how bad it can get and how much of additional latency is still
acceptable for your case.

> The other topic mentioned was cache lines being shared between
> multiple cores causing a hard to reproduce outlier & from what I have
> read bigLITTLE shares cache lines between both processor types. So I
> think I am going to have to disable the HMP and use the 4 fast cores?

Two fast cores or four slow cores :)

I think it depends on what you and what do you try to achieve. If the
outlier are still in the range of "okay" then I wouldn't care much.
Usually the system is measured in the worst possible operating state and
checked if the measured latency is acceptable. That means load generating
applications like hackbench, disk-io or stress-ng (you name it) are run
and latency shouldn't suffer much. However if you start invaliding the
caches then the results get very bad.
>From what I can see in [0] is that those two are separated. I think
there is an interconnect between the L2 and the main memory.

What might be bad for you latency wise is if the task migrates from the big
to the little cluster. So task pinning on a RT system is always a good
especially in this case :)

[0] http://opensource.rock-chips.com/wiki_RK3399

> Can you at all offer some quick advice to see if I am on the right track?
> 
> 
> 
> Cheers!
> 
> Christopher Obbard
> 64 Studio Ltd.

Sebastian
