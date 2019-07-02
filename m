Return-Path: <SRS0=UpHf=U7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2871C06510
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE42146F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 08:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfGBIft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:35:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfGBIft (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jul 2019 04:35:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiEGG-0002yj-OP; Tue, 02 Jul 2019 10:35:36 +0200
Date:   Tue, 2 Jul 2019 10:35:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190702083536.vt346ysqmq6q23iz@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
 <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-02 09:04:18 [+0200], Kurt Kanzenbach wrote:
> > In fact, my system doesn't boot with this commit in 5.0-rt.
> >
> > If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> > wakeup occured") the machine boots again.
> >
> > Sebastian, I think that's a bad commit, please revert it.
> 
> I'm having the same problem on a Cyclone V based ARM board. Reverting
> this commit solves the boot issue for me as well.

Okay. So the original Corey fix as in v5.0.14-rt9 works for everyone.
Peter's version as I picked it up for v5.0.21-rt14 is causing problems
for two persons now.

I'm leaning towards reverting it back to old version for now…

> Thanks,
> Kurt

Sebastian
