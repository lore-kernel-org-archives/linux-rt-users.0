Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A24C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91220665
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 18:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408313AbfIXSFx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407040AbfIXSFx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 14:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E8AAC049E36;
        Tue, 24 Sep 2019 18:05:53 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15BE600CC;
        Tue, 24 Sep 2019 18:05:47 +0000 (UTC)
Message-ID: <b07c0ad99393cfa0968a926bd7302adef4c6a7e4.camel@redhat.com>
Subject: Re: [PATCH RT 7/8] sched: migrate_enable: Use select_fallback_rq()
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 24 Sep 2019 13:05:47 -0500
In-Reply-To: <20190917160030.i24gvyye2bpdykfy@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-8-swood@redhat.com>
         <20190917160030.i24gvyye2bpdykfy@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 24 Sep 2019 18:05:53 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 18:00 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-27 00:56:37 [-0500], Scott Wood wrote:
> > migrate_enable() currently open-codes a variant of select_fallback_rq().
> > However, it does not have the "No more Mr. Nice Guy" fallback and thus
> > it will pass an invalid CPU to the migration thread if cpus_mask only
> > contains a CPU that is !active.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > This scenario will be more likely after the next patch, since
> > the migrate_disable_update check goes away.  However, it could happen
> > anyway if cpus_mask was updated to a CPU other than the one we were
> > pinned to, and that CPU subsequently became inactive.
> 
> I'm unclear about the problem / side effect this has (before and after
> the change). It is possible (before and after that change) that a CPU is
> selected which is invalid / goes offline after the "preempt_enable()"
> statement and before stop_one_cpu() does its job, correct?

By "pass an invalid CPU" I don't mean offline; I mean >= nr_cpu_ids which is
what cpumask_any_and() returns if the sets don't intersect (a CPU going
offline is merely a way to end up in that situation).  At one point I
observed that causing a crash.  I guess is_cpu_allowed() returned true by
chance based on the contents of data beyond the end of the cpumask?  That
doesn't seem likely based on what comes after p->cpus_mask (at that point
migrate_disable should be zero), but maybe I had something else at that
point in the struct while developing.  In any case, not something to be
relied on. :-)

Going offline after selection shouldn't be a problem.  migration_cpu_stop()
won't do anything if is_cpu_allowed() returns false, and we'll get migrated
off the CPU by migrate_tasks().  Even if we get migrated after reading
task_cpu(p) but before queuing the stop machine work, it'll either get
flushed when the stopper thread parks, or rejected due to stopper->enabled
being false.

-Scott


