Return-Path: <SRS0=aYAi=XS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C5C4CEC4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 16:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D6120820
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfIWQZJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:25:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfIWQZI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Sep 2019 12:25:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCR96-0001Bb-0f; Mon, 23 Sep 2019 18:25:04 +0200
Date:   Mon, 23 Sep 2019 18:25:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 5/5] rcutorture: Avoid problematic critical section
 nesting on RT
Message-ID: <20190923162503.unezmzawx5vylkbh@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-6-swood@redhat.com>
 <20190912221706.GC150506@google.com>
 <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
 <20190917100728.wnhdvmbbzzxolef4@linutronix.de>
 <26dbecfee2c02456ddfda3647df1bcd56d9cc520.camel@redhat.com>
 <20190917145035.l6egzthsdzp7aipe@linutronix.de>
 <b6b87f7acde58fcf0c172622eb9acef43a113ec4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6b87f7acde58fcf0c172622eb9acef43a113ec4.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-17 11:32:11 [-0500], Scott Wood wrote:
> Nice!  Are the "false positives" real issues from components that are
> currently blacklisted on RT, or something different?

So first a little bit of infrastructure like commit d5096aa65acd0
("sched: Mark hrtimers to expire in hard interrupt context") is required
so lockdep can see it all properly without RT enabled. Then we need
patches to avoid lockdep complaining about things that are not complained
about in RT because the lock is converted to raw_spinlock_t or something
different is applied so we don't have the warning.

> -Scott

Sebastian
