Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275EC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19E961425
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJEK4o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:56:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhJEK4o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Oct 2021 06:56:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C0006D;
        Tue,  5 Oct 2021 03:54:53 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655D63F766;
        Tue,  5 Oct 2021 03:54:52 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:54:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>, maz@kernel.org
Subject: Re: arm64: kvm + RT
Message-ID: <20211005105449.GC1664@C02TD0UTHF1T.local>
References: <c640276e-77ca-f895-715e-053bae754f89@siemens.com>
 <87h7dvg5mz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7dvg5mz.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 05, 2021 at 11:52:52AM +0200, Thomas Gleixner wrote:
> Jan,
> 
> On Mon, Oct 04 2021 at 19:54, Jan Kiszka wrote:
> > what's the state of getting kvm working (again?) along RT? Seems
> > HAVE_POSIX_CPU_TIMERS_TASK_WORK is in conflict with KVM but a
> > precondition for RT on recent kernels. What's the story behind that?
> 
> the ARM64 KVM implementation is incorrect vs. TIF handling before
> VMENTER which breaks the posix cpu timers task work assumptions and also
> violates a few other expectations. AFAICT the arm64 folks are working on
> that, but you have to ask them directly what the state of this is.

I think that was dealt with as of mainline commits:

* e1c6b9e1669e44fb ("entry: KVM: Allow use of generic KVM entry w/o full generic support")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1c6b9e1669e44fb7f9688e34e460b759e3b9187

* 6caa5812e2d126a0 ("KVM: arm64: Use generic KVM xfer to guest work function")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6caa5812e2d126a0aa8a17816c1ba6f0a0c2b309

... unless I'm missing something.

Mark.
