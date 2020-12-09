Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35115C1B0D8
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF14D23B5D
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 11:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgLILsV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:48:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46234 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgLILsU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 06:48:20 -0500
Date:   Wed, 9 Dec 2020 12:47:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607514458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zk1uCC8AVpm91rPCMOb5EhX60M1BujS5UBdmp1gdtTc=;
        b=joM2N4BvYsNJP9iQ7YNK/XYsMs8QF7pIF/wnRDwgMMRNh1pBh/HWIXeo3RP7Ob7kTapAb1
        opPPr5isBjaV+Uk7vLOqHVgUT+XfpX1mFU0AkvlK34k4Y5ye4uLu9l8bqiGUXiH70Epl0H
        VtTUxE8d+t5+7R0KCl/Y8A3hBfKR3QAhwVdwNcneLFnUZj4Dv8SsG02FHAO2z3HZts1bd6
        8xTq2nmSjJsN3wEo3yd8HKtp1F9Bor9hhF+3TcQbiAGxV/+KOglnqKQU2jDUJU6Jf/Mbup
        biWsZzc+jmCf+eLI+92kAGiMKWcueSiZfXdKSutjm4bnb++jZApCi7B0osVUEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607514458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zk1uCC8AVpm91rPCMOb5EhX60M1BujS5UBdmp1gdtTc=;
        b=2nf1YRvLwIOGYG2zzNam450itW+pZAs1uJn/0nSlGaoaJPI+MWf79jiHjlrcoEXJyJ3qte
        a5GVLJsVTGgNrzDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
Message-ID: <20201209114737.bvndv52pst4ownyc@linutronix.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
 <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-09 11:05:45 [+0100], Peter Zijlstra wrote:
> In general we have the rule that as long as a lock is only ever used
> from task context (like the above ilb->lock, afaict) then it doesn't
> matter if you also take it with (soft)irqs disabled or not. But this
> softirq scheme breaks that. If you ever take a lock with BH disabled,
> you must now always take it with BH disabled, otherwise you risk
> deadlocks against the softirq_ctrl lock.
> 
> Or am I missing something obvious (again) ?

No. With this explanation it makes sense. Thank you.

Sebastian
