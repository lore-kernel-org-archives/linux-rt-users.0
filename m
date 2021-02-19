Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B777C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ABC64E54
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSOzH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 09:55:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBSOzE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 09:55:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EE02AC6E;
        Fri, 19 Feb 2021 14:54:22 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:54:22 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Message-ID: <20210219145422.lvodigbgtymr5ajc@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20201218161843.1764-2-dwagner@suse.de>
 <878s7k41ff.fsf@kurt>
 <20210219141237.kksuqsgmmmis7iht@beryllium.lan>
 <875z2o3yvi.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z2o3yvi.fsf@kurt>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 03:39:45PM +0100, Kurt Kanzenbach wrote:
> I'm using Debian and it provides libnuma.

Hmm, that is strange. Indeed. I have to update my BBB first to a more
recent Debian release to try this out.

> Static building with the newest numactl library also doesn't work:
> 
> |root@tsn:~/rt-tests# file cyclictest 
> |cyclictest: ELF 32-bit LSB executable, ARM, EABI5 version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=248eaf8847544423dc51c6ceea18bbffc487991e, with debug_info, not stripped
> |root@tsn:~/rt-tests# ./cyclictest 
> |FATAL: Couldn't initialize libnuma

I try to reproduce this here. Building libnuma from source right now.
