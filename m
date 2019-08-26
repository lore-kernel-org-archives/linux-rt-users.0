Return-Path: <SRS0=Uj5H=WW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA3EC3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB023206B7
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 23:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfHZXVs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:21:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXVs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Aug 2019 19:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D047230655F9;
        Mon, 26 Aug 2019 23:21:47 +0000 (UTC)
Received: from ovpn-116-73.phx2.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6F69608AB;
        Mon, 26 Aug 2019 23:21:46 +0000 (UTC)
Message-ID: <b948ec6cccda31925ed8dc123bd0f55423fff3d4.camel@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Mon, 26 Aug 2019 18:21:46 -0500
In-Reply-To: <20190826155943.zvghokdn3iu2sipx@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-2-swood@redhat.com>
         <20190821233358.GU28441@linux.ibm.com> <20190822133955.GA29841@google.com>
         <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
         <20190823161740.xhntflxs3vlf3xnu@linutronix.de>
         <40dd3a7e37ed9b3d03c50221dafc7aa137827ce8.camel@redhat.com>
         <20190826155943.zvghokdn3iu2sipx@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 26 Aug 2019 23:21:47 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-08-26 at 17:59 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-23 14:46:39 [-0500], Scott Wood wrote:
> > > > Before consolidation, RT mapped rcu_read_lock_bh_held() to
> > > > rcu_read_lock_bh() and called rcu_read_lock() from
> > > > rcu_read_lock_bh().  This
> > > > somehow got lost when rebasing on top of 5.0.
> > > 
> > > so now rcu_read_lock_bh_held() is untouched and in_softirq() reports
> > > 1.
> > > So the problem is that we never hold RCU but report 1 like we do?
> > 
> > Yes.
> 
> I understand the part where "rcu_read_lock() becomes part of
> local_bh_disable()". But why do you modify rcu_read_lock_bh_held() and
> rcu_read_lock_bh()? Couldn't they remain as-is?

Yes, it looks like they can.  I recall having problems with
rcu_read_lock_bh_held() in an earlier version which is what prompted the
change, but looking back I don't see what the problem was.

-Scott


