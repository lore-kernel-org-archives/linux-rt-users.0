Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C774AC4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE2D610A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhHSSqD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:46:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSSqC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 14:46:02 -0400
Date:   Thu, 19 Aug 2021 20:45:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629398724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4UXnzMfZvo21+qH0D9x+E2yduVvhbA6kY0FK1l9dpa0=;
        b=r0VgNT/V6SnEJV2fkublSFgBCUaXTtNdQEKhTBBeaFDdLTD0kqhZyKtjDFaGWLqD9NvQvP
        yA+lKsFNPNmoJwqRW/t3dGKBbNns3K0YgtdjrM5vOXIantOk/shuWg3J3hfZ3gqTiIw6F4
        TbfEs8eZ677p+Ik3QionHwuLzgVWu1dykPQ3ZTDkX55FtttNUVTtP/hr8S7mY/uXjvCKcs
        HlGEU6hcNWr/X/+lpli9Bu5wudplM4GYCWqVv7MyhqMcnrfALlUUWVyOrQmr6ipYkk/8EY
        eEEKrI5u/n27v+pPKSYQD+PRU0oj3zteckkqNBq2HyT5bzlDpgoLEYQHFO/+pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629398724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4UXnzMfZvo21+qH0D9x+E2yduVvhbA6kY0FK1l9dpa0=;
        b=3cbQlYvV2BF95EtcaMtqiJGkGyniOF0Pp3h5tATTe5DCvmGv8CL6h6oB85mgR22wMGo5JN
        gLKOpd2mU52oD7Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        Mike Galbraith <efault@gmx.de>, Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
Message-ID: <20210819184523.laa5vwvfsgotbgx5@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210819153927.clqxr4f7qegpflbr@linutronix.de>
 <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
 <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-19 11:20:35 [-0700], Paul E. McKenney wrote:
> > This piece above, I don't understand. I had it running for a while and
> > it didn't explode. Let me try TREE01 for 30min without that piece.
>=20
> This might be historical.  There was a time when interrupts being
> disabled across rcu_read_unlock() meant that preemption had to have
> been disabled across the entire RCU read-side critical section.
>=20
> I am not seeing a purpose for it now, but I could easily be missing
> something, especially given my tenuous grasp of RT.

Okay. So the 30min test didn't trigger any warnings=E2=80=A6

> Either way, looking forward to the next version!

Good. So if you liked what you have seen then I'm going to resubmit the
above as a proper patch then.
Thanks!

> 							Thanx, Paul

Sebastian
