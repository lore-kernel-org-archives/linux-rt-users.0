Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E6C64E90
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48CA20771
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 10:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ePOGmg6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgK2K7H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Nov 2020 05:59:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:59021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgK2K7E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Nov 2020 05:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606647417;
        bh=xuUwzZ7J2wadinLY3BrTlVoxFqhsceEnaYR1kreYZ6c=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ePOGmg6cTvk3A8f3JZd4VecBJNrCkwo6OPUqccm9oqNbY6T1uiV+q9viKtl7pZGbI
         /rOOoeC10vAZbnHJpxIF6c0OU3i53qRiZPbYIOaWaKKCxR/pVrqCYd5uIsrflslpWu
         ++inwpavKK+DSrntZB32485YKrFTeQU2h2UqWvGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.83]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1k3pH43EFj-013w5p; Sun, 29
 Nov 2020 11:56:57 +0100
Message-ID: <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 29 Nov 2020 11:56:55 +0100
In-Reply-To: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KkU+dO0CotFg8t98ZX+R+ppUKncpqsi1f3DNTFjPAkwxZI/cMf
 fOUGowMDXMp16ib7vCoLfW59yuQr1b+C8biP51nhq7Wm9UPGQ9uNYwvIW7qaoZUPzMhMFx9
 C9ad/1eVySHF7O0ptB5l8pIbT6f3bPNLJwiFzR4By1xjYM7STZanAP1fe7o/S0Atd1bVtYR
 sbD2N19+KbuWzaM4mss4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3NxniihrIMQ=:NwxAzoQDYk6FvcXnaDATmx
 y2OKPHWUPRwKVmpCIKZmgKEsn3Jvmg1IWyji3F4EHzoqdSXW/mR/ofxTPbM2rW81GuIrbZruu
 n1I+wM4zcTqNOgs5QIRKoxtInhW1Bf5hl+d2SuaLF84WNCSslAXFe3Lwb0aP35/gfiQybNkmB
 BPqsB5sgwN5yDO/rI7xzReX8z72Y5/b1SDQ02b8u9lUJwjrHSVYrJ9WHxRszu5h5TDjSgeuBo
 lwznEaIE4EkCkdzrWkP/mvvAfAEm8opasML1q1u/VhpVm/cZTHuv1rx1XADDaHJ3ColoH0yfj
 Jl90CbCFjaplvNhsZsmmV3NLf2vwYMb1XusM4n66kxDSzCb8m7ZfkpDxV7MhjoNYdjiuhC6AM
 XT0sGcCzRRUGcUfur4IVgV9UDzsiLvTExgYolyDfLtzJOREXdWG3lbMoJR68oOiH0ijelYFIS
 BukCHpFBBIUa3VUC2kbKVtIbAExTYCslXTSg3EibM0rc4OVOcP2fy41vv2uT9cmqYpTuN7Lo4
 vlN6inPBjALISNSiiyXj1T1STX9Nw+S111a2oFFpErO7rNQyLLSjiWa96f7/9s+ZGIWl3dfXF
 T/0AzK/OGFLks/ac1oSPmrzV/MFvhd061Fstyj5AH7mgyOZL1K+CfWGNvk7wWVPxPXm/LJb4/
 zSy+AhGA/Exr90dVQ80YvOVm3Nw0wMuSgtpeu5POEcinjg4m1w44JPbIoRY7aS2c+VdKcl4KV
 ZhTQJWjBeGYVs5fa8arVRfSXeNQP+vc24GqKsOBvQwNazr3tcg0Kk8LgwAlypk707NC500nrF
 wGrqC/DfmZE54Zjrdr+Je66iFmredHbtba9LkITmwg2Xg9l3SfkkdMkBhjUDMEiqo8+pGhEk5
 QHE8ZmYOx7jK7RmriKAQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2020-11-29 at 10:21 +0100, Mike Galbraith wrote:
> On Sun, 2020-11-29 at 08:48 +0100, Mike Galbraith wrote:
> > On Sun, 2020-11-29 at 07:41 +0100, Mike Galbraith wrote:
> > > On Sat, 2020-11-28 at 15:27 +0100, Oleksandr Natalenko wrote:
> > > >
> > > > > > Shouldn't the list manipulation be protected with
> > > > > > local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
> > > >
> > > > Totally untested:
> > >
> > > Hrm, the thing doesn't seem to care deeply about preemption being
> > > disabled, so adding another lock may be overkill.  It looks like you
> > > could get the job done via migrate_disable()+this_cpu_ptr().
> >
> > There is however an ever so tiny chance that I'm wrong about that :)
>
> Or not, your local_lock+this_cpu_ptr version exploded too.
>
> Perhaps there's a bit of non-rt related racy racy going on in zswap
> thingy that makes swap an even less wonderful idea for RT than usual.

Raciness seems to be restricted to pool compressor.  "zbud" seems to be
solid, virgin "zsmalloc" explodes, as does "z3fold" regardless which of
us puts his grubby fingerprints on it.

Exploding compressors survived zero runs of runltp -f mm, I declared
zbud to be at least kinda sorta stable after box survived five runs.

	-Mike

