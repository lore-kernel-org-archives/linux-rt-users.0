Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1846C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D615660C3F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 09:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhHJJ0p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhHJJ0o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 05:26:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE7DD6E;
        Tue, 10 Aug 2021 02:26:22 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF863F718;
        Tue, 10 Aug 2021 02:26:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
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
In-Reply-To: <YRHnjQqf28/uFq+Z@boqun-archlinux>
References: <20210807005807.1083943-1-valentin.schneider@arm.com> <20210807005807.1083943-3-valentin.schneider@arm.com> <YRHnjQqf28/uFq+Z@boqun-archlinux>
Date:   Tue, 10 Aug 2021 10:26:15 +0100
Message-ID: <871r71abwo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 10/08/21 10:42, Boqun Feng wrote:
> Hi,
>
> On Sat, Aug 07, 2021 at 01:58:05AM +0100, Valentin Schneider wrote:
>> Some areas use preempt_disable() + preempt_enable() to safely access
>> per-CPU data. The PREEMPT_RT folks have shown this can also be done by
>> keeping preemption enabled and instead disabling migration (and acquiring a
>> sleepable lock, if relevant).
>> 
>> Introduce a helper which checks whether the current task can safely access
>> per-CPU data, IOW if the task's context guarantees the accesses will target
>> a single CPU. This accounts for preemption, CPU affinity, and migrate
>> disable - note that the CPU affinity check also mandates the presence of
>> PF_NO_SETAFFINITY, as otherwise userspace could concurrently render the
>> upcoming per-CPU access(es) unsafe.
>> 
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  include/linux/sched.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index debc960f41e3..b77d65f677f6 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
>>  #endif
>>  }
>>  
>> +/* Is the current task guaranteed not to be migrated elsewhere? */
>> +static inline bool is_pcpu_safe(void)
>> +{
>> +#ifdef CONFIG_SMP
>> +	return !preemptible() || is_percpu_thread() || current->migration_disabled;
>> +#else
>> +	return true;
>> +#endif
>> +}
>
> I wonder whether the following can happen, say thread A is a worker
> thread for CPU 1, so it has the flag PF_NO_SETAFFINITY set.
>
> 	{ percpu variable X on CPU 2 is initially 0 }
>
> 	thread A
> 	========
>
> 	<preemption enabled>
> 	if (is_pcpu_safe()) { // nr_cpus_allowed == 1, so return true.
> 		<preempted>
> 		<hot unplug CPU 1>
> 			unbinder_workers(1); // A->cpus_mask becomes cpu_possible_mask
> 		<back to run on CPU 2>
> 		__this_cpu_inc(X);
> 		  tmp = X; // tmp == 0
> 		  <preempted>
> 		  <in thread B>
> 		  this_cpu_inc(X); // X becomes 1
> 		  <back to run A on CPU 2>
> 		  X = tmp + 1; // race!
> 	}
>
> if so, then is_percpu_thread() doesn't indicate is_pcpu_safe()?
>

You're absolutely right.

migrate_disable() protects the thread against being migrated due to
hotplug, but pure CPU affinity doesn't at all. kthread_is_per_cpu() doesn't
work either, because parking is not the only approach to hotplug for those
(e.g. per-CPU workqueue threads unbind themselves on hotplug, as in your
example).

One could hold cpus_read_lock(), but I don't see much point here. So that
has to be 

  return !preemptible() || current->migration_disabled;

Thanks!
