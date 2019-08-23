Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D2FC3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 01:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F123404
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 01:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iXWjbHRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfHWBuM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:50:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388047AbfHWBuM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 21:50:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so4786753pga.5
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Aug 2019 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nVpIaULoP5xHhVhqVwCnL2/nr72RjF/GeMw6NFKePik=;
        b=iXWjbHRav/jxO8IDVueGiQsPLqyZ2UBzkvdzUstOgkEklotIMp8PhS8shzzN9Zuwkb
         J/oC2mR2wQoaRxCqzPMdMqWdrZL7QQhbmcpkgNsVVqZcEuBx3ri3ZZ4GQfYVXpZq+Qha
         OhoJWf9g/svDxyaIdNDLhULNDPAdA+aoctMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVpIaULoP5xHhVhqVwCnL2/nr72RjF/GeMw6NFKePik=;
        b=l2NkPuG4bg+/eQhuPxZiJarP2+nEmTbKAn3lg3H7Nrsuu0pEbzU0O3V66Du5mBh4NO
         5P/gV4JegsJ0oVL8Sm5mVS6lLijUxuO9YGSCP+5eMbRclQeJGe3p7BGrUEr0ZN5M4TQ2
         ICU8g31bQH8XX7yfrDunXvWsXr+//m2h+p/Kh1kPXAHYEqXjc2zVFbWGvzv/D31+7nnZ
         eA7rhUqrX6X9/4T1kq5rLgSkHEBomYTLH0DjvXckDW6ePtxLinz6XGYfdP27ca17w3ec
         eDi8uaP1/117vVKTgLjwL7uSsHFwMHtDBjrNIkLq+hGF3fIf6eCKnb5sMEEiQ6Lu+lgt
         O+cw==
X-Gm-Message-State: APjAAAUzc4XVKDhl8R/1WXhRNQ1+pITQjBz3uVagGiyls/TF6am3NYQm
        4ij959sh0Ca7YpIG7lwUBsCLlg==
X-Google-Smtp-Source: APXvYqyxkGDu+sSVhIUbPpsJ6PM9e2ZRLfP6B6V0M/cpGZQgPLq13M4w+mRe0UsSMquMVVCLJAOdpg==
X-Received: by 2002:aa7:8f29:: with SMTP id y9mr2491838pfr.27.1566525011711;
        Thu, 22 Aug 2019 18:50:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm688640pfc.70.2019.08.22.18.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 18:50:10 -0700 (PDT)
Date:   Thu, 22 Aug 2019 21:50:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823015009.GA152050@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <20190822152706.GB28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822152706.GB28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 08:27:06AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 22, 2019 at 09:39:55AM -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > > A plain local_bh_disable() is documented as creating an RCU critical
> > > > section, and (at least) rcutorture expects this to be the case.  However,
> > > > in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> > > > preempt_count() directly.  Even if RCU were changed to check
> > > > in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> > > > 
> > > > Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> > > > rcu_read_lock_bh_held() accordingly.
> > > 
> > > Cool!  Some questions and comments below.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > ---
> > > > Another question is whether non-raw spinlocks are intended to create an
> > > > RCU read-side critical section due to implicit preempt disable.
> > > 
> > > Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> > > and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> > > consolidation?  If not, I don't see why they should do so after that
> > > consolidation in -rt.
> > 
> > May be I am missing something, but I didn't see the connection between
> > consolidation and this patch. AFAICS, this patch is so that
> > rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?
> 
> I was interpreting Scott's question (which would be excluded from the
> git commit log) as relating to a possible follow-on patch.
> 
> The question is "how special can non-raw spinlocks be in -rt?".  From what
> I can see, they have been treated as sleeplocks from an RCU viewpoint,
> so maybe that should continue to be the case.  It does deserve some
> thought because in mainline a non-raw spinlock really would block a
> post-consolidation RCU grace period, even in PREEMPT kernels.
> 
> But then again, you cannot preempt a non-raw spinlock in mainline but
> you can in -rt, so extending that exception to RCU is not unreasonable.
> 
> Either way, we do need to make a definite decision and document it.
> If I were forced to make a decision right now, I would follow the old
> behavior, so that only raw spinlocks were guaranteed to block RCU grace
> periods.  But I am not being forced, so let's actually discuss and make
> a conscious decision.  ;-)

I think non-raw spinlocks on -rt should at least do rcu_read_lock() so that
any driver or kernel code that depends on this behavior and works on non-rt
also works on -rt. It also removes the chance a kernel developer may miss
documentation and accidentally forget that their code may break on -rt. I am
curious to see how much this design pattern appears in the kernel
(spin_lock'ed section "intended" as an RCU-reader by code sequences).

Logically speaking, to me anything that disables preemption on non-RT should
do rcu_read_lock() on -rt so that from RCU's perspective, things are working.
But I wonder where we would draw the line and if the bar is to need actual
examples of usage patterns to make a decision..

Any thoughts?

thanks,

 - Joel

