Return-Path: <SRS0=4wEw=VN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E2C7618F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 23:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAA32064B
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 23:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfGPXO0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:14:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPXO0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jul 2019 19:14:26 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnWeN-0000yq-6K; Wed, 17 Jul 2019 01:14:23 +0200
Date:   Wed, 17 Jul 2019 01:14:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
In-Reply-To: <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com> <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de> <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
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

On Tue, 16 Jul 2019, Paul Thomas wrote:

> > > We do have trace data for a instance where cyclictest hit 5000 uS, but
> > > the file is large 11MB, and I wasn't sure if I should directly attach
> > > it to the email. What is the best way to post or send this?
> >
> > Can you upload the trace to some place? If you don't have storage, just use
> > bugzilla.kernel.org and open a bug, attach it and post a reference.
> 
> Hi Thomas,
> 
> I've put the last 60k line of the trace on the bug report here:
> https://bugzilla.kernel.org/show_bug.cgi?id=204189
> 
> Just looking at the timestamp time of cyclicte-2778 I can see the last
> two finish_task_switch calls are seperated by 5801 uS. Is just before
> that the correct place to be looking?

Right. If I'm reading it correctly, I think I know what's wrong. Can you
please revert:

       80e7f3b05365 ("arch/arm64: Add lazy preempt support")

Either that patch is broken or it got broken on forward porting it from
4.19. Need to look with brain awake tomorrow.

Thanks,

	tglx
