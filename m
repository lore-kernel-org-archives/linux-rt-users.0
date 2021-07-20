Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8FEC07E9B
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 11:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42FA6113C
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 11:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhGTKps (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:45:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:52417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbhGTKpk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jul 2021 06:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626780375;
        bh=VBJRenTT6RN9XSmQwODnOnF5iGF5GDQ+g+X9lepK264=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IBNwf0HB34I5hK6V1LeWpyR76CPLlO0/YHjKekKwQVB1oTV3VClBpVl5QRTLksOkk
         ZspucokawawZVvgeYu/DUKnk6LJZ8kGuD1dWP3GbjAbKccPWffTLhJZtl4gwokfCqk
         0QXp2S5vKEijAHyOjWlp0ghndjp/BXvy8ywdSrtA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1lhN7s03ch-00TU8S; Tue, 20
 Jul 2021 13:26:15 +0200
Message-ID: <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue, 20 Jul 2021 13:26:14 +0200
In-Reply-To: <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CDuvJn7v4dobctxVEtrJxuNY6SIKiGtXkG4dR8+5E07JtGIsHYy
 CqOb3fRwijDGslHtbZEtwh/rEDmZA+9PkIwCO0kDx0IeAxEEb2jEbVsMj/tX0NX+PRWgtm5
 JRUeLyFGtRLn5TlOK/V2v1LxfOy782XpDyl8rvgS+7Wy0NMERXWRHb+Gy2Qzr2XE8XcXKrk
 nCSnd9v8Qa41ApOYuStwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K0nDJyu4qmw=:z119RK8wBzXX7kTPr1M6gq
 cmZ9QesJWP0UWvfmFYqnehyWqiY0t4xO04Hz/boBWGMKXbZpZkdaEMYTQ9NIGgJzk4HLxXsh3
 NiCWBgTqX0/MwuXBlUHiIfmYdXnRN/9BTxcNPC92IwIkGkHn32m9jCIsE+koUBl2RKGDzDRLx
 pvcge7/kdwxTXdVbeWVHPOhFNgXeh643xD4rzrm5+Qtn1UUvXuVFqF0n23Gg+pay4UkUYpS2H
 Lj5NOsIAsH54mTR8u8g3vRNBpbiCQhr5THjhVPAwMVQhicjdRn4EAUPQAnkPYrrXuLyd2bZKB
 LjHPvoNM0QzQNxqPP6KPP8RLLXB1PwszLAUg68DwU/dVPP/v7/KL1odvYzb1PnNxrgGe3NWqn
 TIG8wKeSReI79I1dv01D+ABLTP+CGsXQ83gWDhBn+At4RI6mDPgo1DrogoJ3Opqr+q1tyzICf
 v9CHqgTizGTJXexQgSV9EvYo4fd6a8LXAsPzuMjFysyCGJq8qOxgqRiN2T755Zrj2Mk/5wTW+
 /zY2LkBiMM3dBXQKHQhzxodj5m2RyfbBYa5pauj/lg7Gmlp8eAG02/qtplkOqmeskvQyQvW5X
 qyUWMR6mayagDKFkI0zdS+rKHe8UG602fPO74hWjUsZCvqiE81fvvqUGxkbTYsBKBEfiUs5cs
 adncS29Ey0AH8nOCM0YohFOhircW9xdxDTQUuAyiob7VkSOBe9qh4aMOnWSvzeBI3KAbVcmnz
 d+fdMjhKcXtD0fvrSr0CkqAo31RK6jCG5VQtMo7g3kdFsKrEfeZhnGuxxFD1p+u11fCgX7KH8
 g0klCKOp16SazArbZTDW5roEyAkHZZiZCLqvRz9xmuYSCEkTssslsdp+lz7aIrchPAO9jTSbz
 uerzx5TcashbGN6dE/qodj5ZzJaUzWJi6byllwTCeVJIB+p6ksdDIIwRTAFrozGcuGopIsFax
 +CizjUjLamd23b0wSLjwwgrWLjmE7E0391v/c607OISUnlDubMi8KNyYhNwP/Ovrau4GAwreJ
 eudpvyxzdiFQiRUMz/ZcIJqs/CeXIK0UE0sDLuQkjOEA+UjTL8ckQVqk1Ik1hcQbnI17rjwY4
 1Pf/HDH7lgrw/JIlid0IzhtAO6NpHQb4qmu
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2021-07-20 at 10:56 +0200, Vlastimil Babka wrote:
>
> > crash> bt -sx
> > PID: 18761  TASK: ffff88812fff0000  CPU: 0   COMMAND: "hackbench"
> >  #0 [ffff88818f8ff980] machine_kexec+0x14f at ffffffff81051c8f
> >  #1 [ffff88818f8ff9c8] __crash_kexec+0xd2 at ffffffff8111ef72
> >  #2 [ffff88818f8ffa88] crash_kexec+0x30 at ffffffff8111fd10
> >  #3 [ffff88818f8ffa98] oops_end+0xd3 at ffffffff810267e3
> >  #4 [ffff88818f8ffab8] exc_general_protection+0x195 at ffffffff8179fdb=
5
> >  #5 [ffff88818f8ffb50] asm_exc_general_protection+0x1e at ffffffff8180=
0a0e
> >     [exception RIP: __unfreeze_partials+156]
>
> Hm going back to this report...

> So could it be that it was stillput_cpu_partial() preempting
> __slab_alloc() messing the partial list, but for some reason the
> put_cpu_partial() side crashed this time?

Thinking this bug is toast, I emptied the trash bin, so no can peek.

If need be, and nobody beats me to it (which ~guarantees nobody will
beat me to it;), I can make the thing go boom again easily enough.

	-Mike

