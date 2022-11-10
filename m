Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF5C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Nov 2022 12:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKJMZ7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Nov 2022 07:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKJMZp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2022 07:25:45 -0500
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 04:24:25 PST
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBB7E997
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2022 04:24:24 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id 511EDFAC6F
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2022 12:18:33 +0000 (GMT)
Received: (qmail 18955 invoked from network); 10 Nov 2022 12:18:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Nov 2022 12:18:33 -0000
Date:   Thu, 10 Nov 2022 12:18:31 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Drop fpregs lock before inheriting FPU
 permissions during clone
Message-ID: <20221110121831.ehke4sxsmlpl454e@techsingularity.net>
References: <20221109113044.7ncdw6263o3msycl@techsingularity.net>
 <87o7tg8584.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87o7tg8584.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 09, 2022 at 05:25:47PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 09 2022 at 11:30, Mel Gorman wrote:
> >    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> ...
> >   The splat comes from fpu_inherit_perms() being called under fpregs_lock(),
> >   and us reaching the spin_lock_irq() therein due to fpu_state_size_dynamic()
> >   returning true despite static key __fpu_state_size_dynamic having never
> >   been enabled.
> >
> > Mike's assessment looks correct. fpregs_lock on PREEMPT_RT disables
> > preemption only so the spin_lock_irq() in fpu_inherit_perms is unsafe
> > and converting siglock to raw spinlock would be an unwelcome change.
> > This problem exists since commit 9e798e9aa14c ("x86/fpu: Prepare fpu_clone()
> > for dynamically enabled features"). While the bug triggering is probably a
> > mistake for the affected machine and due to a bug that is not in mainline,
> > spin_lock_irq within a preempt_disable section on PREEMPT_RT is problematic.
> >
> > In this specific context, it may not be necessary to hold fpregs_lock at
> > all. The lock is necessary when editing the FPU registers or a tasks fpstate
> > but in this case, the only write of any FP state in fpu_inherit_perms is
> > for the new child which is not running yet so it cannot context switch or
> > be borrowed by a kernel thread yet. Hence, fpregs_lock is not protecting
> > anything in the new child until clone() completes. The siglock still needs
> > to be acquired by fpu_inherit_perms as the read of the parents permissions
> > has to be serialised.
> 
> That's correct and siglock is the real protection for the permissions.
> 
> > This is not tested as I did not access to a machine with Intel's
> > eXtended Feature Disable (XFD) feature that enables the relevant path
> > in fpu_inherit_perms and the bug is against a non-mainline kernel.
> 
> It's still entirely correct on mainline as there is no requirement to
> hold fpregs_lock in this case
> 
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Perfect, I'll rephase the changelog slightly and resend without RFC and
all the x86 maintainers cc'd. Thanks Thomas!


-- 
Mel Gorman
SUSE Labs
