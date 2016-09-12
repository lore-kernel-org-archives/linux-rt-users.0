From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Mon, 12 Sep 2016 12:07:32 +0200
Message-ID: <20160912100732.g7eq5phzpqqqdoh5@linutronix.de>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
 <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
 <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
 <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
 <1e95689e-ae42-7f47-03ff-732f1bc4841c@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbcILKHh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Sep 2016 06:07:37 -0400
Content-Disposition: inline
In-Reply-To: <1e95689e-ae42-7f47-03ff-732f1bc4841c@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-12 11:16:55 [+0200], Stanislav Meduna wrote:
> On 9/8/2016 12:36 PM, Jens Koehler wrote:
> 
> > disable preemption during CR3 read+write
> 
> This got my attention as I have hunted some very similar looking
> thing 3 years ago:
> 
> https://lkml.org/lkml/2013/5/17/109

This looks like the same thing. Repeated pagefault on UP, no help after
rewrite of the PTE.

> Coud it explain this? I am unfortunately not able to quickly
> reproduce the environment back then.
What do you want me to explain? I don't remember the thread from back
then. I probably skipped it because we had Steven, Rik, Linus and HPA
looped in.

Sebastian
