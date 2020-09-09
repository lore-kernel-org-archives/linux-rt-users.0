Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D2C10DAA
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A33215A4
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFvFqDhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Jk2tuLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIIIVC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIIVB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 04:21:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26805C061573;
        Wed,  9 Sep 2020 01:20:59 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:20:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599639657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9WooS1I0dnfrXuVay1z186vvTyZRgrndE5v3trpEa8=;
        b=eFvFqDhevzwjoJOjn5ZNBf/l8r+rF8zHjTDajogzaqK7kToqpwNwnzagHxU0GaKh06GZFk
        uLd7GcpW7TsCwz9H9gs3IRzVaKdFFwv3B/Nz4lxBepHwWWectCqPbG7+Ey8DvUpoHa03x3
        DCiBm1Q904p/mYNDjNzcI5+NkJfYnE775O+6H5j8NW5fgvn0xXWUOpuhXyNiiBaxCHAJY8
        OHO1dhO3rAJTBi8f4miqVIpBme906H4E8w3bSf2BEQw5osMw9FSL/X8/P/OLxnUUYLjlxP
        G4egfuPiLuiRXDeD3iwBnmIeg8wgDDKWl0r0VbKb4xOBAaHXjIZhFklLgxDxCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599639657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9WooS1I0dnfrXuVay1z186vvTyZRgrndE5v3trpEa8=;
        b=1Jk2tuLO3hb6D0dUElyulHKw7C5f5+ZzjpiO7q2s4l/3l7KPleygxgwDZlCd8URiw+M6f4
        ZnHqcIRHeSIjfYCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
Message-ID: <20200909082056.sw32jevyhdm4mzcm@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
 <91828ea63ecd61d40bba0358e1c0efbe62976ba6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91828ea63ecd61d40bba0358e1c0efbe62976ba6.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-09 07:45:22 [+0200], Mike Galbraith wrote:
> On Wed, 2020-09-09 at 05:12 +0200, Mike Galbraith wrote:
> > On Wed, 2020-09-02 at 17:55 +0200, Sebastian Andrzej Siewior wrote:
> > >
> > > Known issues
> > >      - It has been pointed out that due to changes to the printk code=
 the
> > >        internal buffer representation changed. This is only an issue =
if tools
> > >        like `crash' are used to extract the printk buffer from a kern=
el memory
> > >        image.
> >
> > Ouch.  While installing -rt5 on lappy via nfs, -rt5 server box exploded
> > leaving nada in logs.  I have a nifty crash dump of the event, but...
>=20
> After convincing crash (with club) that it didn't _really_ need a
> log_buf, nfs had nothing to do with the crash, it was nouveau.

okay. Line 280 is hard to understand. My guess is that we got a pointer
and then the boom occurred but I can't tell why/how. A few lines later
there is args->x =3D y=E2=80=A6
Do you see the lockdep splat without nouveau?

> crash> bt -l
> PID: 2146   TASK: ffff994c7fad0000  CPU: 0   COMMAND: "X"
>  #0 [ffffbfffc11a76c8] machine_kexec at ffffffffb7064879
>     /backup/usr/local/src/kernel/linux-master-rt/./include/linux/ftrace.h=
: 792
>  #1 [ffffbfffc11a7710] __crash_kexec at ffffffffb7173622
>     /backup/usr/local/src/kernel/linux-master-rt/kernel/kexec_core.c: 963
>  #2 [ffffbfffc11a77d0] crash_kexec at ffffffffb7174920
>     /backup/usr/local/src/kernel/linux-master-rt/./arch/x86/include/asm/a=
tomic.h: 41
>  #3 [ffffbfffc11a77e0] oops_end at ffffffffb702716f
>     /backup/usr/local/src/kernel/linux-master-rt/arch/x86/kernel/dumpstac=
k.c: 342
>  #4 [ffffbfffc11a7800] exc_general_protection at ffffffffb79a2fc6
>     /backup/usr/local/src/kernel/linux-master-rt/arch/x86/kernel/traps.c:=
 82
>  #5 [ffffbfffc11a7890] asm_exc_general_protection at ffffffffb7a00a1e
>     /backup/usr/local/src/kernel/linux-master-rt/./arch/x86/include/asm/i=
dtentry.h: 532
>  #6 [ffffbfffc11a78a0] nvif_object_ctor at ffffffffc07ee6a7 [nouveau]
>     /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/=
nvif/object.c: 280
>  #7 [ffffbfffc11a7918] __kmalloc at ffffffffb72eea12
>     /backup/usr/local/src/kernel/linux-master-rt/mm/slub.c: 261
>  #8 [ffffbfffc11a7980] nvif_object_ctor at ffffffffc07ee6a7 [nouveau]
>     /backup/usr/local/src/kernel/linux-master-rt/drivers/gpu/drm/nouveau/=
nvif/object.c: 280

Sebastian
