Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA3AC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 08:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E79613B2
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Apr 2021 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhDMIkD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhDMIkB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Apr 2021 04:40:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F34C061574;
        Tue, 13 Apr 2021 01:39:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618303179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jH35UaKzKxFZTz+38gYIJANUU3Yo7Uur7vXQ1BzIgEk=;
        b=37o11+IJE6Kv3tz9VF5qjnqquXxAfDHUO2RR9dU9Xpmux/tJ1Ya0O/6QW6CUKYlUmUuki1
        yk6x5sCVYp2RE1qlZcIWXcXGqQDfqE6b9rofrEF1l4W9Bu0lQYPIOfrpp5EWCLyhuzoDKR
        noJFMLkdFwDHrZWh28dwY/D+ZLSb1kOl99Kr6aho0kZM/kJh+fV7SUV11cUs7VJmthm7UL
        AKwn9TvznInOZS8mMQW5TSE32SUcLDuiqiTY/lb3bdlnpMtoo3M4f5FisV70sLN19VaPqS
        CVZfdO4qHaiQJkI5PACVS5nXdWpseYGJ/CwRFLo7HhhKZaZyKXUfOXeYwTSDOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618303179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jH35UaKzKxFZTz+38gYIJANUU3Yo7Uur7vXQ1BzIgEk=;
        b=011t0SOknZVZ53KQHSyhMVFCxDt2tni3dqjnWNlIRFKqqHWC7xqzL5Cma/5WgHzAiCEXjC
        0oTt35aK0c0TSTBg==
To:     Song Chen <chensong_2000@189.cn>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, maz@kernel.org, joe@perches.com,
        romain.perier@gmail.com, john.garry@huawei.com
Subject: Re: [PATCH] kernel:irq:manage: request threaded irq with a specified priority
In-Reply-To: <1618294774-24370-1-git-send-email-chensong_2000@189.cn>
References: <1618294774-24370-1-git-send-email-chensong_2000@189.cn>
Date:   Tue, 13 Apr 2021 10:39:39 +0200
Message-ID: <875z0qzigk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 13 2021 at 14:19, Song Chen wrote:
> In general, irq handler thread will be assigned a default priority which
> is MAX_RT_PRIO/2, as a result, no one can preempt others.
>
> Here is the case I found in a real project, an interrupt int_a is
> coming, wakes up its handler handler_a and handler_a wakes up a
> userspace RT process task_a.
>
> However, if another irq handler handler_b which has nothing to do
> with any RT tasks is running when int_a is coming, handler_a can't
> preempt handler_b, as a result, task_a can't be waken up immediately
> as expected until handler_b gives up cpu voluntarily. In this case,
> determinism breaks.

It breaks because the system designer failed to assign proper priorities
to the irq threads int_a, int_b and to the user space process task_a.

That's not solvable at the kernel level.

Thanks,

        tglx

