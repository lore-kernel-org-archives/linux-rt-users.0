Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13DC3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E10422DD3
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfHUO6k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:58:40 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35211 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUO6k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 10:58:40 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EB227200005;
        Wed, 21 Aug 2019 14:58:37 +0000 (UTC)
Date:   Wed, 21 Aug 2019 16:58:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821145837.GD27031@piout.net>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
 <20190821142110.GC27031@piout.net>
 <20190821144230.knlyrnxz62d75hcb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821144230.knlyrnxz62d75hcb@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 21/08/2019 16:42:30+0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-21 16:21:10 [+0200], Alexandre Belloni wrote:
> > I'm not sure it is worth it as the issue is introduced by
> > clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
> > directly?
> 
> you want to get rid of CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK and use
> the highest possible frequency by default? 
> 

No, I meant the issue fixed by clocksource-tclib-add-proper-depend.patch
is introduced by clocksource-tclib-allow-higher-clockrates.patch so I
would think fixing clocksource-tclib-allow-higher-clockrates.patch is
preferable than having a separate patch.

But maybe you meant you wanted a patch to fix
clocksource-tclib-allow-higher-clockrates.patch

Hopefully, one day we will have a solution for that upstream (i.e. being
able to configure the clocksource and clockevent resolutions).

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
