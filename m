Return-Path: <SRS0=0bHC=D7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041AC55179
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Oct 2020 05:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E36222254
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Oct 2020 05:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bVJoE23/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759592AbgJXF0H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 24 Oct 2020 01:26:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:41379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759587AbgJXF0H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 24 Oct 2020 01:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603517118;
        bh=b3ZhFExOM/Mi+jTGQq/8sj0hlfcBhjmxWLijxZQ6gmI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bVJoE23/yS3qF93ysErE3rRfSbkzM+/bZza5CS8f+HoeAnG5fPbSRYKrOJ4Qc7o5S
         J0SutYwo1wc5lBdSQt9uEOaRIgW4KUUhPzleimJ/v+vLqcSnoDeVVUswYvboJe2MiR
         rdHk79eYKRSQukWxbfmgKKLtA9anjAg2YzXOy6Ec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.151.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1kJyg53NB6-015Fiy; Sat, 24
 Oct 2020 07:25:17 +0200
Message-ID: <08aa64d8e07b8b7d4509a0b3233d0c46ce7609c0.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Sat, 24 Oct 2020 07:25:16 +0200
In-Reply-To: <20201024050000.8104-1-hdanton@sina.com>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RC4oGzib7N1JfCTG7d08sLQGw5Qu6NK+FnY6BWAQSPMnd5X+V3k
 YBxePLrmZUCzcLEXbm5bu1I9esZOLfZ7y9KUJ62C796GeGeKwnea5dltWVSbvx+xCOAQ1pJ
 Zei6S0HSoF1zsXNZn4jD4ZCFVGa4F0ubF3bt35iF0ysUnHNciI2jXuYKlcyYFGK1hr6MBYY
 hxO1J5Atz0YbPnBEwESyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQzq8qQSGaw=:uOCtBOoUFo7t5yzM55RQUY
 fdeMhq4Jwcd6GjuU56ZS5/en05cfnG5ePJD+KrH4r1kVxYS71s+7w7oVqkVjIdBoCGs2/OXid
 urLayNfi4q8S54ZsqZhO8FAb42iMjjylatsBclr151I5Bpu4D58PDPrarKRbzwd3Xg78XAnFe
 lzNx2dUK6tI6UeHBrxvBBbGZzVAJPiGZj/2aPm4aBnmkVoY3dop2PRt5prAfjeUS1z23/dWxz
 ZzLEZZv2RwjuNbK18tM5jm+Ni7ghyFQWU/FD2WiKv7mM/u4Xc/5WKEzXKa/8QGJIFYcw+J3al
 XzDYsq3x5q5lsePvNIcDRbOfEvG5/UpCuBYPuzkYtGQhrR3vqwUTY36PT6CjKWxGzvtgFLNT7
 IcSRU8PJNgM6yKZYPdkR/97D6rYtCkfAH1oMSwP9CyDeN5Lm50MGpXT9skKTgJkitzosXxgaO
 aWA82igzENay4s/Um3HEsNjCLII6TTxsYUEsMnmBA3N/eV0ZQ1sd208Ubx1PVEGDPHlEW2fnf
 NMyrePkIDXuEuHDYYSWFv6j/LnR9rC/SMoO+5iQhwiEDo5w9iD5PZfyKfo7SRaKjS7n860gi8
 dpJFnQHVgB/3OUIyD4TmniT5o5k2kgABNbi2n++3q0ao9vNSPzXeEWq1MiWa9a8YbVA92Qvpj
 TVjlGHbFA8wR72fHwJssXLwSFXe31eP5mgXKTcXAQKO/VcmseSV/r/dvVWoM3xM8EKHtfeOpQ
 ucEu3cwd/VGvkGQoLlDnAaJeICwk9HSSY7lbW3Ey71QQDBxBh1mKy6NAKl6ofYzXFPo093zPU
 1aeuBOGBO64GDfN7Jm9IGsa9QvOKE5ZrMgfqBHKssRgEcH2Ng5+jRIylThWqefb8Jrsbpkk3g
 Kx/HUqOnIsmP99dwwFYQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2020-10-24 at 13:00 +0800, Hillf Danton wrote:
> On Sat, 24 Oct 2020 05:38:23 +0200 Mike Galbraith wrote:
> > On Sat, 2020-10-24 at 10:22 +0800, Hillf Danton wrote:
> > >
> > > Looks like we can break the lock chain by moving ttm bo's release
> > > method out of mmap_lock, see diff below.
> >
> > Ah, the perfect compliment to morning java, a patchlet to wedge in and
> > see what happens.
> >
> > wedge/build/boot <schlurp... ahhh>
> >
> > Mmm, box says no banana... a lot.
>
> Hmm...curious how that word went into your mind. And when?

There's a colloquial expression "close, but no cigar", and a variant
"close, but no banana".  The intended communication being "not quite".

	-Mike

