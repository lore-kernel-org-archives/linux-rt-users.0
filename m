Return-Path: <SRS0=Uj5H=WW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25DBC3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40A020828
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfHZP7q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:59:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfHZP7q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Aug 2019 11:59:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2HPD-0000A2-DH; Mon, 26 Aug 2019 17:59:43 +0200
Date:   Mon, 26 Aug 2019 17:59:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190826155943.zvghokdn3iu2sipx@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
 <20190823161740.xhntflxs3vlf3xnu@linutronix.de>
 <40dd3a7e37ed9b3d03c50221dafc7aa137827ce8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40dd3a7e37ed9b3d03c50221dafc7aa137827ce8.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-23 14:46:39 [-0500], Scott Wood wrote:
> > > Before consolidation, RT mapped rcu_read_lock_bh_held() to
> > > rcu_read_lock_bh() and called rcu_read_lock() from
> > > rcu_read_lock_bh().  This
> > > somehow got lost when rebasing on top of 5.0.
> > 
> > so now rcu_read_lock_bh_held() is untouched and in_softirq() reports 1.
> > So the problem is that we never hold RCU but report 1 like we do?
> 
> Yes.

I understand the part where "rcu_read_lock() becomes part of
local_bh_disable()". But why do you modify rcu_read_lock_bh_held() and
rcu_read_lock_bh()? Couldn't they remain as-is?

> -Scott

Sebastian
