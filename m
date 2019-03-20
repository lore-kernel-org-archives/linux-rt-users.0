Return-Path: <SRS0=B6j+=RX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C06C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Mar 2019 11:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1072184E
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Mar 2019 11:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCTLvd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:51:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLvd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 Mar 2019 07:51:33 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6Zkn-0002On-L1; Wed, 20 Mar 2019 12:51:29 +0100
Date:   Wed, 20 Mar 2019 12:51:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
Subject: Re: [RFC PATCH RT] x86/tsc: Add option to disable tsc clocksource
 watchdog
Message-ID: <20190320115129.neop27rzcepj5wvs@linutronix.de>
References: <20190307120913.13168-1-juri.lelli@redhat.com>
 <20190314070951.GC31405@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314070951.GC31405@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-14 08:09:51 [+0100], Juri Lelli wrote:
> Hi,
> 
> On 07/03/19 13:09, Juri Lelli wrote:
> > Clocksource watchdog has been found responsible for generating latency
> > spikes (in the 10-20 us range) when woken up to check for TSC stability.
> > 
> > Add an option to disable it at boot.
> 
> Gentle ping.
> 
> Does this make any sense?

I have to reroute this ping to tglx since I wasn't involved.

> Thanks,
> 
> - Juri

Sebastian
