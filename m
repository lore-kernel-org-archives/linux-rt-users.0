Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E14C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0186D6137D
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhJEJyo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:54:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhJEJyn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Oct 2021 05:54:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633427572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Go3/rLwYwPkmmwpyDvOZVRC/3rE/kzWbTHjodPZUVqI=;
        b=TMHIUiDnQkH3R524d4nrMHMKx6W2NpZjHBZ5hMBF5yjcXZs9XUb/Gc2PZgi/rHIvVh0ztJ
        oMJm8C02Z9b5roawR+18aT1NhDEDMmvns92hiq18LDKCPaRmAXdqw6Rh6FxMY88jg2RXdE
        FOL60uHFNP5hbncpJengHOhh2oHysFV/G5/ejM/RYUFTuni7zpLeXnPqsDjW2jt5HNxbJK
        +C1J+mTlefkKWiE5dxyKIRuzybrIb+ixH4ALikikDofuM+K6f0Acgp89vysjmX/zsqPnmC
        KnXUEocu83ZZcvWtCrASH/4UEkYMtjawzxmSuvOokgejL8LgPOCCltz3zzx7Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633427572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Go3/rLwYwPkmmwpyDvOZVRC/3rE/kzWbTHjodPZUVqI=;
        b=E3n1IOxNUNDeX0dZMrt5IaL9Q+JTseWmNqcN010+mzGfGULKUY/ebVLc+akw88W0ZKRlGw
        kVgZ907XRRCbWPAw==
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: arm64: kvm + RT
In-Reply-To: <c640276e-77ca-f895-715e-053bae754f89@siemens.com>
Date:   Tue, 05 Oct 2021 11:52:52 +0200
Message-ID: <87h7dvg5mz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Jan,

On Mon, Oct 04 2021 at 19:54, Jan Kiszka wrote:
> what's the state of getting kvm working (again?) along RT? Seems
> HAVE_POSIX_CPU_TIMERS_TASK_WORK is in conflict with KVM but a
> precondition for RT on recent kernels. What's the story behind that?

the ARM64 KVM implementation is incorrect vs. TIF handling before
VMENTER which breaks the posix cpu timers task work assumptions and also
violates a few other expectations. AFAICT the arm64 folks are working on
that, but you have to ask them directly what the state of this is.

Thanks,

        tglx

