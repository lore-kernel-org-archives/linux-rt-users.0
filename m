From: Ashoka K <ashok.vinu@gmail.com>
Subject: Re: How to find long execution times in kernel threads?
Date: Wed, 1 May 2013 09:28:11 +0530
Message-ID: <CALJd4cYC87FKOO+bJRpiije1SS5onVuas=ez_mDBRyN3XUL+Rg@mail.gmail.com>
References: <517FCBA3.1000909@meduna.org>
	<517FF6B1.9050204@osadl.org>
	<5180072F.7010102@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44465 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759701Ab3EAD6M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 23:58:12 -0400
Received: by mail-qc0-f170.google.com with SMTP id d42so572807qca.1
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Apr 2013 20:58:11 -0700 (PDT)
In-Reply-To: <5180072F.7010102@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Even i had some issues in schedule latencies. i tried to use trace-cmd
record -e all and kernelshark.
What i found was since it is run as a separate process it also need to
get scheduled to get the traces and by default it is get scheduled in
SCHED_OTHER. This tracing is also affected by the values in
  /proc/sys/kernel/sched_rt_runtime_us  and  sched_rt_period_us.

So what i understood is for initial measurements kernelshark is a good
tool, but to go more deep this is not enough.
May be profiling tools like OPROF should be good. I am still exploring this.

Regards
Ashoka.  K


On Tue, Apr 30, 2013 at 11:32 PM, Stanislav Meduna <stano@meduna.org> wrote:
> On 30.04.2013 18:52, Carsten Emde wrote:
>
>> Sure, record everything (trace-cmd record -e all) and analyze the
>> traces.
>
> Well, the problem is that with record -e all I get 20 ms instead
> of 1 ms, so I'd say Mr. Heisenberg laughs at me loudly here ;)
>
> Thanks for the pointer anyway, I'll try to thoroughly read
> the available documentation and come up with some sane set
> of filters to start with.
>
> Thanks
> --
>                                       Stano
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
