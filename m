Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4019C432BE
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA146125F
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 18:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhHVSPG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 22 Aug 2021 14:15:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhHVSPF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Aug 2021 14:15:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F299F1042;
        Sun, 22 Aug 2021 11:14:23 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31053F5A1;
        Sun, 22 Aug 2021 11:14:20 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 2/4] sched: Introduce migratable()
In-Reply-To: <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-3-valentin.schneider@arm.com> <20210817170925.2jwqvgvmqab2glwu@linutronix.de>
Date:   Sun, 22 Aug 2021 19:14:18 +0100
Message-ID: <87czq573et.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 17/08/21 19:09, Sebastian Andrzej Siewior wrote:
> On 2021-08-11 21:13:52 [+0100], Valentin Schneider wrote:
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index debc960f41e3..8ba7b4a7ee69 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
>>  #endif
>>  }
>>
>> +/* Is the current task guaranteed to stay on its current CPU? */
>> +static inline bool migratable(void)
>
> I'm going to rename this in my tree to `is_migratable' because of

<snip>

Thanks for carrying it through, I'll keep that change for the next version.

> Sebastian
