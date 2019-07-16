Return-Path: <SRS0=4wEw=VN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265BC7618F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BB220659
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 20:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfGPUYR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:24:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUYR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jul 2019 16:24:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnTzj-0003CD-Bk; Tue, 16 Jul 2019 22:24:15 +0200
Date:   Tue, 16 Jul 2019 22:24:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
cc:     linux-rt-users@vger.kernel.org, dunc.mcphie@gmail.com
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
In-Reply-To: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
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

Paul,

On Fri, 12 Jul 2019, Paul Thomas wrote:
> We've tried to make the configs as simple as possible, and for the 5.0
> config we start with the 4.19 .config and say N to anything new. (I had
> an issue with the first email I'll follow up with the configs if this goes
> through).
> 
> We do have trace data for a instance where cyclictest hit 5000 uS, but
> the file is large 11MB, and I wasn't sure if I should directly attach
> it to the email. What is the best way to post or send this?

Can you upload the trace to some place? If you don't have storage, just use
bugzilla.kernel.org and open a bug, attach it and post a reference.

Thanks,

	tglx
