Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAEEC43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Jul 2022 09:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiGYJ64 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYJ6z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jul 2022 05:58:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A65217050
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jul 2022 02:58:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658743131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wH1BExxiybvI2wkJmobiMffdd3Nq9/1eA+Ox9dHBHvo=;
        b=wkYWGX0TztUmnNKcTCAniYSA8xrOG34DJew4mvk8PcNLqgX/9jqQgXhkD+17MJbw+Y0MR9
        vCnTqeMP7qoG53whx0pZ/5SE0hnPuRCVY94+s441+HvNIh9Nlh6ENewVoQBcCmEIDyOM1D
        yXjLhaY/O+Um4SbPDySMAOlgrjP7XNUSn89rG0JBvLSHmaW8vTYFjoiZoPS0UPToZFBAjL
        opvfMON7syhS531G2MsFlFAw1qWSpx2M68Cf8GYflombG3ArsS+4e09aoKQTlvlplG9qI3
        EstnixOLzEjVhgqpz51KQ3FxeGpNi8jShZgJE3Rt1oDAI/MaYghlYfNmkXNbAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658743131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wH1BExxiybvI2wkJmobiMffdd3Nq9/1eA+Ox9dHBHvo=;
        b=xBmXWagE8HAYgU78dbIF0EW+SQJw+MHTRkKIWiclqsk3XcvV9bz3+84vktzhZ0Fs5+a/e9
        bQ+8rN/7xCudm3Aw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>, Petr Mladek <pmladek@suse.com>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
In-Reply-To: <Yt5RDajSVTPqahV4@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
 <87tu8a16bm.fsf@jogness.linutronix.de>
 <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
 <Yt5RDajSVTPqahV4@linutronix.de>
Date:   Mon, 25 Jul 2022 12:04:50 +0206
Message-ID: <87h735ikdh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-07-25, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> I remember asking why it is needed to disable interrupts across
> vsnprintf(). John, can I take this as-it or are you sending a new
> batch?

Mike's patch only addresses the vsnprintf() to print the prefix and get
the message length. There is also a vscnprintf() for the message itself,
which is still happening with interrupts disabled (see
printk_sprint()). I suppose this patch side-steps the splat because the
first vsnprintf() already triggered the random bytes for the pointer
hash.

I am preparing a new series that addresses this by completely removing
interrupt disabling from the printk() path. This required changes to the
printk_enter() macro, recursion handling, and the printk-ringbuffer
itself.

The focus of my new series are the various non-RT issues reported during
the early 5.19-rc cycles. I still need more time to get the series into
shape for LKML.

If Mike's patch is reliably side-stepping the issue, feel free to take
it.

>> Bandaid:
>> 
>> printk: fix RT vprintk_store() might sleep splat
>> 
>> RT can't call vsnprintf() with IRQs disabled, so disable migration
>> and move the printk_enter_irqsave() call down to where it's needed.

It might be worth mentioning that vscnprintf() is called later in
vprintk_store() when interrupts are disabled, but since it is s-printing
the same string (and probably the same values), new random bytes are not
required. (But someone should verify the reasoning here. I am not really
familiar with the crng code.)

John Ogness
