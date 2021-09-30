Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A4C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869CB61139
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbhI3NY3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:24:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348651AbhI3NY3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC08D6E;
        Thu, 30 Sep 2021 06:22:46 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414EA3F793;
        Thu, 30 Sep 2021 06:22:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
In-Reply-To: <20210930105340.GA232241@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-4-valentin.schneider@arm.com> <874kae6n3g.ffs@tglx> <87pmt163al.ffs@tglx> <87h7e21lqg.mognet@arm.com> <20210930105340.GA232241@lothringen>
Date:   Thu, 30 Sep 2021 14:22:36 +0100
Message-ID: <87ee9619lv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 30/09/21 12:53, Frederic Weisbecker wrote:
> On Thu, Sep 30, 2021 at 10:00:39AM +0100, Valentin Schneider wrote:
>> My reasoning for adding protection in the outer functions was to prevent
>> impaired unlocks of rcu_nocb_{un}lock_irqsave(), as that too depends on the
>> offload state. Cf. Frederic's writeup:
>>
>>   http://lore.kernel.org/r/20210727230814.GC283787@lothringen
>
> I was wrong about that BTW!
> Because rcu_nocb_lock() always require IRQs to be disabled, which of course disables
> preemption, so the offloaded state can't change between
> rcu_nocb_lock[_irqsave]() and rcu_nocb_unlock[_irqrestore]() but anyway there
> were many other issues to fix :-)
>

Ooooh... Even with you pointing it out, it took me a while to see it that
way. It's tough to get out of holidays mode :-)
