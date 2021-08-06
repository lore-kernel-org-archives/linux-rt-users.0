Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3FC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66F960F44
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbhHFSeu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhHFSet (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 14:34:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB9060ED6;
        Fri,  6 Aug 2021 18:34:32 +0000 (UTC)
Date:   Fri, 6 Aug 2021 14:34:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     "Qin\, Chao" <chao.qin@intel.com>, Joe Perches <joe@perches.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy\@linutronix.de" <bigeasy@linutronix.de>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mgross\@linux.intel.com" <mgross@linux.intel.com>,
        "Mei\, Paul" <paul.mei@intel.com>, "Li\, Lili" <lili.li@intel.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Message-ID: <20210806143431.1ac3b4a5@oasis.local.home>
In-Reply-To: <20210805121200.59db2104@oasis.local.home>
References: <20210719022649.3444072-1-chao.qin@intel.com>
        <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
        <87o8axm6ae.fsf@jogness.linutronix.de>
        <DM6PR11MB380275B5125531E8EB9D019B92F29@DM6PR11MB3802.namprd11.prod.outlook.com>
        <87eeb8w08q.fsf@jogness.linutronix.de>
        <20210805121200.59db2104@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 5 Aug 2021 12:12:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll add it to my queue for tomorrow.

I'm currently testing 5.10.56-rt48 which only brings the 5.10 rt branch
up to latest stable. After that is done and pushed out, I'll backport
this patch and do a 5.10.56-rt49-rc release.

Letting you know in case you see the 5.10.56-rt48 and wonder where your
patch is.

-- Steve
