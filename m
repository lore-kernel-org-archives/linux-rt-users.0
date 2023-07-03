Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD8EB64DD
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Jul 2023 16:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGCQNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjGCQNC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Jul 2023 12:13:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C81E42
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Jul 2023 09:13:01 -0700 (PDT)
Date:   Mon, 3 Jul 2023 18:12:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688400779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTWs3yvxjJuG+efxP6o79ftGKgxb9vr275lqvsa3TWA=;
        b=KaQESnQ4Cwfb81EODs55mATgUy6PIpLAkrcBPyuGQ6yiCmC6fNm/NAt2PqGVvjkIK9nTjY
        qygwFQyWWf8uyTKfzSkKUq7AheAVrDV6WfhrekZNUdtOYuL/3FsDuLlq0DiqoBpdLgdQkQ
        HtvGlXQoK2h2EgZ2tfs37rHtPXiI2YxioqNxFfny92dS0URWRM911r2obmR9nmimP9LvET
        UfPV01bqXdmYZsYUtF34euSQtlCt6QfHRkNKEVLmj6fKGzsxEURQBV9yxk+WeMe1Fe+sDy
        plnw1DTxEyVgIBs3/R/N6+d1Mi/1/LNM0Hu9CYVrvkGRqI4G1K1gDUKeC/xlnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688400779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTWs3yvxjJuG+efxP6o79ftGKgxb9vr275lqvsa3TWA=;
        b=DKYY8TLwd3V5UFLCLimMntz51WJW5g5yzX8h9rF313F8NThVrH1BGXFqaKKO8CRwzxLPaZ
        CmZUVcBLJNHWyGBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] tentative fix for drm/i915/gt regression on preempt-rt
Message-ID: <20230703161256.21Qmrm9d@linutronix.de>
References: <20230630130949.coN0sVU4@linutronix.de>
 <5af9b5cb-2342-8de3-07f2-86f2be6201eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5af9b5cb-2342-8de3-07f2-86f2be6201eb@linux.intel.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-07-03 16:30:01 [+0100], Tvrtko Ursulin wrote:
> Hi,
Hi,

>=20
> Atomic requirement from that commit text is likely referring to removing =
the
> old big sleeping mutex we had in the reset path. So it looks plausible th=
at
> preempt_disable() section is not strictly needed and perhaps motivation
> simply was, given those 20-50us polls on hw registers involved, to make t=
hem
> happen as fast as possible and so minimize visual glitching during resets.
>=20
> Although that reasoning would only apply on some hw generations, where the
> irqsave spinlock is not held across the whole sequence anyway.
>=20
> And I suspect those same platforms would be the annoying ones, if one sim=
ply
> wanted to try without the preempt_disable section, given our wait_for_ato=
mic
> macro will complain loudly if not used from an atomic context.

It does not complain on RT, I did patch it out.
   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tr=
ee/patches/0005-drm-i915-Don-t-check-for-atomic-context-on-PREEMPT_R.patch?=
h=3Dlinux-6.4.y-rt-patches

Interesting, the link there refers to an older posting but this patch is
not included. For the other I didn't receive feedback at which point I
stopped pushing and put it on the list for later=E2=80=A6

> But I think we do have a macro for short register waits which works with
> preempting enabled. I will try and cook up a patch and submit to our CI
> during the week, then see what happens.
>
> Or even moving the preempt_disable down so it just encompasses the regist=
er
> write + wait. That would then be under the spinlock which is presumable o=
kay
> on RT? (Yes I know it wouldn't' solve one half of your "complaint" but le=
ts
> just entertain the idea for now.)

You can't
	preempt_disable();
	spin_lock();

You could
	spin_lock();
	preempt_disable();

But if there is no need then there is no need ;)
What I worry a bit the udelays=E2=80=A6

Thanks!

> Regards,
>=20
> Tvrtko

Sebastian
