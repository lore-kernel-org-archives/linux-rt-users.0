Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CFC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D282603E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGZJYM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:24:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:50401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhGZJYH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 05:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627293864;
        bh=WrnxUT4lygr+QkLA7ti2Ti+saFmz7EW8hOxVa0LSF9s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GxhE3cSZZ8Hiq59Bb4Vj+1I3EUmPFyZpRRPLqalcgT+B99p715qoopttZREbSEcB+
         RTn8lHeY49LcltaWbRHQKjdMIAKZT/TZ8ucjENfrrvysvfayDw+ML2QWX76oiaIo2x
         8LTZKoVwD91hYlIAwEiZgGwYxy6Osk8HYFfzpYJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.197]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1lcBXI0qNI-00VxYL; Mon, 26
 Jul 2021 12:04:24 +0200
Message-ID: <86ead66e34c5c3a59b0bf773ed40767b4282b768.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 26 Jul 2021 12:04:23 +0200
In-Reply-To: <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
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
         <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
         <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
         <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
         <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
         <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
         <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fENmWrho0Eq5vPCq4L3ig6VkKPFc6uF4z8VaTgF2x7mPEsU11Ao
 7KeqHKkBq2tBjakjh/+DADgoV4yD8Xi72VVKarMRaLGMNOS3ylb0Y3g2Z6jOMDmwS5ASGiz
 /OCYM2JtVdiI2cO8SQry8m2KaLl1tIbRLQtsiKlI21qClroKVJTzqUwzUC9qIWJ3E4OL1k5
 ObveJqxBxf0QFNAYiojwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tbiQFGwfl8Q=:4VsNF7/R6DKGcNUGgtbs0c
 rpw7wRVta1HCX49uFriDRlYmoLfmBwfN8FInzSPc4xrtSaqh7oV+PCdzfjradtaQ32IVMdtHY
 ahuA0GJInzTd9XjHUzhZumeC1GSUAEV1dUU8JvGbFMgaV+pVpvNsxbj1GqB0uUPwaFwIKsZ16
 vuyPdNxhzkR6nbv9KVe5sJpXQCPjRWxigJlcBUoaGFnUrEUWz4ugwtL8AQlLb5opCNQjmypgI
 sg+e1/gzIus2CthZkmeviHmcZfhn/5+poc8/KGRgEtDt+shi1eW22SjYM67x8/K+m8+gB/R14
 SJT/Zf00NQUS3gjZSdlhu2PzObYyo47gOHzKPmJfRjRg6wbqTDwI6lQCElRgtR/NF0CjjqAxH
 bAU7L3ijWFvHueQvcPI4BidLE0QhwD47RQS6txHQlbUYQ8k5pf222alKZluj/os/iBAcK9CAx
 m6ZjisNdgjOzk9QIe4fmnujYt3R6cw8ZjGxhKdf3ra8AlyArpufanPze1GY7R2lVild1LTe0K
 PYK4+XWahdWvkL59RTyGABurGcyKKUhR4rRRSjpsv60fNYgkIOBQ/Lp5+AR6y2A6zzvrPm8lp
 xA/TA1Dof/IZRPJKU1YbjIemLEMwpgHCroEK74AMlX7/8TuMM/rxMEMKDtPk+Z3uEA39xpt8z
 w9vJRHB+LkmOVsnIyvvyorszI7dFFimhtaLz5HBaFdZUW8ssc+h60B7Ao21VgPSoNHAKjTXS9
 4s/7UdQCCPuDLoGuDeoZDFRS6OrONolhE+jhGvzO8F3wh6owGaVmyUQR3ta+Q2fDQvacfeQA8
 ldkessG3+hdQCDW3lXmfg8M5ogD1u8nZq/8wzS7dX/YAc9gcGjN8HTIRH1gedB+aJYRi1hulT
 JmRtxnr2JOJADwW4IaULknWikKo0PHDnMaCJd+visCyOjA+5lU7zRX590fY1L8sAvSs7DOgAi
 ccOwJaWYK5NN9/eqAm+ywWzpFJy0h5GcYsb6qOIUMvTSD1lrsRf5HYm/8/W+keffPj18h0Uwc
 0QhoIWFOxsFlj1pu97MN47rF+E51bSv0EhxFkyxvRh76UT6c/cCQtCZqYc6MBQ8YvhTrvYDuZ
 IyVL8GqXg1O32fiCeah/fo0VxCE4O+Xnyyl
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-07-25 at 21:34 +0200, Vlastimil Babka wrote:
> On 7/25/21 9:12 PM, Vlastimil Babka wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * On !RT we just want to d=
isable preemption, on RT we need
> > the lock
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for real. This happens t=
o match local_lock() semantics.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0local_lock(&s->cpu_slab->lo=
ck);
>
> OK I realized (and tglx confirmed) that this will blow up on !RT +
> lockdep if interrupted by ___slab_alloc() that will do
> local_lock_irqsave(). So back to #ifdefs it is. But should work as-is
> for RT testing.

I called it off after 3 1/2 hours.  Bug blew box outta the water 10
times in about half of that, so methinks it's safe to call it dead.

	-Mike

