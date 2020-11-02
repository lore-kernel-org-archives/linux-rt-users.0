Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA7C4742C
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464E222265
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oK4FPmPw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQ8ahCSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgKBRbC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:31:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBRbC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 12:31:02 -0500
Date:   Mon, 2 Nov 2020 18:30:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604338261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+QpqnjE6E/5+Q3fwNB6ElCmFdxfCt+bWb4v2G7CJyE=;
        b=oK4FPmPw2mPwChhj9VsLElxvw2Od2tVdZNrtySxXNLWgMtXVkjcQVgmlCv/Q/R5tFLmzqT
        L+aEcodF0H5w01D5j0dqnaFvWofbuVY5l458hI+OZjQJwAlU5VKY4irYm0v5+uFh6Ruedj
        VW9XOhKFvBk5mNrKkqN52nSSYa/SRiC6F8pcC1IOLO0P+aUlCPpCh7l/JlKentZRXM/R7P
        wmqRVRqAU4dh54jMH2ERsfDe5pOSHowuEtVJTeOKVDeIPJToTkCKgHoJ5H14gVXOjRyEXd
        qMrJEI8XK3oUSA+yGyvNq9p4+A+vZLFGJPFjL7kalsAbnABlQF8NJF47BJARyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604338261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+QpqnjE6E/5+Q3fwNB6ElCmFdxfCt+bWb4v2G7CJyE=;
        b=YQ8ahCSzBgEWaMSssBocgPvOO1KpMEgOWJAz6tibfz0vjmo82pI5I7wXJtv/1HSSyrUO67
        6FCxNT9mz5h7IqCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102173059.ib4au7ia5vyynn6l@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
 <20201102162514.GA18631@redhat.com>
 <20201102163411.izhdlegaifq544l2@linutronix.de>
 <20201102170132.GA32111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102170132.GA32111@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-02 18:01:33 [+0100], Oleg Nesterov wrote:

> So it seems I should send V2 which uses raw_spin_(un)lock_irq().
> 
> Or even _irqsave() like ptrace_freeze_traced() does? Although this looks
> confusing, exactly because ptrace_freeze_traced() calls task_is_traced()
> which does raw_spin_lock_irq().

Urgh. Judging from
 release_task()
 -> write_lock_irq(&tasklist_lock);
 -> ptrace_release_task();
    -> ptrace_unlink();
       -> __ptrace_unlink();
         -> task_is_traced().

it will break on !RT so irqsave is indeed needed. And yes, using
task_is_traced() and then acquired the PI lock again looks like too
much.

Either complain or send a patch, I will look tomorrow.

> Oleg.

Sebastian
