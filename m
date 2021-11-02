Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB5C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EE861078
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 12:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhKBMX1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:23:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBMX0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Nov 2021 08:23:26 -0400
Date:   Tue, 2 Nov 2021 13:20:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635855650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlxmZPbwGMd2K+zEWRMBGtlq0v1gPL3JEoXT48sOp70=;
        b=VxjMq9hmIxAMGNtfmKN20o9VSk+tkUULOr9PVMxPUajyL9fyfRdnhMYplF5bQJFzk0Xi/v
        G9mjhQMzVoNR+c8grq5GZRurttFb2pcj0n+E8SBiDJPyuPTY5l03kVPoJZoufiPvr9IXQb
        N0amPZnh64d/vkPzOAFGDwllKSa0XSKtMvZMHHf473PKB3G2NkDGT4KoYcbFKTKw2FxIm2
        8udu7QQT/sRYHrl7anwUjd+uJeonxLqHGWK62lXuLpOZ2F6bGPc7f74R0IJG2A9/kN5vCN
        pOJZwDUnODTizRfcJp5Hid0oAlLu3BvwBjZR7ABHACE2r+bIooXLgTKByur4KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635855650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlxmZPbwGMd2K+zEWRMBGtlq0v1gPL3JEoXT48sOp70=;
        b=8I5TW4IM0A43+Ds8reVoz9z5sd8VuD5jycdecnpIKpn+8XLuXS+DSCamHOj8JXUxA12IXF
        crdHO9pp/fK7eWCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] printk's sync mode for ftrace_dump()
Message-ID: <20211102122048.wtjcrcar3ss2akdb@linutronix.de>
References: <20211029102603.4qp4g5bzuydrbkrx@linutronix.de>
 <87y26c9ja6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y26c9ja6.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-29 13:18:33 [+0206], John Ogness wrote:
> On 2021-10-29, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > ftrace_dump() is used for instance by alt-sysrq-z / sysrq_ftrace_dump().
> > The function itself dumps the whole trace buffer in an irq-off section so
> > no need to talk about max latencies unless this is going to change.
> >
> > The output on the serial is more or less brief and starts with
> >     "** 397774 printk messages dropped **"
> > and so I do see only the end of it. Might be okay.
> > Any reason not to use the sync mode + atomic console while ftrace_dump()
> > is in progress?
> 
> Since latencies are not a concern, I see no reason not to use
> sync+atomic.
> 
> However, it does put us into the situation of beginning to define
> non-emergency scenarios where sync+atomic is used. That rabbit hole
> might go quite deep. I wonder if it might be better to introduce a new
> sysrq to toggle sync mode.

This can be triggered not only by sysrq. panic-on-oops seems to do the
right thing. It seems that it makes sense to have this sync-mode always
while ftrace_dump() is running.
But then any sysrq-request has this limitation so maybe any sysrq should
force sync-mode. But the sysrq request itself could be redirected into
printing thread unless the system has some kind of scheduling problem.
The printing request may not disable interrupts for the whole time as it
is the case with the trace buffer so it would be possible to wait until
printing is done if done from the printing thread.
An additional sysrq to trigger the sync mode seems to be problematic
because people might not be aware of it. Also, what is it point of
sysrq-t if you see the last few entries?

As per rabbit hole, I'm bringing my case to the high council.
I wouldn't mind if using the sync-mode would taint the kernel..

> John

Sebastian
