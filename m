Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CDCC433E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A505D21941
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UOa7HWIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIIDMo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:12:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:46379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgIIDMk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 23:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599621130;
        bh=hGzYd8QpKUeVsLHhGXXCngHsrpy2Tys7KhO2nnK2y2k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UOa7HWIYogwZOYyid2Aw4O4w+K4NQYMUAs1K5njswP8cA8KNwLmHfGmNwBcMsmHry
         TTSbtMJFT3YWiGeoR8aA4oBJkvdIeTo+bkpk2mpWI6pLMML0DZhilW3sC2ahe3MaZ5
         xK62ojsoFJ7Ny0VyT94gErgIfe4/fCK/NEN/XD5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1kmjRV2GYh-00fmbX; Wed, 09
 Sep 2020 05:12:10 +0200
Message-ID: <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 09 Sep 2020 05:12:09 +0200
In-Reply-To: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:boqi8g3uyHFft8vQoTCT7Tae8b9yFScO9vIXQtA5vdNwUGkSkkY
 pcfliwQ7+tQlGkSPDnzzccUdCuiPmcNGQZpPbS5hasTkORDoV7zCnUoYzIHSn9G0MFx3WNe
 KJAFZVNqW3YnRPHc5YLOb1AJDNb4icC8TQ4siMzdlsDJMEArKYVRWRm6l7+4vDmHQUPih1j
 UbgGK5X6fLVwNOlq5BA7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OuPKnAqCiVM=:hZKEQaiNbCRFprLbfqHCg7
 C1JzFw6g6o6Jck5InrRAJxMWIB+NaoFVM1yxOwWenSYlFQR85CeOvK5xzmphPHFABaL7m3OFp
 XRHeWc3u2pOOM1Jd8LwyiE0z0piWXUSxaW7xl5P+5+OPx3LYiknryM2esEt6aWfgvcHFHOY3S
 y0T4NcioeXxyszlY/KiWh/Ar/OzPtbxU/0rIcsdcHZsfwCS30pqL/iI8V/txaXMRWJ8UTcPhh
 2NlgLnL/UrfGrKDRnQ+I8UL4qckYR4iDzi+/lBSQLmCZJhIr+hyc26UIhjlZ+MNu3lw3RT03D
 scO9UaMINM8E8dOMjEWb2fQSBD75Blf7Vg7SGJ28lE5bCFa7jvshj6ZLm7XP06OL9i5Ee/hC/
 Oe1Q0cU6dAuD+sxji9+pxHy1ROsbyDj28ZFTRvWwCzsyI7mfPw3pFK78n0Je+O6rtwjgWdXQM
 m2y+c6nV/cp0V2IxNmhmw+J2XToeWkf6ZpjDQb0/RqdapbFijQ39kVFgpjuqaPg2VWJiniEmw
 SALpQrD+rFoh5zchadMpVlq4cZ2Nfaz3hZyvxBuxGO1khFpwMstlM/oM3szA2XTvaCyOSYY7N
 ADSX0mZrkTUHZRjr4K0O/VvhRNWfsXb9cSBvlGovv5viSS9r03iCYsv9Lk+Cg07zlC8uwkU8Y
 yivIulQLRiH7AaA5bZH6iSoO+Ki8VJ0qToQVWBP2px66s+sdX/PtdrfI7w2RiJxZ+KUwcNJun
 h/4Z3tEOzHZb5CB8qZlbvhSpYCG/rTcMgK4vVCt+lnt3Jn9Ecn3FodgEswIwx81HlWBI1m76/
 iOxu9dvi5w0MPxuJCVFoyIHI/bU7XF7m0ZtS3i4pEmeJE9JodLNckMIrBdHDVn+T/qbuvjLa9
 jhbz07iCsN/Bwv2KT/a6WLRjgwg7YiCGk4irXlwjBgltFCtpRbaOGstZPjxr3aQJygm0JRqaP
 fLhBa+voeagBhQIqdDXwBDR8x+Uy1JhTjpolzUtWN1ZgUkKjg8mWccaOaVuMXxP0/sbQlhWJ3
 OIMjJXu27aVU1hMOgKus6thhFoaPwDzgx30AgTd3L9ZjjLLNBvsE6fL7iG2j4VY0NF9A6a4ti
 tztd/rv6onmNmeyi0X2RSXKX4VNuZPEHftAa9YWag4QtbPOK27UjrbcL1f1ZyhGzuYLhWFnXY
 +Lu4GtHzTFNRlD4kUkVQrOzPR05OjZc05QteBieGPAd+jbvzb+7ziPA7AsgrXhLuOWIpHCeGj
 uSK3Qy5pHAShf001h
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-09-02 at 17:55 +0200, Sebastian Andrzej Siewior wrote:
>
> Known issues
>      - It has been pointed out that due to changes to the printk code th=
e
>        internal buffer representation changed. This is only an issue if =
tools
>        like `crash' are used to extract the printk buffer from a kernel =
memory
>        image.

Ouch.  While installing -rt5 on lappy via nfs, -rt5 server box exploded
leaving nada in logs.  I have a nifty crash dump of the event, but...

	-Mike

