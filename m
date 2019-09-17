Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C224C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1788206C2
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404523AbfIQHwN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:52:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfIQHwM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 03:52:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iA8HR-0005om-LX; Tue, 17 Sep 2019 09:52:09 +0200
Date:   Tue, 17 Sep 2019 09:52:09 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 2/5] sched: Rename sleeping_lock to rt_invol_sleep
Message-ID: <20190917075209.2utxzkleydg27fnm@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-3-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-3-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-11 17:57:26 [+0100], Scott Wood wrote:
> It's already used for one situation other than acquiring a lock, and the
> next patch will add another, so change the name to avoid confusion.

I know it has been suggested but please don't rename it, keep it as is.
The _only_ reason why you are having it is to avoid a RCU related
warning.
PeterZ asked if we could maybe utilize a task-state bit for this
annotation instead. So I will look into this and change the mechanism
that is used to something different if it is preferred over this one and
you don't have to worry about it. Please use what is here at the moment.

> Signed-off-by: Scott Wood <swood@redhat.com>

Sebastian
