From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Current Best Practices for periodic threads
Date: Fri, 29 Dec 2017 09:46:53 +0100
Message-ID: <b89e9e30-6389-27b1-91b6-03e76a5c54a7@meduna.org>
References: <CAF_dkJDZ+OH5f6mad_zLmHgLq-ysESj984JQ5XTkteN+8Ldwqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Patrick Doyle <wpdster@gmail.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:46043 "EHLO meduna.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdL2JHI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Dec 2017 04:07:08 -0500
In-Reply-To: <CAF_dkJDZ+OH5f6mad_zLmHgLq-ysESj984JQ5XTkteN+8Ldwqg@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 28.12.2017 17:55, Patrick Doyle wrote:

> What are the current best practices for creating periodic threads with
> real-time Linux?
> 
> Do folks primarily use timerfd?
> 
> Do folks primarily use POSIX timers and sigwait?

In our company we are using clock_nanosleep on the monotonic clock,
either absolute or relative. From my - not rigorous - observation
this is the easiest to use with least overhead and jitter. As far
as I remember timerfd was fine as well.

Using POSIX timers involves another kernel thread, meaning both
unnecessary context switches (on some platforms the latencies
are not negligible) and funny effects if one is not careful
to set the priority of this thread accordingly (the default
is unusable).

> On a somewhat related topic... how do folks stagger the startup of
> periodic threads?  For example, suppose one (high priority) thread
> needs to run every 20ms, only takes 1ms to do its work, but _really_
> needs to run on that 20ms clock.  Now suppose some other thread needs
> 4ms out of every 20ms to accomplish it's work.
This really depends on the particular application. If you can't
afford these threads to preempt one another, precalculated absolute
wakeup times are probably the easiest solution.

Regards
-- 
                                   Stano
