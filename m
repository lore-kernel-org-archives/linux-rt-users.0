Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B3C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Oct 2021 00:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F88661175
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Oct 2021 00:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhJFAHJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJFAHI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E2C061749
        for <linux-rt-users@vger.kernel.org>; Tue,  5 Oct 2021 17:05:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633478715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIXD/ER4MgVn3o/FW+2b8KWfU/KD4mYrVljYY/6Xce4=;
        b=4Ez4fwhzNmVTblNiUrqeuPAmn427W8c+IjCVV4egHTHjbtJ5LXNncAYAAdyJGqNef+lMqX
        sIViiwUN3w222UTU7NYTl7IdlY3Wc1mTR0iCJdczsKxfYzdQYIdzf4tOWDnlxkOnTE3+Rs
        KZUn3qr4QU50x8KiXCbUQvm0ydsOCCbRpjYcwgO15cnYlP/eBqRr/ZfcO4wz8AFF9uyk+2
        BXdl+4OgaF81GUo8b0RTbMOBSFmG6yFoBaP7lZxD2KkU+EgMclqnQ6ZcS+0JauXx+ldS57
        kvFfeQzXUQtEROZ/A/6a5x2aGaC4lNxe8l/vswb0RazcJa6kViXOJ9NmjgixpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633478715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIXD/ER4MgVn3o/FW+2b8KWfU/KD4mYrVljYY/6Xce4=;
        b=1s5gvL5k9zZ60+ZqXDNekX6xPGRGoTX2tYb20CjZSK9+xyoQZQXjpEzf9lyh4UbCkj5GcR
        4+jE5eggIegipOBA==
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>, maz@kernel.org
Subject: Re: arm64: kvm + RT
In-Reply-To: <20211005105449.GC1664@C02TD0UTHF1T.local>
References: <c640276e-77ca-f895-715e-053bae754f89@siemens.com>
 <87h7dvg5mz.ffs@tglx> <20211005105449.GC1664@C02TD0UTHF1T.local>
Date:   Wed, 06 Oct 2021 02:05:14 +0200
Message-ID: <87v92bdnlx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 05 2021 at 11:54, Mark Rutland wrote:
> On Tue, Oct 05, 2021 at 11:52:52AM +0200, Thomas Gleixner wrote:
>> Jan,
>> 
>> On Mon, Oct 04 2021 at 19:54, Jan Kiszka wrote:
>> > what's the state of getting kvm working (again?) along RT? Seems
>> > HAVE_POSIX_CPU_TIMERS_TASK_WORK is in conflict with KVM but a
>> > precondition for RT on recent kernels. What's the story behind that?
>> 
>> the ARM64 KVM implementation is incorrect vs. TIF handling before
>> VMENTER which breaks the posix cpu timers task work assumptions and also
>> violates a few other expectations. AFAICT the arm64 folks are working on
>> that, but you have to ask them directly what the state of this is.
>
> I think that was dealt with as of mainline commits:
>
> * e1c6b9e1669e44fb ("entry: KVM: Allow use of generic KVM entry w/o full generic support")
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1c6b9e1669e44fb7f9688e34e460b759e3b9187
>
> * 6caa5812e2d126a0 ("KVM: arm64: Use generic KVM xfer to guest work function")
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6caa5812e2d126a0aa8a17816c1ba6f0a0c2b309
>
> ... unless I'm missing something.

Just a minor detail:

$ cd linus
$ git grep HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/x86/Kconfig:       select HAVE_POSIX_CPU_TIMERS_TASK_WORK
kernel/time/Kconfig:config HAVE_POSIX_CPU_TIMERS_TASK_WORK
kernel/time/Kconfig:    default y if POSIX_TIMERS && HAVE_POSIX_CPU_TIMERS_TASK_WORK

$cd rt
$ git grep HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/arm/Kconfig:       select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/arm/Kconfig:       select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
arch/arm64/Kconfig:     select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/arm64/Kconfig:     select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
arch/powerpc/Kconfig:   select ARCH_SUPPORTS_RT                 if HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/powerpc/Kconfig:   select HAVE_POSIX_CPU_TIMERS_TASK_WORK  if !KVM
arch/x86/Kconfig:       select HAVE_POSIX_CPU_TIMERS_TASK_WORK

Which is simply because arm64 does not yet have:

arch/arm64/Kconfig:     select HAVE_POSIX_CPU_TIMERS_TASK_WORK

set in mainline to indicate that it does support it unconditionally
including in KVM.

See?

Thanks,

        tglx
