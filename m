Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559C4C4332F
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Nov 2022 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKIQZw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiKIQZu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Nov 2022 11:25:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946119286;
        Wed,  9 Nov 2022 08:25:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668011148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dS+4jgWIp3j9dZW4rFcYGh+sxLvaYK0P20ezcjFZXV4=;
        b=QSJ6LNleWHA1RHSFfXDxaPCmn+jVt13MdBC439LXEnVNK/hFvPdwB5B398jBp60AT0pIQS
        wkqvdpn5kNXVCgwTko1XfQm3JRQBr3TviBBKhxWn75PHzday7t36VquvGBZxeXzW4Mq903
        GOSrp4WESbB4JPlcJS/Wpy8DjKYKhUT6t/c1h4omwmQRuTXbyzKc/XXcibunUtKGkKFP79
        YJuAAUklyZ9CwQahkEIezqyCJr5OwWQkK/nbuN5T+oPHHAX+OkBoTY8Q+NZl46O8jaiajH
        wEZFLs7VED6bVxf/7x4LDLExXVvd1qzAcqcrXCststE9EtbGwDQ8l63yV4xGDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668011148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dS+4jgWIp3j9dZW4rFcYGh+sxLvaYK0P20ezcjFZXV4=;
        b=lwdaORWqUif3kCYJceQQDzwyZjs2HDufqdzeXFV9iRm3q2ov1baXwSOqmazm7c/nIxYJ9M
        cbqO7rZS1r9gftBA==
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Drop fpregs lock before inheriting FPU
 permissions during clone
In-Reply-To: <20221109113044.7ncdw6263o3msycl@techsingularity.net>
References: <20221109113044.7ncdw6263o3msycl@techsingularity.net>
Date:   Wed, 09 Nov 2022 17:25:47 +0100
Message-ID: <87o7tg8584.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 09 2022 at 11:30, Mel Gorman wrote:
>    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
...
>   The splat comes from fpu_inherit_perms() being called under fpregs_lock(),
>   and us reaching the spin_lock_irq() therein due to fpu_state_size_dynamic()
>   returning true despite static key __fpu_state_size_dynamic having never
>   been enabled.
>
> Mike's assessment looks correct. fpregs_lock on PREEMPT_RT disables
> preemption only so the spin_lock_irq() in fpu_inherit_perms is unsafe
> and converting siglock to raw spinlock would be an unwelcome change.
> This problem exists since commit 9e798e9aa14c ("x86/fpu: Prepare fpu_clone()
> for dynamically enabled features"). While the bug triggering is probably a
> mistake for the affected machine and due to a bug that is not in mainline,
> spin_lock_irq within a preempt_disable section on PREEMPT_RT is problematic.
>
> In this specific context, it may not be necessary to hold fpregs_lock at
> all. The lock is necessary when editing the FPU registers or a tasks fpstate
> but in this case, the only write of any FP state in fpu_inherit_perms is
> for the new child which is not running yet so it cannot context switch or
> be borrowed by a kernel thread yet. Hence, fpregs_lock is not protecting
> anything in the new child until clone() completes. The siglock still needs
> to be acquired by fpu_inherit_perms as the read of the parents permissions
> has to be serialised.

That's correct and siglock is the real protection for the permissions.

> This is not tested as I did not access to a machine with Intel's
> eXtended Feature Disable (XFD) feature that enables the relevant path
> in fpu_inherit_perms and the bug is against a non-mainline kernel.

It's still entirely correct on mainline as there is no requirement to
hold fpregs_lock in this case

> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
