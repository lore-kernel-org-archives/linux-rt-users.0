Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4601C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 12:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A15C60F5A
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKBMrk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhKBMrj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Nov 2021 08:47:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F96260EB8;
        Tue,  2 Nov 2021 12:45:03 +0000 (UTC)
Date:   Tue, 2 Nov 2021 08:45:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] printk's sync mode for ftrace_dump()
Message-ID: <20211102084502.5c5a7580@gandalf.local.home>
In-Reply-To: <20211102122048.wtjcrcar3ss2akdb@linutronix.de>
References: <20211029102603.4qp4g5bzuydrbkrx@linutronix.de>
        <87y26c9ja6.fsf@jogness.linutronix.de>
        <20211102122048.wtjcrcar3ss2akdb@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2 Nov 2021 13:20:48 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> This can be triggered not only by sysrq. panic-on-oops seems to do the
> right thing. It seems that it makes sense to have this sync-mode always
> while ftrace_dump() is running.
> But then any sysrq-request has this limitation so maybe any sysrq should
> force sync-mode. But the sysrq request itself could be redirected into
> printing thread unless the system has some kind of scheduling problem.
> The printing request may not disable interrupts for the whole time as it
> is the case with the trace buffer so it would be possible to wait until
> printing is done if done from the printing thread.
> An additional sysrq to trigger the sync mode seems to be problematic
> because people might not be aware of it. Also, what is it point of
> sysrq-t if you see the last few entries?

Looking at ftrace_dump(), I'm not sure we need interrupts disabled. I think
that was there because it was created for panic only, but today I believe
the ring buffer is more robust, and it does disable everything before
reading the ring buffer. We may want to add some logic to make sure the
user doesn't re-enable tracing while the dump is happening. Or maybe we
don't care. If the user wants the dump to never end, let them re-enable it
;-)

I can write a patch to remove the irq disabling, or at least (to be on the
safe side) to enable it before entering the loop.

-- Steve
