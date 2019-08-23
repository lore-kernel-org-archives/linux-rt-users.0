Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFDC3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DD7233A0
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 01:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfHWBVj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733068AbfHWBVi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 21:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAE623082A98;
        Fri, 23 Aug 2019 01:21:38 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A1560C57;
        Fri, 23 Aug 2019 01:21:35 +0000 (UTC)
Message-ID: <99df6853f2eb541773435053983ab466b88b0d74.camel@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Thu, 22 Aug 2019 20:21:34 -0500
In-Reply-To: <20190821233555.GV28441@linux.ibm.com>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-3-swood@redhat.com>
         <20190821233555.GV28441@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 01:21:38 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2019-08-21 at 16:35 -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 06:19:05PM -0500, Scott Wood wrote:
> > Without this, rcu_note_context_switch() will complain if an RCU read
> > lock is held when migrate_enable() calls stop_one_cpu().
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> 
> I have to ask...  Both sleeping_lock_inc() and sleeping_lock_dec() are
> no-ops if not CONFIG_PREEMPT_RT_BASE?

Yes.

-Scott


