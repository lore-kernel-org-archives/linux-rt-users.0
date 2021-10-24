Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408DC433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Oct 2021 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3E760F46
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Oct 2021 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJXPyT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:54:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXPyS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 24 Oct 2021 11:54:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A6AD6E;
        Sun, 24 Oct 2021 08:51:57 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C2C63F5A1;
        Sun, 24 Oct 2021 08:51:56 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/3] irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
In-Reply-To: <87pmrwt6l5.wl-maz@kernel.org>
References: <20211022103307.1711619-1-valentin.schneider@arm.com> <20211022103307.1711619-3-valentin.schneider@arm.com> <87pmrwt6l5.wl-maz@kernel.org>
Date:   Sun, 24 Oct 2021 16:51:53 +0100
Message-ID: <87a6iyju92.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23/10/21 10:48, Marc Zyngier wrote:
> On Fri, 22 Oct 2021 11:33:06 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> @@ -5202,6 +5205,39 @@ int its_cpu_init(void)
>>      return 0;
>>  }
>>
>> +#ifdef CONFIG_EFI
>
> Why do we need this? I can't see anything that'd be problematic even
> if EFI was disabled.
>

You're right, that's not required.

>> +static int its_cpu_memreserve_lpi(unsigned int cpu)
>> +{
>> +	struct page *pend_page = gic_data_rdist()->pend_page;
>> +	phys_addr_t paddr;
>> +
>> +	/*
>> +	 * If the pending table was pre-programmed, free the memory we
>> +	 * preemptively allocated.
>> +	 */
>> +	if (pend_page &&
>> +	    (gic_data_rdist()->flags & RDIST_FLAGS_PENDTABLE_PREALLOCATED)) {
>> +		its_free_pending_table(gic_data_rdist()->pend_page);
>> +		gic_data_rdist()->pend_page = NULL;
>> +	}
>
> So you set it to NULL and carry on, ending up reserving a 64kB block
> at address 0 if the RESERVED flag isn't set. Can this happen at all?
> If, as I suspect, it cannot happen because the two flags are always
> set at the same time, why do we need two flags?
>

PREALLOCATED implies RESERVED, but the reverse isn't true.

> My gut feeling is that if pend_page is non-NULL and that the RESERVED
> flag is set, you should free the memory and leave the building.
> Otherwise, reserve the memory and set the flag. PREALLOCATED doesn't
> seem to make much sense on a per-CPU basis here.
>

One thing I was concerned about is that this cpuhp callback can be invoked
more than once on the same CPU, even with the removal in patch 3.
Consider a system with maxcpus=X on the cmdline; not all secondaries will
be brought up in smp_init(). You then get to userspace which can issue all
sorts of hotplug sequences. Let me try to paint a picture:

  maxcpus=2

  CPU0                      CPU1                      CPU2

  its_init()                                          <nothing ever happens here>
  [...]
  its_cpu_memreserve_lpi()
    flags |= RESERVED
  [...]
  smp_init()
                            its_cpu_memreserve_lpi()
                              flags |= RESERVED

                         [.....]

  cpu_down(CPU1, CPUHP_OFFLINE)
  cpu_up(CPU1, CPUHP_ONLINE)

                            its_cpu_memreserve_lpi()
                              // pend_page != NULL && (flags & RESERVED) != 0
                              // we musn't free the memory

Now, my approach clearly isn't great (I also went through the "wait those
two flags are the same thing" phase, which in hindsight wasn't a good sign).
What we could do instead is only have a PREALLOCATED flag (or RESERVED; in
any case just one rather than two) set in its_cpu_init_lpis(), and ensure
each CPU only ever executes the body of the callback exactly once.

  if (already_booted())
      return 0;

  if (PREALLOCATED)
      its_free_pending_table();
  else
      gic_reserve_range();

  out:
    // callback removal faff here
    return 0;

Unfortunately, the boot CPU will already be present in
cpus_booted_once_mask when this is first invoked for the BP, so AFAICT we'd
need some new tracking utility (either a new RDIST_LOCAL flag or a separate
cpumask).

WDYT?
