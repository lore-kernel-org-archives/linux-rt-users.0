Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961EC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 08:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D3220700
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 08:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfC1Iqb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:46:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1Iqb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 04:46:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9Qg9-0005rM-FT; Thu, 28 Mar 2019 09:46:29 +0100
Date:   Thu, 28 Mar 2019 09:46:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Ng <andreas2025@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Latency issue to kick off a working queue
Message-ID: <20190328084629.sj3ival4on4vopjz@linutronix.de>
References: <CAAVaN8yNc+sG7UP0J5SLDwVB=YMBUhC=sJZ3Gx72bkfWS5DQYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVaN8yNc+sG7UP0J5SLDwVB=YMBUhC=sJZ3Gx72bkfWS5DQYQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-24 04:12:33 [+0000], Andy Ng wrote:
> Hello there.
Hi,

> I am using 4.9.11 with rt9 on ARM imx6  soc. I am writing a device
> driver and I noticed that my first run of my driver gives big latency
> - in the region on 10msec. When I get a gpio interrupt, I schedule
> some work and the user waiting on a read() takes reply in about
> 10,30msec, on the second run it gets latency down to 140usec. I
> changed the tick from 100Hz to 300Hz and 500Hz, I noticed that my
> starting latency was dropped to 3400usec and 2320usec respectively.
> Which indicate  some delays to kickoff for first time the scheduled
> work related to the granularity of the timer tick.
> Any ideas of what may be wrong?

tracing (scheduler) between interrupt and user task should reveal why it
takes so long. It might first fork of a worker, there might be other
worker busy.
Is this delay only limited to RT or is also on !RT?

> Thanks
> Andy

Sebastian
