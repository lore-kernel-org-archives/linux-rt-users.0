Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F3FC3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE85206BA
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfHUOmf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:42:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfHUOme (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 10:42:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Rol-00074o-0s; Wed, 21 Aug 2019 16:42:31 +0200
Date:   Wed, 21 Aug 2019 16:42:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821144230.knlyrnxz62d75hcb@linutronix.de>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
 <20190821142110.GC27031@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821142110.GC27031@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-21 16:21:10 [+0200], Alexandre Belloni wrote:
> I'm not sure it is worth it as the issue is introduced by
> clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
> directly?

you want to get rid of CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK and use
the highest possible frequency by default? 

Sebastian
