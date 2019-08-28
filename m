Return-Path: <SRS0=q9Sf=WY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05F3C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BEC2064A
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 13:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AbjIeNTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfH1N7m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:59:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46034 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1N7m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Aug 2019 09:59:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so15198plr.12
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Aug 2019 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdGG/Tv13HB/jDILsDDPH2sexv8IMLLCw/Cf3bLI1Rc=;
        b=AbjIeNTJdvT8UsPdHGTT12NNasMgExZWYbimmHn3akOFWqZo5wgbHDHcXXpGroWQB2
         uptGhkTezCH1ZayGgMAm+32q4TEMahdbAhHBxApgA/EJzqTfT3X+1/EzxAgoJCK2QhBr
         VWfMYhFTKIVBBwHtx7miec3zKod/pMhBqXPMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdGG/Tv13HB/jDILsDDPH2sexv8IMLLCw/Cf3bLI1Rc=;
        b=iRpLEWsnnghPJ3bgnN1+Y9wExZ6z8P0gg8lyPbAGRSak+nIOEJppjgWk+g5hf4xMpj
         N84yKVZrwQHJxgXKgb/7Mbt0/UQJoEjc1dlwTKJCk6hGmJRTlMX4DUgUY22925Y6V3hz
         eCI2t6VTPLSin/kVaJkvYQIiZKYpxm7WtB+GdZDmeY0moOAMDcvvzSRqNxvnIMplJ9FH
         h54vE9aeKCpOS+aWna9B2jKV5GbMTnPP8LkCD1hE75OKHrPtK4XLLUjA454qmefCH98O
         WwWoITnAGGc0BX/6+FkMbHTb7MuJVvHrWNUAYPonsgkm6Xi9WoIDhnXoYTUs9go1zeCR
         iFhg==
X-Gm-Message-State: APjAAAVWtewRCEScoIG84P5iOpG0K65V4zHEufWmUhqzOaIHx1btCx1u
        x6SbkCIv6ka4d/IhGhQN5HA9UA==
X-Google-Smtp-Source: APXvYqxMGITygSr180EJejsfC85vm5SPnD+i55kT87OMAn0hfj6rNlsyiPkEr7ix1LkXIo8NzDBvkQ==
X-Received: by 2002:a17:902:e9:: with SMTP id a96mr4579817pla.169.1567000781303;
        Wed, 28 Aug 2019 06:59:41 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p5sm2805452pfg.184.2019.08.28.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:59:40 -0700 (PDT)
Date:   Wed, 28 Aug 2019 09:59:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190828135938.GA230957@google.com>
References: <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
 <20190828092739.46mrffvzjv6v3de5@linutronix.de>
 <20190828125426.GO26530@linux.ibm.com>
 <20190828131433.3gi4debho5zc7hgc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828131433.3gi4debho5zc7hgc@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 28, 2019 at 03:14:33PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-28 05:54:26 [-0700], Paul E. McKenney wrote:
> > On Wed, Aug 28, 2019 at 11:27:39AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > > Am I understanding this correctly?
> > > 
> > > Everything perfect except that it is not lockdep complaining but the
> > > WARN_ON_ONCE() in rcu_note_context_switch().
> > 
> > This one, right?
> > 
> > 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
> > 
> > Another approach would be to change that WARN_ON_ONCE().  This fix might
> > be too extreme, as it would suppress other issues:
> > 
> > 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);
> > 
> > But maybe what is happening under the covers is that preempt is being
> > set when sleeping on a spinlock.  Is that the case?
> 
> I would like to keep that check and that is why we have:
> 
> |   #if defined(CONFIG_PREEMPT_RT_FULL)
> |         sleeping_l = t->sleeping_lock;
> |   #endif
> |         WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
> 
> in -RT and ->sleeping_lock is that counter that is incremented in
> spin_lock(). And the only reason why sleeping_lock_inc() was used in the
> patch was to disable _this_ warning.

Makes sense, Sebastian.

Paul, you meant "!" in front of the IS_ENABLED right in your code snippet right?

The other issue with:
WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);

.. could be that, the warning will be disabled for -rt entirely, not just for
sleeping locks. And we probably do want to keep this warning for the cases in
-rt where we are blocking but it is not a sleeping lock. Right?

thanks,

 - Joel


