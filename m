Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FB9C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1111761028
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 05:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhHNFea (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Aug 2021 01:34:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:45799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235990AbhHNFea (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Aug 2021 01:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628919229;
        bh=QCh3TzSHNoihXdSnElWn7goBB9nO5/wYtGGhDJybJkY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TqA/yB8v+gxbTFeNzUolbyWbGc875fm+Rf+fYkzd1f0XrmPFpH6iPmSCQSxKSOczN
         njuxJpFua/R7dl9gsZGuLm0KAtKEE+kzY01OEvURim4/cG8395CRXhNnpTOfHWLW+X
         RjqUzL2qs28guWt88Av1shXa3v7PAkHD0MdOoDg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.95]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1n3iOY2CuN-00sxtP; Sat, 14
 Aug 2021 07:33:49 +0200
Message-ID: <522000b97adcfbc581e7e5ed1afc94519b1388b8.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sat, 14 Aug 2021 07:33:48 +0200
In-Reply-To: <8c012c35852e98af99a6b6234a3f57ac27cd980a.camel@gmx.de>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <8c012c35852e98af99a6b6234a3f57ac27cd980a.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nb19Y8DOaPd4dtyWm1vIibFn/JGG92vLhSbuFTyLCvKTNTjiQH0
 ZhgaPlgmB0PH3DBTykYmPhWfFLby9ku9cLGewV+Ahw0SHgfjAkt4TrnodxVXVpoZNU+7l1n
 RCE/ba72VPzo6x4NyrSuODR1cRR7HLd8FLlh54CzNcJ/r6++/L9w1epGMYOPQabqSN6kGm4
 8jFPr0V/bvXW/9yCREqJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYjSEs+Tdgg=:Nfu0kS4HOKQwpzr+bQLOI4
 MAo8PdVR8mofDWRNREmDGb58bIPEki7e8bPbMHzWvSrvbYWCXStK/2rFsMswFWjb5CwMW277G
 3UNq7g6m63v19EXFgEDQhiGYb//jNRiXA5nvzAhII3sEX4tPuJsokuRCqnLbR4K4gpbcUYL5X
 /H+0Uc4hkBZo5PD7DTM6cAZZMz8Nr52/Ebgpbl/GbWyLsaXxaEPPX9rNEbgUg/M5i/5JnswC4
 MLT7mi47ZZUKbvn3mWP//i6GBUPz88xOBCUiL6iWiJteos6GpHQeg0xtDILGxDpCxGSPgO3oY
 4R43MRRxhmYVzQ6TIqL2+2ujnP6tAN5PVfwHYJgt+jWJ5S46ErYDsoPJ7e0L7bZVOh3TbJVnY
 XeTdZ2jaGH1ydxYfbUx5BnJp52yXpMNVgJItq+jpE8InbESEWpH/s/GYXtJRhT3Fr0PAfnBnE
 Nxjlouux6JWKad3E7J1HvwiNd+rniJydpHItEeoc3/zedrZJB6NMy5baN5/AC1zoG216t7FyJ
 y+qS4TZrQtQwB7e9VolR8EY59XCGr14+RTCWiG0AdVgPQ9IKFX6LDFG/m6tuWmb7uJm+zUjtI
 bcq77uHcy0R05A/FokCQCba4u2aSHtCP9wvGHo7gkovUJAJxqFaxo1nmdC4hqU99UnE4xAJf5
 l8RmQbc4GGP/rJDJUkOpgdfvG7Isbj5RbZAgckzoxHuSY2P+A4c7KHHqIKqQ7i1EAQ7CU5zDf
 Evy3yoDC8nbXp+U2xu2YOLJ9B3iir61jDBVQVbijgUZmV0MKg8hdNZG8AoL7C5FhqYjBk3II+
 HirtWuwThAovKiRJdYVBi6moi6SZiFZzatJOftymdT5ZuUZzTB9A/JQPyECz83mAfP7cQkfeu
 pqUrtww4tiQQuo65n00Q1z5NloYOyKTLtDhZE/W3QRHNDU2FW7dlANfZObjsL4E8r42vc8ToK
 sRsnRorXSwB3iPuUe3dI85+5F5lEg8eYyg5VMxk1eavOIS5f891W9LHq429BN+m74GPUoFXMo
 TP9hgD22cPBF3Z5lg0A3uethndgMgaSo0nbaM4Ci1khIzJTXkWGzilw4YI+8sJtAYkp99n0hs
 JEJUJWau4kqC3jteWDECGJL4W/nU2kcn1xo
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-08-13 at 12:56 +0200, Mike Galbraith wrote:
> On Thu, 2021-08-12 at 15:18 -0500, Clark Williams wrote:
> >
> > Sebastian, et al,
> >
> > Got the following panic running v5.14-rc5-rt8:
> >
> > ...
>
> > Config is attached.
> >
> > I was running the rteval script that kicks off parallel kernel builds
> > and hackbench runs as loads and runs cyclictest with a thread on each
> > core:
> >
> > $ sudo rteval --duration=3D10m
>
> It took my box more than 10 minutes to explode, but with all those
> debug options turned on, it did manage to do so in fairly short order.
>
> Off to build a fixed up 5.13-rt...

...and it reproduced.  Transplanted 5.12-rt slub seems stable in both
5.1[34]-rt trees FWIW.

	-Mike


