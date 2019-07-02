Return-Path: <SRS0=UpHf=U7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A93C06510
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 11:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817221479
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 11:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfGBLxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:53:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGBLxb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jul 2019 07:53:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiHLd-0008Gs-DE; Tue, 02 Jul 2019 13:53:21 +0200
Date:   Tue, 2 Jul 2019 13:53:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <minyard@acm.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190702115321.a7wtdovhz6hn7px2@linutronix.de>
References: <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
 <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
 <20190702083536.vt346ysqmq6q23iz@linutronix.de>
 <20190702114028.GE5041@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190702114028.GE5041@minyard.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-02 06:40:28 [-0500], Corey Minyard wrote:
> On Tue, Jul 02, 2019 at 10:35:36AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-07-02 09:04:18 [+0200], Kurt Kanzenbach wrote:
> > > > In fact, my system doesn't boot with this commit in 5.0-rt.
> > > >
> > > > If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> > > > wakeup occured") the machine boots again.
> > > >
> > > > Sebastian, I think that's a bad commit, please revert it.
> > > 
> > > I'm having the same problem on a Cyclone V based ARM board. Reverting
> > > this commit solves the boot issue for me as well.
> > 
> > Okay. So the original Corey fix as in v5.0.14-rt9 works for everyone.
> > Peter's version as I picked it up for v5.0.21-rt14 is causing problems
> > for two persons now.
> > 
> > I'm leaning towards reverting it back to old version for now…
> 
> Just to avoid confusion... it wasn't my patch 1921ea799b7dc56
> (sched/completion: Fix a lockup in wait_for_completion()) that caused
> the issue, nor was it Peter's version of it.  Instead, it was the patch
> mentioned above, 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> wakeup occured"), which came from someone else.  I can verify by visual
> inspection that that patch is broken and it should definitely be removed.
> Just don't want someone to be confused and remove the wrong patch.

The commit 90e1b18eba2ae4a729 is delta of reverting your patch and
adding Peter's patch instead. If you look into the queue
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/patches/swait-Delete-the-task-from-after-a-wakeup-occured.patch?h=linux-5.0.y-rt-patches&id=8ef6644ae2ac8fc18f157c3deb70fa9acb95a486

is what Peter suggested in the thread and this
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/patches/sched-completion-Fix-a-lockup-in-wait_for_completion.patch?h=linux-5.0.y-rt-patches&id=8ef6644ae2ac8fc18f157c3deb70fa9acb95a486

is the removal.

> -corey
Sebastian
