Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078FCC76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBA32077C
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 08:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQIKW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:10:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGQIKW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 04:10:22 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnf11-00088W-Pa; Wed, 17 Jul 2019 10:10:20 +0200
Date:   Wed, 17 Jul 2019 10:10:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
In-Reply-To: <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com> <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de> <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com> <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com> <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 17 Jul 2019, Thomas Gleixner wrote:

> Paul,
> 
> On Tue, 16 Jul 2019, Paul Thomas wrote:
> > On Tue, Jul 16, 2019 at 7:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Either that patch is broken or it got broken on forward porting it from
> > > 4.19. Need to look with brain awake tomorrow.
> > 
> > Yes! this looks like it fixes it. The hash I see is slightly different:
> > b7f42e8fb48cbe38e4c2d0cab48309aadfa6d032
> > 
> > But the name was the same "arch/arm64: Add lazy preempt support"
> 
> So, brain works better now. Can you test the patch below?

Bah, ignore that. Still broken. -ENOTENOUGHCOFFEE

