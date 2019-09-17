Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85282C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6217721670
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 10:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfIQKwj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:52:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQKwi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 06:52:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAB64-0002Xk-Ty; Tue, 17 Sep 2019 12:52:36 +0200
Date:   Tue, 17 Sep 2019 12:52:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin.Wirth@dlr.de
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Long latencies during disk-io
Message-ID: <20190917105236.yf5btniiq4bjhimo@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913150645.nqt4ekv466yby2a4@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C520504@DLDEFFMIMP02EXC.intra.dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C520504@DLDEFFMIMP02EXC.intra.dlr.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-16 11:30:30 [+0000], Martin.Wirth@dlr.de wrote:
> Hi Sebastian,
Hi Martin,

> But in general I find it not very transparent that with the latest changes softirq work can block
> higher priority irq threads for several ms or maybe even longer and nothing can be done 
> against it with normal RT control-knobs, but a change to the driver code is required.
> Isn't there an automatic way to decide, when it is possible to convert a request_irq to a 
> request_threaded_irq? 

If something is automatically converted then we need to disable the
softirq while invoking the handler. This was also the case before
force-threading and the interrupt thread may assume such behaviour. If
you explicitly request a threaded IRQ then there is no such need because
the handler knows what it does and should disable softirq on its own if
needed.
Due to the softirq rework we can't have multiple softirqs vectors
running in parallel _or_ have multiple local_bh_disable() section which
are executed in parallel on the same CPU. This made the softirq code not
only simpler but also allowed us to remove a little bit duct tape from
places which were expecting this kind of behaviour.
In the long term we need to figure out if we want to go down that road
again and if so we need to figure out how to avoid that duct tape…

> Martin

Sebastian
