Return-Path: <SRS0=Ai3V=YD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E34C10F14
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Oct 2019 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F8B208C3
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Oct 2019 08:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfJJISG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:18:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733129AbfJJISG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Oct 2019 04:18:06 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D53E89AC0
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Oct 2019 08:18:05 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j7so2362831wrx.14
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Oct 2019 01:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=utApHrGe/awDdIqfPvOOXzUlqASS6rak8FxfwZ5Sv4Y=;
        b=L2tJATAXftL5pZLj8DR2I+gVZete5Q1gpdkhZQxo8by2S3W7smL9e42YX1vIuPlDP4
         Lv0PT3kFa7jfWehwBdYSnGz1JarIWMkeTYPCnk46l0Wq4arxmzoQePKLRn7oUaNhzSLJ
         VGeir1RifVG+/aIVUN4NVvF0BaRpIFA3frjclGyG7TWEW1LLcWDnsIxksvNbhhFzvJ1e
         0LYZXDDi3MQBZC3KYI7qCKNCYOhsSQMcHpZTNDMLK7ZsYjbrBEyIbjDKAfYwYrjnTKke
         pOGqDDg6ZJs9lnAmY3cAtRtL217+K9A51gauregpnZ8IWCwdxW2HlO9ANl5MypjwTSfR
         RJrA==
X-Gm-Message-State: APjAAAUsAgtsNsTSxdZKDTMZ0iFHCw7uf4nZwsNEOJdee+kHLSgC72hw
        TKfoKFRIxNgh64uDy+vNc7ksOT6jYMhvQH/xeW5ksTeAfGpmzgS2F3sW9JKxxv9uJ+rxu4EZtva
        gJwRnUT+DUki61VNCOccBefzAOo0=
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr7159892wrw.39.1570695483666;
        Thu, 10 Oct 2019 01:18:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwogbdVNWOcfdM/AVkSN3njicOGnuieW3+tHaoVIaZiH5dHUANgztLxmYv8Ypla98tD8EnuGQ==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr7159846wrw.39.1570695483209;
        Thu, 10 Oct 2019 01:18:03 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id 79sm5830782wmb.7.2019.10.10.01.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 01:18:02 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:18:00 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20191010081800.GK19588@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
 <20190927081141.GB31660@localhost.localdomain>
 <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
 <20190930071233.GE31660@localhost.localdomain>
 <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
 <20191001085209.GA6481@localhost.localdomain>
 <a1098e5f95a1ab202fdf79a73aedfeeb8e02dd47.camel@redhat.com>
 <20191009072745.GI19588@localhost.localdomain>
 <9c12342ed1e6d180fae3348409fabb9fc045361d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c12342ed1e6d180fae3348409fabb9fc045361d.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 09/10/19 14:12, Scott Wood wrote:
> On Wed, 2019-10-09 at 09:27 +0200, Juri Lelli wrote:
> > On 09/10/19 01:25, Scott Wood wrote:
> > > On Tue, 2019-10-01 at 10:52 +0200, Juri Lelli wrote:
> > > > On 30/09/19 11:24, Scott Wood wrote:
> > > > > On Mon, 2019-09-30 at 09:12 +0200, Juri Lelli wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > Hummm, I was actually more worried about the fact that we call
> > > > > > free_old_
> > > > > > cpuset_bw_dl() only if p->state != TASK_WAKING.
> > > > > 
> > > > > Oh, right. :-P  Not sure what I had in mind there; we want to call
> > > > > it
> > > > > regardless.
> > > > > 
> > > > > I assume we need rq->lock in free_old_cpuset_bw_dl()?  So something
> > > > > like
> > > > 
> > > > I think we can do with rcu_read_lock_sched() (see
> > > > dl_task_can_attach()).
> > > 
> > > RCU will keep dl_bw from being freed under us (we're implicitly in an
> > > RCU
> > > sched read section due to atomic context).  It won't stop rq->rd from
> > > changing, but that could have happened before we took rq->lock.  If the
> > > cpu
> > > the task was running on was removed from the cpuset, and that raced with
> > > the
> > > task being moved to a different cpuset, couldn't we end up erroneously
> > > subtracting from the cpu's new root domain (or failing to subtract at
> > > all if
> > > the old cpu's new cpuset happens to be the task's new cpuset)?  I don't
> > > see
> > > anything that forces tasks off of the cpu when a cpu is removed from a
> > > cpuset (though maybe I'm not looking in the right place), so the race
> > > window
> > > could be quite large.  In any case, that's an existing problem that's
> > > not
> > > going to get solved in this patchset.
> > 
> > OK. So, mainline has got cpuset_read_lock() which should be enough to
> > guard against changes to rd(s).
> > 
> > I agree that rq->lock is needed here.
> 
> My point was that rq->lock isn't actually helping, because rq->rd could have
> changed before rq->lock is acquired (and it's still the old rd that needs
> the bandwidth subtraction).  cpuset_mutex/cpuset_rwsem helps somewhat,
> though there's still a problem due to the subtraction not happening until
> the task is woken up (by which time cpuset_mutex may have been released and
> further reconfiguration could have happened).  This would be an issue even
> without lazy migrate, since in that case ->set_cpus_allowed() can get
> deferred, but this patch makes the window much bigger.
> 
> The right solution is probably to explicitly track the rd for which a task
> has a pending bandwidth subtraction (if any), and to continue doing it from
> set_cpus_allowed() if the task is not migrate-disabled.  In the meantime, I
> think we should drop this patch from the patchset -- without it, lazy
> migrate disable doesn't really make the race situation any worse than it
> already was.

I'm OK with dropping it for now (as we also have other possible issues
as you point out below), but I really wonder what would be a solution
here. Problem is that if a domain(s) reconfiguration happened while the
task was migrate disabled, and we let the reconf destroy/rebuild
domains, the old rd could be gone by the time the task gets migrate
enabled again and the task could continue running, w/o its bandwidth
been accounted for, in a new rd since the migrate enable instant, no?

:-/

> BTW, what happens to the bw addition in dl_task_can_attach() if a subsequent
> can_attach fails and the whole operation is cancelled?

Oh, yeah, that doesn't look good. :-(

Maybe we can use cancel_attach() to fix things up?

Thanks,

Juri
