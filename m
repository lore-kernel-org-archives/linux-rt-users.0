Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B9C64E7B
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 15:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A250D20725
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HiZwWezb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgK3PD2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:03:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:47151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgK3PD1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 10:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606748473;
        bh=h5Xcjdxty0RDqjnuXY7w+TO7/Igyokq8MDI/tlnDKOc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HiZwWezbyPPtkIZjYVP26/gfM/XGZROwXdtVKmrz7Lw+fbLYBSbYm+hhqWJB5Tz0l
         dCcKkg6aPB0uI5/BIDOQnQHjpFTNb6FSYbGrRqmIgRg1oU/zpsLl5VordqAwV/3rxQ
         Pu5EM7+Su34g0UAP/uXELCKwhO/27LDhA9vG8AlI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHns-1jvuD52S1i-00tmua; Mon, 30
 Nov 2020 16:01:13 +0100
Message-ID: <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 16:01:11 +0100
In-Reply-To: <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
References: <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
         <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:doTPtowmIutSdqzABFuzY91S4epubBxrrlFCeAWfhn4H+RQLEeq
 ni7mvzJjlOBu2nOVcXAgvsyU6P5UW0zK71SVdqHwfPIsq8/vCpNg5OM5sf1V+/Xellw4XiS
 KDDUVhFgGp4TArY5yOyFpmFdmqsdXa36qwTmU7x7agBvYUR9SLUxhiskNGOGVZZeOwP9OrU
 B/fCVgLKwaJAdd5qLlt/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XH+FG8BWMj0=:wrmCJFtG4HyHn+yz0TfDBd
 vGP8Hh22nk+RQEItNXAVxa+eleC861gGcXneGA31OQt7r+ePL6ysivi9CvW28Ts7ZmDpc1A9W
 V4mQ4Lc6X03zLKVRQikPCfWFQWVbhOXeXZ0yU62bZNtaerK1IZIXnGEKFQMtw9JtU3B2e7gcA
 RL7mKmCHr0oVaj+R4YEpqGkTFy8B8U9lCIDWSOcWOZQ3nFKMARUMsh8Z0+yf+j8nDBvZ8/huG
 FEeo0DlO7y1PGwe7VXJX49F1TaHXCLBeiy9yDuVBFRwvJOCGl3MiBFiG5Fx8Wg4jSDxUdcWMS
 1unLEAaLvg8BmCrB7ycsWcuQLhF05eZ3biSmA9ptVrEKOLaaLttjyaIYEb6xVvo7p4yWxxn1p
 GzafOQxIQ/LGGDFR6NhR7UBBR/VA0rGTu6Bb8luAB28qZa+FQO/p1apfwWn0qqb/d88kND9W3
 zYHZiburOTkdUkpWqQBAwaoFlKdA09JDQsk/nLBPyH34QIDIWkx7F3dOYCcO31OF/gOD+nfh8
 Yr57x8spw/u2CLAwackp3u/PAXyynWUlXLD0cF2SbYqbXTLQH44wvnnLHCFyeIH4T5ko3CuVo
 9m9sFb+m5LqDzJ8CG3veI4D19s8S4jYBG9Zt7xtdz4L5CPJbvAj1F99JFoSHEeIF06PAXcCD4
 U+ZxEShJUdsDfaIG47SsR0kt3np6tS9YwAVTx1wDv6q9u9QCrAt74px6EYmTPE7LSkREz9Ujm
 Mkd6B3rx2rqMLLwSAweKqtTV0IJwO0o3fqE7iVDslgkwBmzQZ1SYbXrW/T0OPzNP/JwkKR5qJ
 YjEF+m9+K7fRG1MHs2+H472uL9CTtRi3BYmbWX6KUqdWD3wTLXhaq1JBsZ9NuWE0y+jPLhEwW
 /ZGvx/VPkq3r08Ed9h/g==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 15:52 +0100, Sebastian Andrzej Siewior wrote:
> How do you test this? I triggered a few oom-killer and I have here git
> gc running for a few hours now=E2=80=A6 Everything is fine.

In an LTP install, ./runltp -f mm.  Shortly after box starts swapping
insanely, it explodes quite reliably here with either z3fold or
zsmalloc.. but not with zbud.

	-Mike

