Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583FC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6627214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 10:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfIQKYk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:24:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfIQKYk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 06:24:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAAez-0001jn-8C; Tue, 17 Sep 2019 12:24:37 +0200
Date:   Tue, 17 Sep 2019 12:24:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h directly
Message-ID: <20190917102436.tn2faq3hcdadybgw@linutronix.de>
References: <20190903191321.6762-1-sultan@kerneltoast.com>
 <alpine.LFD.2.21.1909162356500.10273@planxty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1909162356500.10273@planxty>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-16 23:57:32 [+0200], John Kacur wrote:
> Signed-off-by: John Kacur <jkacur@redhat.com>

Hmmm. I remember this thing came up years ago in the Debian BTS and then
that backfire module got removed from the Debian package because there
was no need for it.
Just to clarify: is there any need to keep this module or do I mix up
things?

Sebastian
