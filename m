Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1157C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Aug 2021 03:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7C660F46
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Aug 2021 03:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhHADhw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 23:37:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:45415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhHADhw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 31 Jul 2021 23:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627789018;
        bh=6XXJXx+B8VKjyQj6r5lwRQRASHQ19Vs67JH7oNnWrqs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Zyde+j+l0uaPx1E4C/OYLAyPLjY7BE8965HpuPaF+1Pf/A6lYqM2J7Kyg57DfTDHc
         CTnfep6x6R4wZbgct31dhYHkS6gN0WNhhsDCkmg4EQba/OZcGMnM88Uy7201A9VXly
         hrZgKFjjoQD0wN5HJyejSDrOo3JtzqQnuqpRKAQQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.118]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1mNFhS1w5Q-00DEjT; Sun, 01
 Aug 2021 05:36:58 +0200
Message-ID: <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sun, 01 Aug 2021 05:36:57 +0200
In-Reply-To: <87pmuzsf1p.ffs@tglx>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAhS6De1tBjzccsz8ujEyarxfwzTih35RCivZSjCr5Qv66InnU0
 75xmt73ZIWRst18TIKvzf52L8ouhk5b5EFA1k8DMKEJBuU22jqzE3kLdpHi5ob0+1nSK+XH
 31/n2H3K7sG57XHSWB+OpOPK8ycXOJTTv5kY5useV5Vt7CdP3QopdjTz9yx+sjCky0NOIbL
 bmSGhDDAslcW6vA+SNThA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ke2jBLI0zwI=:toeU2N4wRUsSAZYYN6dgeT
 9q947aXCdTrUhlZLiOPkgC89o/Y0Upq1lwHYtGvsxEes/LxHgpVC8/kg20ghDGobOmZhO9UvD
 Fmg4U82M10gpqPQ4bgrxEd+4ILBeuD+8JJWNM5yTE3h2PrIUM7r/ztE6G1Cn4olggU4Igpgow
 xDUbUKb+yekMUM4YCWFS9WO9PBmX9GwycPsiDDHmb6w5xTZa2bAtd3RATwhAA+QO3KLiLBkJH
 hOWdnmtCH4lcnpb2TDTdwPQLSmrJmv6EuyywYUctBvasK9h1zlTVyx9SOjHU+zI5UM6y9zivf
 8qsaDpsCrzX8U3tCaW4NDa9gq/7fZjLfVlKti/O8ysiwBCelsytSXxj0UoEUGhntRl/KhtHBd
 71ZOceIqD1vVNwe3wTchR0E31Tz0o93jkNA6GkitH3hKd/3bZ3Gc6+WxhvmdsiO8xH+O5mhPz
 ZrO99qiigJTsRjnZyHMM4T/qVG8Rf+mxaPCPCBpS8SeH8GznKntUQ6M/ni5KgRfpLs8+9nA3P
 mwmthSb5Gtb0K5sBA8yT2D9zvAu8F7q8sPpzmEIXIuZUvvBv63m72AM3QoJ4TeNpTMBuuLflv
 wwJoEYNJW9WrJ4wk8aiNk9MKfaMGe9oRbvgVb6WJkP+4IPHPPWuT325qGeMNlosEXP9BCsdCZ
 zRRrrNApupGqxhMh4ABmMYA0u6YypJN0RWIO/j8xw7RlsEWpIdhdPDCCGCMYVw+P2HQSKfQ72
 cvRVOhaqYD2TsvYOdnaB+YYV7BytWMCSGTRQ6waWhkqH3aBO/EfdAzRxdrbj4dZeqrZBKwQuf
 k3OVJvJrENqUxxHY4mT81r/0bAu/D5/jMW1lyYLURXdHUVpEWTgyThEiY1eSW/QYWdv6OVc3l
 mFR/q5iwINWjXSIZW3BbqUGP5vUxCWDndt8huu5DkDMpwLDW7lyQgQGG/OIO+8rdDg8aK3Eaf
 HxMyZLUtxIxQ2cD40/4RVNXUVUbdC/8K2pLV6wY8AHungalR7Vn4YeDM0FGcN9Bz86KOHuQmQ
 1KWdGiZGri2Rh/qjGonzdDeGhnoxc1ch4QkrUlobTPgYCC6H3utnlNO1Imem7axyfgUJRVU4/
 qWzV1t/Q33Y0ZGOB0McYyJuTMZweCSR6ePN
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> >
> > First symptom is KDE/Plasma's task manager going comatose.=C2=A0 Notic=
e soon
>
> KDE/Plasma points at the new fangled rtmutex based ww_mutex from
> Peter.

Seems not.  When booting KVM box with nomodeset, there's exactly one
early boot ww_mutex lock/unlock, ancient history at the failure point.

	-Mike

