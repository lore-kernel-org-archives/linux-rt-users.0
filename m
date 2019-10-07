Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE798ECE58C
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED352067B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfJGQeq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfJGQeq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 12:34:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BB49AC8B;
        Mon,  7 Oct 2019 16:34:44 +0000 (UTC)
Date:   Mon, 7 Oct 2019 18:34:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007163443.6owts5jp2frum7cy@beryllium.lan>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007162330.GA26503@pc636>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 07, 2019 at 06:23:30PM +0200, Uladzislau Rezki wrote:
> Hello, Daniel, Sebastian.
> 
> > > On Fri, Oct 04, 2019 at 06:30:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> > > > > If we have migrate_disable/enable, then, i think preempt_enable/disable
> > > > > should be replaced by it and not the way how it has been proposed
> > > > > in the patch.
> > > > 
> > > > I don't think this patch is appropriate for upstream.
> > > 
> > > Yes, I agree. The discussion made this clear, this is only for -rt
> > > trees. Initially I though this should be in mainline too.
> > 
> > Sorry, this was _before_ Uladzislau pointed out that you *just* moved
> > the lock that was there from the beginning. I missed that while looking
> > over the patch. Based on that I don't think that this patch is not
> > appropriate for upstream.
> > 
> Yes that is a bit messy :) Then i do not see what that patch fixes in
> mainline? Instead it will just add an extra blocking, i did not want that
> therefore used preempt_enable/disable. But, when i saw this patch i got it
> as a preparation of PREEMPT_RT merging work.

Maybe I should add some background info here as well. Currently, I am
creating an -rt tree on v5.3 for which I need this patch (or a
migrate_disable() version of it). So this is slightly independent of
the work Sebiastian is doing. Though the mainline effort of PREEMPT_RT
will hit this problem as well.

I understood Sebiastian wrong above. I thought he suggest to use the
migrate_disable() approach even for mainline. 

I supppose, one thing which would help in this discussion, is what do
you gain by using preempt_disable() instead of moving the lock up?
Do you have performance numbers which could justify the code?
