Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21007C48BD4
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4120644
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFYNwV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:52:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFYNwV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 09:52:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hflrv-0000LP-Bd; Tue, 25 Jun 2019 15:52:19 +0200
Date:   Tue, 25 Jun 2019 15:52:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/6] rt-tests: deadline: Remove duplicated gettid() code
Message-ID: <20190625135219.ukabjwbftoyq7jmp@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
 <20190618103841.27249-4-kurt@linutronix.de>
 <alpine.LFD.2.21.1906191747000.12022@planxty>
 <20190624134045.6rrfa4wq6in6zgxl@linutronix.de>
 <alpine.LFD.2.21.1906251117160.4274@planxty.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906251117160.4274@planxty.home>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-25 11:29:28 [+0200], John Kacur wrote:
> 
> 
> On Mon, 24 Jun 2019, Sebastian Andrzej Siewior wrote:
> 
> > On 2019-06-19 17:48:09 [+0200], John Kacur wrote:
> > > 
> > > If anyone objects because they are actively using systems that don't have 
> > > gettid() in the library, please speak-up, for now this is in 
> > > unstable/devel/latest-devel
> > 
> > ehm. gettid() is defined in
> > 	src/lib/rt-utils.c
> > 
> > so how should someone not have that one on his system?
> 
> The sentence does say, systems that don't have gettid() in the LIBRARY.
> 
> That being said, Kurt, would like to come up with a smarter patch that 
> uses the glibc version if detected else falls back on this one?
> 
> Then you need to clean it up everywhere, not just for the deadline tests.
> 
> Consider this patch NAKed for now. (it's only in the latest-devel not the 
> latest version anyway)

=>
- The #define macro for gettid is used in rt-tests since day one. This
  includes cyclictest.c among other files.

- In commit 7efada9d5be26 ("rt-utils: Add gettid()") (which is 0.9)
  tall Daniel introduced a fucntion which can be used instead of the
  define. Based in the grep in my current checkout I don't see any users
  except for pi_stress

- Kurt tried to use the function from rt-tests instead of the define.

Based on what I see you can today use it everywhere. It is not that
simple to use it from glibc because you don't have a compile check to
check for that libc function.

Sebastian
