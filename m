Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2379DC4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Jul 2021 02:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F021860E8E
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Jul 2021 02:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhGXBpd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 21:45:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:48353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232673AbhGXBpd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 21:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627093554;
        bh=AFkV+M+SyHVZchqQCS2cy0kQDWGwE0JXTTKM4rpGYms=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KZIaKdasGRQ5eWMBYYRMaKzSMR2xqluymggyv4S+zt52yL9BtJN6khx1kGDK1ZJwA
         pgfzxQohRglGcO3RBAzlQUhp61m5hIrK9ZPTUsCeSbg4S1g3dqLfZVlw7Vh1shylxl
         p8baygdJxL0GX0uG+bIOYgFGBsg0aUsEZYxbwDZ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.88]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1m5Bgj29CJ-004FK0; Sat, 24
 Jul 2021 04:25:54 +0200
Message-ID: <23b626c719b6b269fc30e29041b8db3b4f8b60f8.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 24 Jul 2021 04:25:53 +0200
In-Reply-To: <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
         <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
         <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dk8cVrm+FElyoBOOigtAlq8wt3wvkCNm3SZ3zWpIdhbApx2MoVJ
 FcA9U/YpQqfFk08N+FWkhRFZu1pPUKVNgq3FQ6pugxGJE517eFdfyn/7SHUteHCGBirT6Pe
 VTNlc8cRDdJJoQgiEcRyaC3D/vph0/B5u/jpfHxW70XQAgY7BeE21Gv5Ya5yhuxeA0g8YJg
 zjCE6W3ITu2EAl+LsT8gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6U6TS+KbBs=:yaSSueQvPDlgxqTJ1uxvzj
 PAdPC/d+EbZeuEGNRHtfuxR4Oqj+r9Z/qXwGvdrrbPJcOynCk4VRNfNMT8DntBAS4Mh7OcHc9
 WpCmrf9SxiWiOif6Q+vXpafmRSYe8pa8QDYYjj62VvUahr4T6t4gv7IZ4AChi1BsKyunYQhW/
 nX38zVna+ePlhdttU09l0que0Ade0N8KeS9P8JqSrRJXFT8pRIa6LicnYppS2OJz6fguFMXsM
 R3HHeiW7jhC6XRDliBEavwO1EACdnVeEYUFLb2u9sO1m0mK3/1bXxs0DCGwDq209M4eyWAqf5
 gIBSoOcTA0TiL0wfkbJ837XBpNi8iptGEjntpIiArUSASJeBEsrM3hoEF43JBFfP/ZHRDacDD
 eWMBJWafiPsHxRYaHxqGzuPbkn9dh725N3gqMJe0Uy3fT9xtvOkApgt0l5IpJ4SNQLQwCs2F+
 PUUVp/CskX1E94wuAcBSYDH3J93Fp4b/4Fm+HSqskr63wCN/hJcX8YzoWA4NiG9DDPPJUiulH
 t8LryCZHZ9WPoPniApiGarPBwsKggUkD2z4bagSsIJHHEAMdWbupP+1z04xcPhoSR4aheSIGw
 ZkaKI+PAz2RqTrWbrxK6Wfmw7Zy3R54WzLMihobQs/a3zri0SwsUL8m0ExS7OBcM83Rmrlvcf
 UjQr0DQ0aPjnNY9bzxPECpyzTweyAQthvBGQ5gb3JRk63PIVfhoYYoTDoHBPIEk59T5AYgap/
 Q5vNL5d29EDvwfxjt9fg2lNc8jrGENFEDpBOgYRNYGY9QuMQHyhvlyhcrsaGcpptYAKKdKikz
 SfLkD12K/OGVQ8hob6G3l3doenlUbrfLol5sphHwYNRjJY4+gyvjYPs7xR7/S5SxXvE+FVP5+
 cZ+eXOwsO7O5zxeyTklNtgTOWrXcdVMKwquJ4Wz0khkdMkxG2yoTcsDa7Mn/agmOxBfTJpDs0
 JiCkm4ExGe8FdNfaJhqTS4mig6Gfyn11D18KEDNDiq6hhdeBUc2ik3XoxDgPl3zWn4ce96A+3
 3O54E1sfKlEiQLXWCQLd4nBC49EHHe1Zt23leTNvk7JfYoyJ5r0G3bs6UcS496AJKmu8mOjNm
 /ew3gvNhnVP2YIEeRR4MzUo9KdO0Wek412R
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-07-24 at 00:39 +0200, Vlastimil Babka wrote:
> On 7/21/21 11:33 AM, Mike Galbraith wrote:
> > On Wed, 2021-07-21 at 10:44 +0200, Vlastimil Babka wrote:
> > >
> > > So this doesn't look like our put_cpu_partial() preempted a
> > > __slab_alloc() on the same cpu, right?
> >
> > No, likely it was the one preempted by someone long gone, but we'll
> > never know without setting a trap.
> >
> > > BTW did my ugly patch work?
> >
> > Nope.=C2=A0 I guess you missed my reporting it to have been a -ENOBOOT=
, and
>
> Indeed, I misunderstood it as you talking about your patch.
>
> > that cutting it in half, ie snagging only __slab_free() does boot, and
> > seems to cure all of the RT fireworks.
>
> OK, so depending on drain=3D1 makes this apply only to put_cpu_partial()
> called from __slab_free and not get_partial_node(). One notable
> difference is that in __slab_free we don't have n->list_lock locked and
> in get_partial_node() we do. I guess in case your list_lock is made raw
> again by another patch, that explains a local_lock can't nest under it.
> If not, then I would expect this to work (I don't think they ever nest
> in the opposite order, also lockdep should tell us instead of
> -ENOBOOT?), but might be missing something...

RT used to convert list_lock to raw_spinlock_t, but no longer does.
Whatever is going on, box does not emit a single sign of life with the
full patch.

> I'd rather not nest those locks in any case. I just need to convince
> myself that the scenario the half-fix fixes is indeed the only one
> that's needed and we're not leaving there other races that are just
> harder to trigger...

Yup.  I can only state with confidence that the trouble I was able to
easily reproduce was fixed up by serializing __slab_free(). Hopefully
you'll find that's the only hole in need of plugging.

	-Mike

