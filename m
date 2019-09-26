Return-Path: <SRS0=fYRI=XV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EBECE589
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B56421655
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Sep 2019 16:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfIZQjt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:39:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfIZQjt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Sep 2019 12:39:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDWns-0003L8-Mh; Thu, 26 Sep 2019 18:39:40 +0200
Date:   Thu, 26 Sep 2019 18:39:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 4/8] sched: migrate disable: Protect cpus_ptr with lock
Message-ID: <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-5-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-5-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-27 00:56:34 [-0500], Scott Wood wrote:
> Various places assume that cpus_ptr is protected by rq/pi locks,
> so don't change it before grabbing those locks.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

I applied now everything until here and you can take a look at
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-5.2.y-rt-RC

If there are no objections then I would make this a -rt9 and then go
further.

Sebastian
