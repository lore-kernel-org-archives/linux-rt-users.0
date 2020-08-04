Return-Path: <SRS0=RXjc=BO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86884C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Aug 2020 01:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6B12072A
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Aug 2020 01:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgHDBVm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgHDBVm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Aug 2020 21:21:42 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E14C06174A;
        Mon,  3 Aug 2020 18:21:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51B341278B058;
        Mon,  3 Aug 2020 18:04:56 -0700 (PDT)
Date:   Mon, 03 Aug 2020 18:21:40 -0700 (PDT)
Message-Id: <20200803.182140.1686117972461864999.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org, claudiu.manoil@nxp.com,
        ioana.ciornei@nxp.com, Jiafei.Pan@nxp.com, yangbo.lu@nxp.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpaa2-eth: use napi_schedule to be
 compatible with PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200803201009.613147-1-olteanv@gmail.com>
References: <20200803201009.613147-1-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 18:04:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  3 Aug 2020 23:10:08 +0300

> From: Jiafei Pan <Jiafei.Pan@nxp.com>
> 
> The driver calls napi_schedule_irqoff() from a context where, in RT,
> hardirqs are not disabled, since the IRQ handler is force-threaded.
> 
> In the call path of this function, __raise_softirq_irqoff() is modifying
> its per-CPU mask of pending softirqs that must be processed, using
> or_softirq_pending(). The or_softirq_pending() function is not atomic,
> but since interrupts are supposed to be disabled, nobody should be
> preempting it, and the operation should be safe.
> 
> Nonetheless, when running with hardirqs on, as in the PREEMPT_RT case,
> it isn't safe, and the pending softirqs mask can get corrupted,
> resulting in softirqs being lost and never processed.
> 
> To have common code that works with PREEMPT_RT and with mainline Linux,
> we can use plain napi_schedule() instead. The difference is that
> napi_schedule() (via __napi_schedule) also calls local_irq_save, which
> disables hardirqs if they aren't already. But, since they already are
> disabled in non-RT, this means that in practice we don't see any
> measurable difference in throughput or latency with this patch.
> 
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied.
