Return-Path: <SRS0=pVaS=TG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E24DC004C9
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 03:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5609D205F4
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 03:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfEFDXu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 May 2019 23:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFDXu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 May 2019 23:23:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD92383F40;
        Mon,  6 May 2019 03:23:49 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3505C70A;
        Mon,  6 May 2019 03:23:44 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 002BA105169;
        Mon,  6 May 2019 00:22:35 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x463MY6B031434;
        Mon, 6 May 2019 00:22:34 -0300
Date:   Mon, 6 May 2019 00:22:34 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 0/3] do not raise timer softirq unconditionally
 (spinlockless version)
Message-ID: <20190506032234.GA31395@amt.cnet>
References: <20190415201213.600254019@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415201213.600254019@amt.cnet>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 06 May 2019 03:23:49 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 15, 2019 at 05:12:13PM -0300, Marcelo Tosatti wrote:
> For isolated CPUs, we'd like to skip awakening ktimersoftd
> (the switch to and then back from ktimersoftd takes 10us in
> virtualized environments, in addition to other OS overhead,
> which exceeds telco requirements for packet forwarding for
> 5G) from the sched tick.
> 
> The patch "timers: do not raise softirq unconditionally" from Thomas
> attempts to address that by checking, in the sched tick, whether its
> necessary to raise the timer softirq. Unfortunately, it attempts to grab
> the tvec base spinlock which generates the issue described in the patch
> "Revert "timers: do not raise softirq unconditionally"".
> 
> tvec_base->lock protects addition of timers to the wheel versus
> timer interrupt execution.
> 
> This patch does not grab the tvec base spinlock from irq context,
> but rather performs a lockless access to base->pending_map.
> 
> It handles the the race between timer addition and timer interrupt
> execution by unconditionally (in case of isolated CPUs) raising the
> timer softirq after making sure the updated bitmap is visible
> on remote CPUs.
> 
> This patchset reduces cyclictest latency from 25us to 14us
> on my testbox. 
> 
> 

Ping?
