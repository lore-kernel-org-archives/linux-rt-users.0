Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0088DC4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD42060F48
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhGaDeP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 23:34:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:42527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhGaDeL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 23:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627702399;
        bh=oWNyP9nYmONTCBk1sSQYvsO9Xuq16xRL8Nk8+L/CsT8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=lPlXAwPmzFcZkY5oW8NnDW6qgInZuBSyT33u5Qv1QRwVr8dwi/IwESCnLGC2mp7OD
         HMTvjeGEn6VsDClArTjEezREQcxf4DSZhCuwrfXJqMvZNbxh9p58J7BZ33CtbtFA81
         p9H42dKCAKnWQl2YvvjBZ/pVQJHa9FPVDkCBb8fQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1ms7R72FQg-00ihdD; Sat, 31
 Jul 2021 05:33:19 +0200
Message-ID: <4fb6dc706d0fdde718943b48b1d564ec12c97f03.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 31 Jul 2021 05:33:18 +0200
In-Reply-To: <a2cd339c0e440cb5beed788d66a19a636b2e39a1.camel@gmx.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
         <a2cd339c0e440cb5beed788d66a19a636b2e39a1.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a2PTzrQEtXVVYHg1iNJ1VWbLfMTf59zom2/jTIopxZgsBxlUs6v
 M2mL/MOKOMLxQcql6ItvQoZCQNvDOaApGPPADFwOoEm/y1QBv2K8+k3EKM7NskMXOnI3gdM
 tOaP+1t5zad4CxzMwGwTFKw3QKkTzee5QheFVG0UrzckZr0Mi7OFndhYrYrO/T7hT7UO3dq
 6w9bE87MNdWY9GuYjnxoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9nVUOPmFII=:d/gZr046+BmNDmBguy3zLk
 qdPEEV7VkeU5G65BIpQQsz50AUFZiTXKVCKBBfctMzgXcbphDmf86tPCXDisgLSKHBngu0DKn
 OmyI9QLAEMi6wGvMf8izIZioUwxvrBlkZC6GC+pC6w3PjvRKPF8tXYSKnZ2l3B/6HzMnarlbU
 IEWfiuOa3CtsXb+Tb1MwK6SZNUxy9Mq1Yaud1JCm7LEHhWhNMms5HFccZqteUStnwtzWaRRDq
 qPlvG6iL/m8+KDRk/IEWb/mZF6seUGW1FjRZQPbP4/GcHVg7DVg/746/WvIXWRvYYDBVzh38d
 vzCkvTbtUY0AsCZ+LIKe9fUqzKD7QMiqVGuxdH1qcWmjD0gUgeT5TgFWXYvsy/1kq+e78/BIa
 dBvr/ikkIVpQSM7pBVj6PklDPxuAQk2cF9YbM5pJm1C7jKfxGOquE3hfM3nGKa/YFyzqE+puk
 cbXiOEgSgN9nebitUa2yfcuAm0sq2xB4YZ5SvMxtCWWpSUsUdg/sDwIoWB23hwFk0UcGdwqoX
 diaEJk8FkR5RwhU6/93csBUOkbcQcgMHY+BYE77CyniOTsnNsf4r8FpnpXL7sb2rXLIEKb9br
 5yUgrRf1HUoePlsEHkJqJI8Dw1QSH+0i1IdNk5zoUgJsyxkf8joc9lObAR/059saVcfy2fza5
 qb8u8MmWsBpN4TLWPvPAsZnIJJMXEE9T/lFC5yPy+5PibeJltK86AQQpjmN8DMCorOKXNVsd4
 U95/0yVqVo6uPRs3CZOt8tzzPtnbPbIQP5EBzBiZvgVdm5LQD+wPxjIPjkH3D2HuwDBr05bG5
 vfU/Cn6cMWOzacn3dnW4gau7D0KaZ2LySXMek8yzZzYE5zi6J8p5fzLT6HAMKnZWkoD++JKVQ
 zEoSdkqC0YM70PHo9eTgVuNprWYl0LXNFkgyuh3zXdkE0d/n6OItTslk0j5e4reKJYC6GUx9p
 Ko3Ey+uZAkNipRQGuI1vOsI5mCjONTXc4BjW/1K5xXPPQJhuCb14Xug6JhAHlNLMO3ownpRPK
 qQ1/6jpr/qf7HgbtlYXFdq6QlbkHqwWNl3ReXR9RqCmaIsVWr9h8qxF1bGCbG6ipMHv59qncg
 JK8FgbFOy6RIzR7HcbNBEy1N7sMTacm3Hbn
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-07-31 at 03:03 +0200, Mike Galbraith wrote:
> On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> >
>
> > Which graphics driver is in use on that machine?
>
> The all too often problem child nouveau, but I don't _think_ it's
> playing a roll in this, as nomodeset hangs as well.=C2=A0 I'll stuff it =
into
> lappy (i915) to double check that.

Hm, lappy doesn't seem to want to hang.  i915 isn't virgin, it needing
a couple bandaids, but I doubt my grubby fingerprints matter.

The same kernel in a KVM that's essentially a mirror of my desktop box
(as is lappy), running under a stable kernel didn't even get the GUI
fully up before hanging.  I was able to login and crash it via virsh,
and as with previous dumps, there's nothing running except the shell
that's me nuking it.  All the GUI goop looks rather sleeping beauty
like.. no evil stepmothers in sight, just snoozing away.

	-Mike

