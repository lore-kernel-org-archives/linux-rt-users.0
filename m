Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DDFC43613
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156FB208E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfFXNku (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:40:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbfFXNkr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 09:40:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hfPDB-0002zY-F4; Mon, 24 Jun 2019 15:40:45 +0200
Date:   Mon, 24 Jun 2019 15:40:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/6] rt-tests: deadline: Remove duplicated gettid() code
Message-ID: <20190624134045.6rrfa4wq6in6zgxl@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
 <20190618103841.27249-4-kurt@linutronix.de>
 <alpine.LFD.2.21.1906191747000.12022@planxty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906191747000.12022@planxty>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-19 17:48:09 [+0200], John Kacur wrote:
> 
> If anyone objects because they are actively using systems that don't have 
> gettid() in the library, please speak-up, for now this is in 
> unstable/devel/latest-devel

ehm. gettid() is defined in
	src/lib/rt-utils.c

so how should someone not have that one on his system?

glibc 2.30 will have gettid() [0] so maybe you could avoid using that
one from rt-utils.c once you detect it in glibc.

[0] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92;hp=f289e656ec8221756519a601042bc9fbe1b310fb

>  Signed-off-by: John Kacur <jkacur@redhat.com>

Sebastian
