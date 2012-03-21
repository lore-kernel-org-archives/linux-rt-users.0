From: John Kacur <jkacur@redhat.com>
Subject: Re: Different priorities for different softirqs
Date: Wed, 21 Mar 2012 16:00:07 +0100
Message-ID: <CAONaPpEh1CmYQDMU96hviW7-+gNxTJrGaAur=SmY9Ay2p4qWSA@mail.gmail.com>
References: <013401cd0763$1bd93970$538bac50$@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Christian Meier <chmeie@gmx.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54698 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab2CUPAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 11:00:07 -0400
Received: by pbcun15 with SMTP id un15so847156pbc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 08:00:07 -0700 (PDT)
In-Reply-To: <013401cd0763$1bd93970$538bac50$@gmx.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 21, 2012 at 2:04 PM, Christian Meier <chmeie@gmx.com> wrote=
:
> Hi,
>
> On https://rt.wiki.kernel.org/articles/r/t/_/RT_PREEMPT_HOWTO_6bc9.ht=
ml I
> noticed that there are different softirq kthreads for every softirq. =
So they
> could be prioritized differently.
> In my rt-patched kernels 3.2.11-rt20 and 3.0.24-rt42 I can only see o=
ne
> ksoftirqd instance per cpu.
>
> I did not find any hints in kernel/softirq.c where each of those kthr=
eads is
> generated. I only see ksoftirqd.
>
> From RT_PREEMPT_HOWTO_6bc9.html:
> ...
> 2 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-high/0]
> 3 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-timer/0]
> 4 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-net-tx/]
> 5 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-net-rx/]
> 6 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-block/0]
> 7 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-tasklet]
> 8 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-hrtreal]
> 9 ? =A0 =A0 =A0 =A0S =A0 =A0 =A00:00 [softirq-hrtmono]
> ...
>

You can read the section on Software interrupts here too to learn a
bit about the change.
https://lwn.net/Articles/464180/

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
