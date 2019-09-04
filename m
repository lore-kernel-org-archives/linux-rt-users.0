Return-Path: <SRS0=qyXN=W7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E431C3A5A7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BF2339D
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Sep 2019 13:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WBZbEbSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfIDNmG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:42:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44496 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfIDNmF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Sep 2019 09:42:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so11270782pgl.11
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Sep 2019 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oklghVAYMBOMwnSSWwCYcajaz+bMy8hr9iKM1Yg7aak=;
        b=WBZbEbSlW3hA4LPKkYyJzd58HTqckuyI9ruChkezZC6jGsyEyWalm/XID+in4XwAcX
         ushgsDXIys/3Uyob2lacjzvMhD6NTYshvx5ow8YlhokuvapX6Z8eLwn5GE56kIpHJBwM
         zlAbyidngWUPtIg1wV2lD3MndKSRQhmq4kLro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oklghVAYMBOMwnSSWwCYcajaz+bMy8hr9iKM1Yg7aak=;
        b=SEMx9gqAhDpwGmFZCEU6hGMJ+lWOlGCudCCkVVHt4nbAy44IPzr4IfHv4ML+r77ZTY
         i0edIUyjjcPlbtN/Jul/Or/jyKkSECeE53WZj3KwjjOIH1zO2h1nh3hRylXNC+CNhPPy
         3gT7bnOo3WJH4PnPfYNtbk/2nLkyqBg5NQtqXcMHsxW6nTCiTylYgft9DEbaa+HO3xbb
         nHO1JDgFv63nY3w4X2pxsFd/IC2rfu9+gtukwHmZUSJ9u7juAMqXTWSd2ccZHqY3rCl+
         OzJa6pFppTLi/M/mraTemNa7ghqMEfBZICbosGuN4jOmMEIn9z8X5t1rBRtt/dVxmAmc
         pTgg==
X-Gm-Message-State: APjAAAUqn6UfUGskil95PIP86ssJdQIWFD3WjIf0HX6T0AzQpORQGZbH
        /aRS/WczcJS5nG2M8D3BL1lZng==
X-Google-Smtp-Source: APXvYqxtMLqjgzNXqwP58ru84p45VRpR0RWa4wbrgf8WB/8ClopE5Mr9NERja4e4k0aI89Ih5g/0wQ==
X-Received: by 2002:a62:4d41:: with SMTP id a62mr46382478pfb.155.1567604524993;
        Wed, 04 Sep 2019 06:42:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c2sm11187176pfd.66.2019.09.04.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:42:04 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:42:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>, paulmck@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904134203.GA240514@google.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
 <20190904040039.GB150430@google.com>
 <20190904081919.GA2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904081919.GA2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 04, 2019 at 10:19:19AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 12:00:39AM -0400, Joel Fernandes wrote:
> > [ Resending since I messed up my last email's headers! ]
> > 
> > On Tue, Sep 03, 2019 at 03:25:59PM +0200, Viktor Rosendahl wrote:
> > > This patch implements the feature that the tracing_max_latency file,
> > > e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> > > notifications through the fsnotify framework when a new latency is
> > > available.
> > > 
> > > One particularly interesting use of this facility is when enabling
> > > threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> > > together with the preempt/irqsoff tracers. This makes it possible to
> > > implement a user space program that can, with equal probability,
> > > obtain traces of latencies that occur immediately after each other in
> > > spite of the fact that the preempt/irqsoff tracers operate in overwrite
> > > mode.
> > 
> > Adding Paul since RCU faces similar situations, i.e. raising softirq risks
> > scheduler deadlock in rcu_read_unlock_special() -- but RCU's solution is to
> > avoid raising the softirq and instead use irq_work.
> 
> Which is right.

Cool.

> > I was wondering, if we can rename __raise_softirq_irqoff() to
> > raise_softirq_irqoff_no_wake() and call that from places where there is risk
> > of scheduler related deadlocks. Then I think this can be used from Viktor's
> > code.  Let us discuss - what would happen if the softirq is raised, but
> > ksoftirqd is not awakened for this latency notification path? Is this really
> > an issue considering the softirq will execute during the next interrupt exit?
> 
> You'd get unbounded latency for processing the softirq and warnings on
> going idle with softirqs pending.

Thanks for sharing that.

> I really don't see why we should/want to be using softirq here.

Sure. makes sense.

thanks,

 - Joel

