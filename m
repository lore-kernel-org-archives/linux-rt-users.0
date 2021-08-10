Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34283C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF2E6024A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhHJNEw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:04:52 -0400
Received: from foss.arm.com ([217.140.110.172]:54952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237619AbhHJNEv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 09:04:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC8B1FB;
        Tue, 10 Aug 2021 06:04:29 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1B23F70D;
        Tue, 10 Aug 2021 06:04:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 2/4] sched: Introduce is_pcpu_safe()
In-Reply-To: <YRJ1yvfRjDJpXZWf@boqun-archlinux>
References: <20210807005807.1083943-1-valentin.schneider@arm.com> <20210807005807.1083943-3-valentin.schneider@arm.com> <800ff941e3ec86ea1397cddf8ecea3d4a17c55dc.camel@gmx.de> <87a6lrap5z.mognet@arm.com> <YRJ1yvfRjDJpXZWf@boqun-archlinux>
Date:   Tue, 10 Aug 2021 14:04:16 +0100
Message-ID: <87wnot8n8v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/08/21 20:49, Boqun Feng wrote:
> On Sun, Aug 08, 2021 at 05:15:20PM +0100, Valentin Schneider wrote:
>> On 07/08/21 03:42, Mike Galbraith wrote:
>> > On Sat, 2021-08-07 at 01:58 +0100, Valentin Schneider wrote:
>> >>
>> >> +static inline bool is_pcpu_safe(void)
>> >
>> > Nit: seems odd to avoid spelling it out to save two characters, percpu
>> > is word like, rolls off the ole tongue better than p-c-p-u.
>> >
>> >       -Mike
>> 
>> True. A quick grep says both versions are used, though "percpu" wins by
>> about a factor of 2. I'll tweak that for a v3.
>
> I wonder why is_percpu_safe() is the correct name. The safety of
> accesses to percpu variables means two things to me:
>
> a)	The thread cannot migrate to other CPU in the middle of
> 	accessing a percpu variable, in other words, the following
> 	cannot happen:
>
> 	{ percpu variable X is 0 on CPU 0 and 2 on CPU 1
> 	CPU 0				CPU 1
> 	========			=========
> 	<in thread A>
> 	__this_cpu_inc(X);
> 	  tmp = X; // tmp is 0
> 	  <preempted>
> 	  <migrate to CPU 1>
> 	  				// continue __this_cpu_inc(X);
> 					X = tmp + 1; // CPU 0 miss this
> 						     // increment (this
> 						     // may be OK), and
> 						     // CPU 1's X got
> 						     // corrupted.
>
> b)	The accesses to a percpu variable are exclusive, i.e. no
> 	interrupt or preemption can happen in the middle of accessing,
> 	in other words, the following cannot happen:
>
> 	{ percpu variable X is 0 on CPU 0 }
> 	CPU 0
> 	========
> 	<in thread A>
> 	__this_cpu_inc(X);
> 	  tmp = X; // tmp is 0
> 	  <preempted>
> 	  <in other thread>
> 	  this_cpu_inc(X); // X is 1 afterwards.
> 	  <back to thread A>
> 	  X = tmp + 1; // X is 1, and we have a race condition.
>
> And the is_p{er}cpu_safe() only detects the first, and it doesn't mean
> totally safe for percpu accesses.
>

Right. I do briefly point this out in the changelog (the bit about
"acquiring a sleepable lock if relevant"), but that doesn't do much to
clarify the helper name itself.

> Maybe we can implement a migratable()? Although not sure it's a English
> word.
>

Funnily enough that is exactly how I named the thing in my initial draft,
but then I somehow convinced myself that tailoring the name to per-CPU
accesses would make its intent clearer.

I think you're right that "migratable()" is less confusing at the end of
the day. Oh well, so much for overthinking the naming problem :-)

> Regards,
> Boqun
