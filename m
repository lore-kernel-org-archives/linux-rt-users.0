Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA08C43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF02137B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgIHWWz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:22:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59368 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgIHWWz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 18:22:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 61D401C0B7F; Wed,  9 Sep 2020 00:22:53 +0200 (CEST)
Date:   Wed, 9 Sep 2020 00:22:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200908222252.GC1005@bug>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi!

> This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].
> 
> SCHED_DEADLINE servers can help fixing starvation issues of low priority tasks (e.g., 
> SCHED_OTHER) when higher priority tasks monopolize CPU cycles. Today we have RT 
> Throttling; DEADLINE servers should be able to replace and improve that.

It would be worth noting what "server" is in this context.

It is not white box with CPU inside, it is not even an userland process, afaict.

Subject is quite confusing.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
