Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD2C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 28 Nov 2021 09:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357041AbhK1Jve (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 04:51:34 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:52006 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbhK1Jtc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 28 Nov 2021 04:49:32 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D350ACC7EE1;
        Sun, 28 Nov 2021 10:46:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1638092775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iM+aL8jeAt4cg5fhsgrfFKN3ueURdDL5JvxMcrQsfmQ=;
        b=jW8nNWmxjbxGsyrMrPfbo5WXu7Pz2LrNfdyOPJzgGYtsnFroZEarAeeKLWPUl+1NfjTjde
        vRInDaFKIlDF4dbNKDgUR00C1J5z3tAVritryAYczzE/y3B3YHdAMmQ1MC9AHOmjf7A/hK
        k0Yg7FPmhmX73zlO/vZbRNssUjvJYSE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org, Angelo Haller <lkml@szanni.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: sched: some non-GPL symbols becoming GPL-only with CONFIG_PREEMPT_RT enabled
Date:   Sun, 28 Nov 2021 10:46:13 +0100
Message-ID: <2606453.mvXUDI8C0e@natalenko.name>
In-Reply-To: <5475c3ab-a53c-8728-98c5-98fd948ff556@szanni.org>
References: <5475c3ab-a53c-8728-98c5-98fd948ff556@szanni.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello.

On ned=C4=9Ble 28. listopadu 2021 1:07:49 CET Angelo Haller wrote:
> Greetings. I hope I picked the right mailing list, as this issue might
> be one that affects various subsystems and components:
>=20
> When compiling kernel 5.15 (and 5.16-rc2) with `CONFIG_PREEMPT_RT`
> enabled, some of the symbols being exported as `EXPORT_SYMBOL` suddenly
> become `EXPORT_SYMBOL_GPL` through transitive effects.
>=20
> In particular the symbols `migrate_enable` and `migrate_disable` are
> currently marked as `EXPORT_SYMBOL_GPL` - yet are called from multiple
> functions that are marked as `EXPORT_SYMBOL`.
>=20
> Here an (incomplete?) listing of call sites I came across:
>=20
> kernel/locking/spinlock_rt.c - rt_spin_unlock()
> kernel/locking/spinlock_rt.c - rt_read_unlock()
> kernel/locking/spinlock_rt.c - rt_write_unlock()
> mm/highmem.c - kunmap_local_indexed()
>=20
> The issue I'm facing in particular is kmap_atomic() calling
> `migrate_disable` and therefore suddenly becoming GPL-only. This breaks
> the out-of-tree CDDL licensed module ZFS and has been reported before
> already [0]. The conversation seemingly going nowhere - or patches at
> least not being applied upstream. Downstream issue for reference [1].

What about going the other way around and let ZFS be re-licensed under GPL?

> As the original implementation of `migrate_enable` and `migrate_disable`
> is apparently by Peter Zijlstra [2]. Peter would you be willing to
> re-license both symbols `migrate_enable` and `migrate_disable` as
> `EXPORT_SYMBOL`?
>=20
> The bigger issue I'm seeing though is that there is currently no
> automated test to uncover exported symbols changing their license
> depending on build configuration? I am not intimately familiar with the
> API guarantees the kernel gives, but this seems like a violation. There
> might be other symbols with similar licensing problems.
>=20
> I can open a bugzilla ticket too - if that is preferred.
>=20
> Angelo
>=20
>=20
> [0]
> https://lore.kernel.org/linux-rt-users/20201208212841.694b3022@orivej.ori=
vej
> .org/T/ [1] https://github.com/openzfs/zfs/issues/11097
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/dif=
f/p
> atches/0009-sched-Add-migrate_disable.patch?h=3Dv5.9-rc8-rt14-patches&id=
=3D9a89b
> fdb3bc77aecdd0ff8cc69b595541c7b50c4


=2D-=20
Oleksandr Natalenko (post-factum)


