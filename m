Return-Path: <SRS0=83CY=76=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CBC433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FCC208D5
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQHqU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQHqT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jun 2020 03:46:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2505C061573
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2020 00:46:19 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlSm1-0003tp-Iu; Wed, 17 Jun 2020 09:46:17 +0200
Date:   Wed, 17 Jun 2020 09:46:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200617074617.p4m5l5uu5urmagsc@linutronix.de>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
 <20200616170425.GA324900@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616170425.GA324900@fuller.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-16 14:04:25 [-0300], Marcelo Tosatti wrote:
> It is affected. The workqueue thread for a given CPU is SCHED_OTHER, which can't
> interrupt a SCHED_FIFO task which does not sleep.

Okay. So it is a problem which exists independently of -RT.
As I pointed out to Juri, vmstat_update() should have the very same
problem, correct?

Sebastian
