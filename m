Return-Path: <SRS0=83CY=76=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88239C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C972082F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 12:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFQMBi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFQMBh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jun 2020 08:01:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB843C061573
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2020 05:01:37 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlWl5-00008R-PH; Wed, 17 Jun 2020 14:01:35 +0200
Date:   Wed, 17 Jun 2020 14:01:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200617120135.s6ze2qa7yjrzqyxy@linutronix.de>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
 <20200616165536.GA306273@fuller.cnet>
 <20200617074223.wtd5lsxbpvqvbxs7@linutronix.de>
 <20200617101136.GA392445@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617101136.GA392445@fuller.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-17 07:11:36 [-0300], Marcelo Tosatti wrote:
> If your application busy-spins with DPDK (such as FlexRAN does):
> 
> https://www.slideshare.net/LuminaNetworks/osn-bay-area-feb-2019-meetup-intel-5g-flexran-solution-131647692

I see.

> Then v5.8-rc1 does not work, right? (remote pagevec locking + remote
> draining would be necessary).

No, it is what we have in latest rt-devel: A per-CPU spinlock
replacement for preempt_disable() on CONFIG_PREEMPT_RT. We use the
schedule_work_on() as mainline does.

Sebastian
