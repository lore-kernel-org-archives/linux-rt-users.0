From: Stanislav Meduna <stano@meduna.org>
Subject: Re: pagefaults ...
Date: Fri, 14 Jun 2013 09:45:17 +0200
Message-ID: <51BACA0D.2000907@meduna.org>
References: <CAF-VNaq1UQQW7MZUQ5N7nmvF_FFboXr4yn8CHaMzUGL6qndQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:48879 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab3FNHp1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Jun 2013 03:45:27 -0400
In-Reply-To: <CAF-VNaq1UQQW7MZUQ5N7nmvF_FFboXr4yn8CHaMzUGL6qndQXA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14.06.2013 07:18, Lars Segerlund wrote:

>  I have an application which should be realtime but apparently
> generates page faults from a realtime context, I am trying to find a
> way to get a stacktrace when this occurs, does anybody have any ideas
> ?

Couuld you say more about your environment? Processor, kernel version,
what does you application do, how and when it is reproducible,
are these major or minor faults, ...?

If the system looks fine it is probably not the problem
I am hunting ( https://patchwork.kernel.org/patch/2581631/ )
but please look there whether you find some similarities.
I am still not able to reproduce that...

> I looked at ftrace and perf but haven't figured out how to get a
> trace from the app, but I figured this must have occured before so I
> better ask first.

For the start you can implant trace_printk into handle_pte_fault
to record the faulting address and then look in the /proc/<pid>/maps
where that address is.

For deciding when to stop the trace you can poll /proc/<pid>/task/<tid>/stat
and evaluate number of page faults. If you also enable tracing
the syscalls you can get an idea what the application was doing
right before it happened.

Basic questions:

- do you call mlockall(MCL_CURRENT | MCL_FUTURE) _before_ your
  threads are started?

- do the faulting threads allocate memory?

- do the faulting threads call kernel functions that might allocate memory?


Regards
-- 
                                      Stano

