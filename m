Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D7C4363A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972AF2224E
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 18:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789893AbgJZSe2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:34:28 -0400
Received: from mail.monom.org ([188.138.9.77]:51252 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789818AbgJZSe2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Oct 2020 14:34:28 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BC18450058D;
        Mon, 26 Oct 2020 19:34:25 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 85C2550032F;
        Mon, 26 Oct 2020 19:34:25 +0100 (CET)
Date:   Mon, 26 Oct 2020 19:34:25 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 01/18] rt-util: Move parse_cpumask from cyclictest
Message-ID: <20201026183425.wxdl3vaoutsrk3bw@beryllium.lan>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-2-dwagner@suse.de>
 <9afc7214-c957-e86-1ee9-6ed2435b6fa8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9afc7214-c957-e86-1ee9-6ed2435b6fa8@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Fri, Oct 23, 2020 at 11:46:54AM -0400, John Kacur wrote:
> >  TARGETS = $(sources:.c=)
> >  LIBS	= -lrt -lpthread
> > -RTTESTLIB = -lrttest -L$(OBJDIR)
> > +RTTESTLIB = -lrttest -L$(OBJDIR) $(NUMA_LIBS)
> 
> Currently only cyclictest was compiled with NUMA_LIBS, this change will 
> compile everything with NUMA_LIBS. I checked the size of the programs, and 
> they don't grow that much with this change, but they are small programs to
> begin with, do we want to keep this functionality separate?

My thinking is, that the most important program for testing seems to be
cyclictest. Everyone will run cyclictest on the target platform. Thus
libnuma will be available. So there wont be any new unresolved
dependencies.

I traded the size increase for simplification in the code base and build
setup. Looking at the actual increase (x86_64, stripped) is not too bad:


program                 old      new     diff
---------------------------------------------------
cyclicdeadline          35488    35552     64 0.18%
cyclictest              57632    57632      0 0.0%
deadline_test           43712    43776     64 0.15%
hackbench               19168    19168      0 0.0%
oslat                   36040    36072     32 0.089%
pip_stress              27296    27360     64 0.23%
pi_stress               44296    48456   4160 9.4%
pmqtest                 31864    31928     64 0.2%
ptsematest              31752    31816     64 0.2%
queuelat                14600    14600      0 0.0%
rt-migrate-test         31696    31728     32 0.1%
signaltest              31712    31776     64 0.2%
sigwaittest             31792    31856     64 0.2%
ssdd                    14744    14744      0 0.0%
svsematest              31856    31920     64 0.2%


pi_stress is a bit odd though. Not sure what's happening there. Will
look into it.

So I would prefer to go this route and makes things simpler in the code
base.

Thanks,
Daniel
