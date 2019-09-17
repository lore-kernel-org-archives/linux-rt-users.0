Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFBC4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031572171F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfIQOGj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfIQOGj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2631300CB2C;
        Tue, 17 Sep 2019 14:06:38 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46B175D9D5;
        Tue, 17 Sep 2019 14:06:29 +0000 (UTC)
Message-ID: <63b430ca2f067e61bef1c387fad782ab4a2c1ed3.camel@redhat.com>
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
Date:   Tue, 17 Sep 2019 09:06:28 -0500
In-Reply-To: <20190917074456.yj7t3wdwuhn3zcng@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-2-swood@redhat.com>
         <20190917074456.yj7t3wdwuhn3zcng@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 17 Sep 2019 14:06:39 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 09:44 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-11 17:57:25 [+0100], Scott Wood wrote:
> > 
> > @@ -615,10 +645,7 @@ static inline void rcu_read_unlock(void)
> >  static inline void rcu_read_lock_bh(void)
> >  {
> >  	local_bh_disable();
> > -	__acquire(RCU_BH);
> > -	rcu_lock_acquire(&rcu_bh_lock_map);
> > -	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > -			 "rcu_read_lock_bh() used illegally while idle");
> > +	rcu_bh_lock_acquire();
> >  }
> >  
> >  /*
> 
> I asked previously why do you need to change rcu_read_lock_bh() and you
> replied that you don't remember:
>    
> https://lore.kernel.org/linux-rt-users/b948ec6cccda31925ed8dc123bd0f55423fff3d4.camel@redhat.com/
> 
> Did this change?

Sorry, I missed that you were asking about rcu_read_lock_bh() as well.  I
did remove the change to rcu_read_lock_bh_held().

With this patch, local_bh_disable() calls rcu_read_lock() on RT which
handles this debug stuff.  Doing it twice shouldn't be explicitly harmful,
but it's redundant, and debug kernels are slow enough as is.

-Scott


