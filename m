Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B0C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 21:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C5D61BB3
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 21:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhKPVFu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:05:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPVFu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 16:05:50 -0500
Date:   Tue, 16 Nov 2021 22:02:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637096571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBHs0v/DRYrmYPb4+ZG5g0FFfV8r/vqdStHVilbYAv4=;
        b=vLe3wZf8kI23BrtHAm8ywEC1iq13uoU7tWSO6HsoeJcxGu4/GJmz37O5OoqYt6ROP3OV5x
        NntrbXziJmQuOvLIm/OOrigYQEDlQAPZXzITV0GfYi+ccXxBMGfGEfLcyYfAV0rgWTvLS0
        PF+7ogH4MMfYgT6Rjr2nyY/+bMuQIWjRn7vf8y3tBhSQBP2ZMDhd1261QflGgAD2yxUKUQ
        JgFzhR6xAdeshozX/r55ak75pSoH+0UtSvIQEM6UAYlbaP2EjhxdFnREZe5IsgkbKILgQb
        b5iOyLa+4wSr0UU3WkeFiLCGd499Q9xfDqKwkP/qG+2hP4lJ7un+4jZCRvkj2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637096571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBHs0v/DRYrmYPb4+ZG5g0FFfV8r/vqdStHVilbYAv4=;
        b=q2WoW6K7n4R/4cfJ9cKjQmqg3UEBbCxyH2t+R2DTVLyoMPX8mrw7aZ3WkKb6TkN99KamHa
        wySxa99CvanVUCCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211116210249.t3f6gw56iaow57mq@linutronix.de>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
 <20211007171929.hegwwqelf46skjyw@linutronix.de>
 <20211009164908.GA21269@zipoli.concurrent-rt.com>
 <20211116152534.122f8357@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116152534.122f8357@gandalf.local.home>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-16 15:25:34 [-0500], Steven Rostedt wrote:
> I'm looking to see what needs to be added to 5.10-rt. Is there a particular
> fix in one of the 5.x-rt trees (x > 10) that I can pull from? Or is this
> only an issue with 5.10 and below?

I have this:
  https://lore.kernel.org/all/20211026114100.2593433-1-bigeasy@linutronix.de

pending vs upstream and I *think* more than just that one (2/9 from the
series) needs to be backported here. We do have 1/9 differently in 5.10,
not sure about 4/9.
I would love more feedback here from people and I tried to motivate Joe
to provide some. Clark was so nice to test these patches and provide
feedback. My i915 does not trigger all the code paths I'm touching
there.

If you think that 2/9 is obvious enough, please go ahead. If you start
touching that irq_work area then you might also want to pick
  810979682ccc9 ("irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.")
  b4c6f86ec2f64 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
  09089db79859c ("irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT")

which made their way into v5.16-rc1.

> -- Steve

Sebastian
