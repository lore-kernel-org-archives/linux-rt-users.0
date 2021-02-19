Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E757CC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625064EB7
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhBSONY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 09:13:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhBSONS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 09:13:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75426B125;
        Fri, 19 Feb 2021 14:12:37 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:12:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Message-ID: <20210219141237.kksuqsgmmmis7iht@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20201218161843.1764-2-dwagner@suse.de>
 <878s7k41ff.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s7k41ff.fsf@kurt>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Kurt,

On Fri, Feb 19, 2021 at 02:44:36PM +0100, Kurt Kanzenbach wrote:
> It seems like with this particular commit, it's not possible to run
> cyclictest on arm32 systems anymore. I guess due to missing NUMA
> support?

Yes, your distro needs to provide libnuma. cyclictest runs fine on arm32
with the library.

> Just tested on a dual core Cyclone V:
> 
> root@tsn:~/rt-tests# ./cyclictest -S -m -p 99 --secaligned
> FATAL: Couldn't initialize libnuma

I think you would see the same error when trying to use the '-a' option
without the patch. The dependency is not new.

> I've used the current unstable/devel/latest branch. Any suggestions?

The simplest thing is obviously to get libnuma on your system. I assume
this is not so simple in your case. In this case you could build
cyclictest a static binary.

First, build numactl as static libary:

  ./configure --enable-static && make

and then rt-tests with

  CFLAGS="-static -L../numactl/.libs/" make

Thanks,
Daniel
