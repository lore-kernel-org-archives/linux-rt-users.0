Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFBC433C1
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 03:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83586195C
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 03:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVDLp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Mar 2021 23:11:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:42709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhCVDLH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Mar 2021 23:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616382629;
        bh=6536XVc/gAsAd4F91AEn9O913I3emGi3sMYtABF4XeA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aXnCTS4oMV/L/EtQZsXG/6fKyWNfib/1QggeSay+rJIEoINolTlG7+HpM8koKMnNr
         CdGtxFUitFuBJLnqGa4ChhryouX2Jep9LCkjw84TahF6+vawW+bIvWBBoKG+6/CPPW
         rqPJVNnP2g5qSFbYpkL9CThVrb81eaH5jPK9MMTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1m8GwM2BR1-00k4Bh; Mon, 22
 Mar 2021 04:10:29 +0100
Message-ID: <e984000bf56be980f87c39bf644e139e4c39ddbf.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.12-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Mon, 22 Mar 2021 04:10:28 +0100
In-Reply-To: <e2e51e78094d14f6795221734c2fc8d66d6455a7.camel@gmx.de>
References: <20210319223357.uknv2t5uvxvzb46x@linutronix.de>
         <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
         <e2e51e78094d14f6795221734c2fc8d66d6455a7.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1EPMaBemTID/QUu9iSqWFTAcUiGWdtA00gXZXFw6vHORXYh2VW3
 CxEpNvCXOjyTIWxvB3XYqIUnqBCGy21nGxkrGsh+ziWSxhQZdskUq7CFapTcLWkP8k63rvT
 MWQ1HfSTd564tIV42bN3Cpq6AiUqb8IwD/J5VgcOvfbRJglDKuW/keBjeJ/Ca6tYiGacLWu
 OY4DvhDDyT4IdD3NPb8CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tiPYwmK+iZU=:9uJ9o/pGnFspcJ7Z0utlMm
 qmmkh0qo/Fdh7h5KC4itJRTQA4fVdrSjCBYDs1srRzAHsQqoEtyk+mKN6GwirlnRhZ7pg/7F6
 kt1BthpI9927JC758dzDvLRZLKLlxq44W3xuWoWYFytrw+Ni50mbxeNtk7MiHtfNhKwl54Mf7
 hyrbbrMKGsxFh4zn59GMhkkDNGX7l038ahcf3NaFKvpuq2Sttu/9hFdqCeQWMRd1l93BK2Dov
 /ku6xhtz1qxK2hKvHtFARX1NzeAlxVEQg8EGAumNu7GxHbcvt5KzpY8uZ0n9/njJhlyvDId2K
 bi71Q7mFLrUwd/iXfz4pv7y4OvAvnZnn4rWt8Fmmbe6ItudTW9waIs5X1Wqi6Lb8DiVIoPtuO
 yak3PjIRdZZla/1eFpJxiO92yBR4Bf8RPKsHQbMQv2y2IDDDNZjPHuUan6xGHhM22qFOKT+5W
 IqsXgAqQslwG5W9mIGprCoEFJH6JV0vx/EZmO6C79LJvmtfxjDxBMJ6NOOATUp9y0BWIcCves
 2VBBtRnK8r7GRWClK5rtqx7NoiN7ATmIUlEsFXRmSWZ04T2Ai6e4rhbSDAxGwkDOzUv6iymWc
 z609dcwS+OF3+3bPEbB/d84K/HzeCtpfCDXsdXoBvGXuThjxkXSgdY0gGZ0D/qpWaokyAp+4M
 7TokhIi93RLXQHaQZzxp2Lkw9pIS8du51jmo4nKwGrnyVQzf4izbmfut5d/sq5x7YQDblANgZ
 hD9gVMHdyBS8KJPri3rKroP84OdyFbXconwBVIShn4Ef6C8uPSbH3cnhlVloDW4mD0U+hQ3Fb
 RynH/93s6L0dWyFf/u26wSSjo6OPim1SK2XqH6gOGKKrD82p+UdncfXTjMWXjr2nGJr7GfE7F
 YGpHTRFkqjwkBLYcs+0w==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-03-21 at 08:46 +0100, Mike Galbraith wrote:
> On Sat, 2021-03-20 at 09:18 +0100, Mike Galbraith wrote:
> > On Fri, 2021-03-19 at 23:33 +0100, Sebastian Andrzej Siewior wrote:
> > > Dear RT folks!
> > >
> > > I'm pleased to announce the v5.12-rc3-rt3 patch set.
> >
> > My little rpi4b is fairly unhappy with 5.12-rt, whereas 5.11-rt works
> > fine on it.  The below spew is endless, making boot endless.  I turned
> > it into a WARN_ON_ONCE to see if the thing would finish boot, and
> > surprisingly, it seems perfectly fine with that bad idea. Having not
> > the foggiest clue what I'm doing down in arm arch-land, bug is in no
> > immediate danger :)
>
> Actually, it looks like a defenseless little buglet, and this gripe
> simply wants to be disabled for RT.

Or completely removed instead.

It's entirely possible I'm missing something obvious to arm experts,
but I don't _think_ the register read needs protection, leaving me
wondering why arch_faults_on_old_pte() was born with that warning.

	-Mike

