Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB592C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 00:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7504C2173E
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 00:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hYL+u0eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfHWAwW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:52:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43259 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbfHWAwV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 20:52:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so5165135pfn.10
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Aug 2019 17:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzy36hhVXFi6wqDa1Z1jG9B3/csgmeqFSkjTTR5TT8o=;
        b=hYL+u0eQoTbpWIVtYnginblV5imhgI8XxMCyi9l7/HBpQMrxDA/vdrxCnNultRSBkY
         P5JMBNUxfa2VHB72aDX+cgK5x5Pg+SVWjdRnWHlGNng1tFEMrua/lr9A/QngXcR9+PIr
         z8i7RNwUNfD9CTp7+geP9YlxQpiKIiEyRI9jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzy36hhVXFi6wqDa1Z1jG9B3/csgmeqFSkjTTR5TT8o=;
        b=tadknQp7LZdZQ1wvaWUsHwexXS3zyxpubZOhw6XY0I1p/9ktmj4eiDLj2mGyBgSnCM
         qmAxfKREaPfUr8GVgamcfTO8idoraefR1QpxCL0SvO2GFkRmdOORog6q8V+C5Pl7FYc7
         X5yBNNpYrh/7VE9DoHaJi3sl4KTZS3GbYUAR/jrlya70Ho+9Y8q/nXKYCIHsyQWjCdt4
         1YbMsKA9KglAq0P4Kg/lq+mF/KYUR3EdkFZqrt2mX/1wl6QD+/tzyR/7b69FOmZL2G+O
         ondWWM6dPHhiieBREkjypwh75NsD8oo37ERPOvUy7Ahhj7jKInsAPrLpFVOFbMNEYBZu
         VAnQ==
X-Gm-Message-State: APjAAAVJuyRAyMoP2fHs2XVSw9M7pvPxLXFIiH1dPZ9k5jwfq/1HZLqn
        m4tFN0Aa7LFji2yD3hI+HkOJqw==
X-Google-Smtp-Source: APXvYqyGds7sD98KClwP8vPM/hhwyoxGqLWwe/lQvhK2aDW5qJOTjJFAOfarEo2F9FxknbT8y5v6yg==
X-Received: by 2002:a63:7d49:: with SMTP id m9mr1704700pgn.161.1566521540968;
        Thu, 22 Aug 2019 17:52:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g1sm460656pgg.27.2019.08.22.17.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 17:52:20 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:52:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190823005218.GA36261@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-4-swood@redhat.com>
 <20190822135953.GB29841@google.com>
 <c44d6ab34f2f4e4a5d36036cc8b356a3f4f3519b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44d6ab34f2f4e4a5d36036cc8b356a3f4f3519b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 02:31:17PM -0500, Scott Wood wrote:
> On Thu, 2019-08-22 at 09:59 -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 06:19:06PM -0500, Scott Wood wrote:
> > > I think the prohibition on use_softirq can be dropped once RT gets the
> > > latest RCU code, but the question of what use_softirq should default
> > > to on PREEMPT_RT remains.
> > 
> > Independent of the question of what use_softirq should default to, could
> > we
> > test RT with latest RCU code now to check if the deadlock goes away?  That
> > way, maybe we can find any issues in current RCU that cause scheduler
> > deadlocks in the situation you pointed. The reason I am asking is because
> > recently additional commits [1] try to prevent deadlock and it'd be nice
> > to
> > ensure that other conditions are not lingering (I don't think they are but
> > it'd be nice to be sure).
> > 
> > I am happy to do such testing myself if you want, however what does it
> > take
> > to apply the RT patchset to the latest mainline? Is it an achievable feat?
> 
> I did run such a test (cherry picking all RCU patches that aren't already in
> RT, plus your RFC patch to rcu_read_unlock_special, rather than applying RT
> to current mainline) with rcutorture plus a looping kernel build overnight,
> and didn't see any splats with or without use_softirq.

Cool, that's good to know you didn't see splats!

thanks,

 - Joel

