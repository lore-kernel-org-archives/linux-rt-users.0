Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F553C0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E30218A0
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfGCLY7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:24:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLY7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 07:24:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hidNh-0003QO-U0; Wed, 03 Jul 2019 13:24:58 +0200
Date:   Wed, 3 Jul 2019 13:24:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: is magic-sysrq handling threaded in linux-RT?
Message-ID: <20190703112457.qxq2xtqcg564gms3@linutronix.de>
References: <a9dfc474-3691-64bc-7b81-7e4e6d4acb71@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9dfc474-3691-64bc-7b81-7e4e6d4acb71@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-02 10:04:49 [-0600], Chris Friesen wrote:
> I'd like to clarify something though...is the serial console interrupt
> threaded?  If it is, then something that prevents the scheduler from running
> could result in magic-sysrq not functioning, but if it isn't then I think
> that would point to an interrupt problem.

The interrupt is threaded, the magic-sysrq happens threaded then. Any
printk in non-preemptible region will be delayed until preemptible
region is reached (or delayed until the next print from preeptible
region).

> Thanks,
> Chris

Sebastian
