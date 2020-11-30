Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD0C63777
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F4521973
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="axy+r6bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgK3Q4K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:56:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:53959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgK3Q4K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606755237;
        bh=aLmIcVpQyq4A09c6acl7nMq3DkN2oex3ynveIly10dY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=axy+r6bP7rJUiQafduNXCwNKD0fXjhjbHwW+gcIBtBOog+kTWooenD2HSPwKTtS6h
         a8GnIf5iQKwTGD2g/FhCmTy0rbhPpaXuE2SOa2HIpMuGngOk6qGcRKkfegNNEERpb7
         1RqZnseClh90OQthOeTcXVSerENPQZhnFEi6UIao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1kfypL2Bow-00VRLB; Mon, 30
 Nov 2020 17:53:57 +0100
Message-ID: <b1b8c2d47329152c9f2f2dc4eba884e1d7262c4b.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 17:53:56 +0100
In-Reply-To: <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
References: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ye6oh4sYteHp7jCH6ukf5CTv9Lo0c9RMuT9g9rtdV7dJNmxvMtU
 hPzVtx2cVk/N0+1hIdKLpCJ9AKeu9w6+MGcQQJCxrm6uYSTCRdB9TrMjxxOkbJCpWPcXf6Z
 eHqztkbxkr6b0RY+NjjPN7e+4tiCswdaYoNUcDLwuuN93oupAb2r28oIYhmBFA23Cl8YSQj
 2u6q7ZXi3gapqMKUit7jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dRDzPF7e0Kg=:aA+ZRFGh+PkJFiS6IKqm+u
 fCLKf0T7HbfZNKecYkrbNSIpbQPVYsQw61mJ3H679Tiy1p+acB3SPSzSGg2ni478gLewPqtA6
 xxWASBV2f5slJyVW3/2LA9y9/IuXVLyELH5HGFryFB4DM+ZuthA1D9qxsQdZwUCMq8pWOaxCH
 Qncs8wZpWYDIrH6MgLzqbcW8IBn7YTfuq4134hsTqhVQWEWGK1ImRUQJWf3S7j9cUori2MEBP
 IGNryThn+q3ZZrYUJW2QdYT3h0o3Myv7S5yuHWAKO2CQU31wj7DnMgL8jU/En5jQvfSXoNpD3
 B5vTqrsqB7+5qAfCabApLxG7vBrAT9pwa4DSh58kYqKfCoKxxdxFvZmGEJFVkPPIAxI4Z5MbD
 jIRR8hSdPt1d0NwXU2MYOiiReMzSTmL64giG6UqYkBAGMt72xUh2gTNNdjgC0rxhiqOM8LDWf
 4ZMQOZvshjfCdl/iOkevoOpuTrv9GMbyabvzinO8CDWtDXqFLqL/BvUhesJpeOxgKm3Kyy5VL
 W3NOGfKd3S+sK3mwBlFs3o3Kpil/DAmZzqUcAbtjiPUjgvkb13S85Y9k1w57jaSTpefRebUsX
 wcLx20fF9jCA2huEMOFuQtyqw24b/kFch0EeiuH0E++xP+8Vjb+fXanvFon5q5GEB0XyUHP8i
 3AQejEK46h5SQErqdCOPaT64Fecal9BDYOA50Sy8QajEsw5FbAAM3i1rSUZ4R8Jk1Xl/RBJa+
 xaqt+Z5MvGf8MewGeDNRIZRANFgyovMiFbBTupETft1w+J9MeGtX0s7gY2BQV6R1dHOfSUyJS
 cniQuHirMoWUUXN4YMffgA7hXKkE9opi+sxmECJ2WCQY/nqgt7iIAW2+vEaDgNyCtlW+G4GpF
 mDcHwQ2+dzHZiZXMMLtQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 17:27 +0100, Mike Galbraith wrote:
> On Mon, 2020-11-30 at 17:03 +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-11-30 16:01:11 [+0100], Mike Galbraith wrote:
> > > On Mon, 2020-11-30 at 15:52 +0100, Sebastian Andrzej Siewior wrote:
> > > > How do you test this? I triggered a few oom-killer and I have here=
 git
> > > > gc running for a few hours now=E2=80=A6 Everything is fine.
> > >
> > > In an LTP install, ./runltp -f mm.  Shortly after box starts swappin=
g
> > > insanely, it explodes quite reliably here with either z3fold or
> > > zsmalloc.. but not with zbud.
> >
> > This just passed. It however killed my git-gc task which wasn't done.
> > Let me try tomorrow with your config.
>
> FYI, I tried 5.9-rt (after fixing 5.9.11), it exploded in the same way,
> so (as expected) it's not some devel tree oopsie.

It reproduces in full distro KVM too.

	-Mike

