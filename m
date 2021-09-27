Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09109C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 03:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F7660F4B
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Sep 2021 03:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhI0DVQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 23:21:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:47709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhI0DVP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Sep 2021 23:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632712768;
        bh=PT3s6kMIIZ6ASUkplytyipQbi1kwNnKXq2R1RuNiNg8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=D56WfinM3eOQjrvTCw7F/R30GQ343AGq6HwZMXIPx/3QdBzkA1KP9vjdwxjXnXFWA
         DeIuXjrLQHaJSMQS+OgpAfBVhWVy5CdVIhio8Lkgg7gAJZC8rRY8vbHrej3xqc1tN8
         BqyoiIaCM4FG3nLFEFlRo77oq+vRq361YGeXSF/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.235]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1mH0qU0Mve-00LSi1; Mon, 27
 Sep 2021 05:19:28 +0200
Message-ID: <27fee469d80baea697dd672808108cc8fd7ec96c.camel@gmx.de>
Subject: Re: [patch] Re: v5.15-rc2-rt3:  WARNING: CPU: 0 PID: 12 at
 ./include/linux/seqlock.h:271
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 27 Sep 2021 05:19:27 +0200
In-Reply-To: <87zgrzbcei.ffs@tglx>
References: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
         <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
         <a105fecc71d4b721d4e025e2caf2b13336b5d0fc.camel@gmx.de>
         <87zgrzbcei.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VA2Mxa7bWIEb3domSHU3KukOoDwbbj31vXPPp9KE3NQ0t/noZnN
 Ti0fXExrKf69VWsk+5aGFsiWHpBF5TGLn+pSxbSx4jMvQ3g8jYV95KmcmQqpdROqPRTGlyA
 IlNrO/SBPzbSrtaGJScCd3Cw+zpT2Aa4sVF7+/DmkxpwA/uy7/nXZAFhwr8pg8G/o84Jxqp
 Yxgitx6qTp8BLRclBJmZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FFh5izemXUI=:OGzmsPRy8cUCtrcMKK2NmV
 GjM7atN5unO58kwiZjiqqEBs/USBItEff7i+ySSRpAMAA1WzfGkVrCHx50vv7x3ktYe23IaYM
 xHSVsNt4V5NVcv+1/ZAeqcIZozPsqBTRbC0yJnTHSAQx/+ihHGN0qxrvWY9AfVHUSgUepYLio
 ZUBT+Z6xowFskkUNDH5P0teAORPV+WLX0JAGbBMzL1RX6ZEW6/Dys7s0F/UnTYNj5n2U2vP7F
 l4jOgqfqDwjpailNBbz6Tvcbq3fTalNKiI4l8CrEOzsiE+9yOI23j10aIjg3FYKdP+ZntXtgl
 6oC8APKzaVedbpmNb1AGbi8QkHPC7JlWFPMhYE1uXqOX8bGhWEpZvSw/OCeyi/KG99R61U3W1
 92J3lInNb86ifZmo4cWjt8OBZ95vSyvMG3D85U6q3UwmOwpXO7oZXTYNW4qApfDhueipk86hm
 4TvSjzr0QIk/l79Kd5WZdN18McnNiv+5zbJoupO38hA45X8iucm4Va19hjWhQDe6NbhcTzBx/
 jXktncmriw9ZRgdyhSrn8ub0m6xX0xcnUd2k7vlW11NAg1S2y+4Dwp2CV1LKscJZt6W8hljde
 ZpR5e2IolBRi/LGmjhHUJHd4+06bAma2+72I6QAcoCpMIJuwetZAEDgOVWqr4z0f6fIn5Ay/+
 Wt+KDH1JflCgXZ1ysCzSXsFEF7ZuwMeOxTdpiPvZ3hTFVbcJoddXds5dNGUwFSDKTHs52JlYt
 onY0NmbOo903XoRGvYgpVnT9AW1ckbMYuNXyoc4R32lfJL8aeZzvajhEjLCeGLNJPdDZApQJZ
 sqFPE1gzLetT6zukb1DgPNyesgTp2TQy7xfji+7R9srXPx65RqCZXfefrybrbwztUCfmWHQ7y
 eYJiFG7RHLwND8/WzICKoN3bNvwBNAVK9Lft2i3Awu1WXj1nvOzpEw1Dnx7UbQQCT6iL4mJIz
 3HIjxTAvmGVCk3UHMrkZiQe4nRuCtyn2LpCF2chR9AKRx99B/ilIHe4Af3uhHEgozwLgLvR0i
 kGfeKIAAynQelB01nZOQQA4FZv80u5sCLLXGQNhVr8HyJsZNXVgKB5mH0zIaiMRCEu2y8rbdv
 acQ/++KGCUUYes=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-09-26 at 17:10 +0200, Thomas Gleixner wrote:
>
> That sequence count is protected by brmctx->br->multicast_lock, but
> seqcount_init() does not associate the lock.
>
> Untested below should cure it properly.

Yup, it did.

Hrmph, there were even free samples in older trees.. that live right in
front of me.  Bugger... oh well, bring it on trivial seqcount bugs, ya
barely scratched me! <shakes fist> :)

	-Mike
