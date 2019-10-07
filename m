Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E0C47404
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0E020867
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJGK4g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:56:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfJGK4f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 06:56:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHQgp-0007Tx-Hc; Mon, 07 Oct 2019 12:56:31 +0200
Date:   Mon, 7 Oct 2019 12:56:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007083037.zu3n5gindvo7damg@beryllium.lan>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-07 10:30:37 [+0200], Daniel Wagner wrote:
> Hi,
Hi Daniel,

> On Fri, Oct 04, 2019 at 06:30:42PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> > > If we have migrate_disable/enable, then, i think preempt_enable/disable
> > > should be replaced by it and not the way how it has been proposed
> > > in the patch.
> > 
> > I don't think this patch is appropriate for upstream.
> 
> Yes, I agree. The discussion made this clear, this is only for -rt
> trees. Initially I though this should be in mainline too.

Sorry, this was _before_ Uladzislau pointed out that you *just* moved
the lock that was there from the beginning. I missed that while looking
over the patch. Based on that I don't think that this patch is not
appropriate for upstream.

> Thanks,
> Daniel

Sebastian
