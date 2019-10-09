Return-Path: <SRS0=K+Cf=YC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B9C47404
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180552133F
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 06:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJIGZp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:25:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfJIGZp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Oct 2019 02:25:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6367018C8924;
        Wed,  9 Oct 2019 06:25:45 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82F860A9F;
        Wed,  9 Oct 2019 06:25:39 +0000 (UTC)
Message-ID: <a1098e5f95a1ab202fdf79a73aedfeeb8e02dd47.camel@redhat.com>
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
From:   Scott Wood <swood@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Wed, 09 Oct 2019 01:25:38 -0500
In-Reply-To: <20191001085209.GA6481@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-6-swood@redhat.com>
         <20190927081141.GB31660@localhost.localdomain>
         <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
         <20190930071233.GE31660@localhost.localdomain>
         <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
         <20191001085209.GA6481@localhost.localdomain>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 09 Oct 2019 06:25:45 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-10-01 at 10:52 +0200, Juri Lelli wrote:
> On 30/09/19 11:24, Scott Wood wrote:
> > On Mon, 2019-09-30 at 09:12 +0200, Juri Lelli wrote:
> 
> [...]
> 
> > > Hummm, I was actually more worried about the fact that we call
> > > free_old_
> > > cpuset_bw_dl() only if p->state != TASK_WAKING.
> > 
> > Oh, right. :-P  Not sure what I had in mind there; we want to call it
> > regardless.
> > 
> > I assume we need rq->lock in free_old_cpuset_bw_dl()?  So something like
> 
> I think we can do with rcu_read_lock_sched() (see dl_task_can_attach()).

RCU will keep dl_bw from being freed under us (we're implicitly in an RCU
sched read section due to atomic context).  It won't stop rq->rd from
changing, but that could have happened before we took rq->lock.  If the cpu
the task was running on was removed from the cpuset, and that raced with the
task being moved to a different cpuset, couldn't we end up erroneously
subtracting from the cpu's new root domain (or failing to subtract at all if
the old cpu's new cpuset happens to be the task's new cpuset)?  I don't see
anything that forces tasks off of the cpu when a cpu is removed from a
cpuset (though maybe I'm not looking in the right place), so the race window
could be quite large.  In any case, that's an existing problem that's not
going to get solved in this patchset.

-Scott


