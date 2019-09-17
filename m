Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E0FC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433C21852
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfIQQM6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30167 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfIQQM6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 12:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9374302C08E;
        Tue, 17 Sep 2019 16:12:57 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1811262660;
        Tue, 17 Sep 2019 16:12:49 +0000 (UTC)
Message-ID: <ad29574b34aca9ab61d310508f4f21a35cac406e.camel@redhat.com>
Subject: Re: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 17 Sep 2019 11:12:48 -0500
In-Reply-To: <20190917144252.v34ina4z2ydchoit@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-2-swood@redhat.com>
         <20190917074456.yj7t3wdwuhn3zcng@linutronix.de>
         <63b430ca2f067e61bef1c387fad782ab4a2c1ed3.camel@redhat.com>
         <20190917144252.v34ina4z2ydchoit@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 17 Sep 2019 16:12:58 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 16:42 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-17 09:06:28 [-0500], Scott Wood wrote:
> > Sorry, I missed that you were asking about rcu_read_lock_bh() as
> > well.  I
> > did remove the change to rcu_read_lock_bh_held().
> 
> Sorry for not being clear here.
> 
> > With this patch, local_bh_disable() calls rcu_read_lock() on RT which
> > handles this debug stuff.  Doing it twice shouldn't be explicitly
> > harmful,
> > but it's redundant, and debug kernels are slow enough as is.
> 
> rcu_read_lock() does:
> >         __rcu_read_lock();
> >         __acquire(RCU);
> >         rcu_lock_acquire(&rcu_lock_map);
> >         RCU_LOCKDEP_WARN(!rcu_is_watching(),
> >                          "rcu_read_lock() used illegally while idle");
> 
> __acquire() is removed removed by cpp.
> That RCU_LOCKDEP_WARN is doing the same thing as above and redundant.
> Am I right to assume that you consider
> 	rcu_lock_acquire(&rcu_bh_lock_map);
> 
> redundant because the only user of that is also checking for
> rcu_lock_map?

Yes.

-Scott


