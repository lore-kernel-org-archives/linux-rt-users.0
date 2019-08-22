Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B0CC3A5A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F5321848
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfHVTbW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfHVTbW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 15:31:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3981308427C;
        Thu, 22 Aug 2019 19:31:21 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A3B600CD;
        Thu, 22 Aug 2019 19:31:18 +0000 (UTC)
Message-ID: <c44d6ab34f2f4e4a5d36036cc8b356a3f4f3519b.camel@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
From:   Scott Wood <swood@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Thu, 22 Aug 2019 14:31:17 -0500
In-Reply-To: <20190822135953.GB29841@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-4-swood@redhat.com>
         <20190822135953.GB29841@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 19:31:21 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-08-22 at 09:59 -0400, Joel Fernandes wrote:
> On Wed, Aug 21, 2019 at 06:19:06PM -0500, Scott Wood wrote:
> > I think the prohibition on use_softirq can be dropped once RT gets the
> > latest RCU code, but the question of what use_softirq should default
> > to on PREEMPT_RT remains.
> 
> Independent of the question of what use_softirq should default to, could
> we
> test RT with latest RCU code now to check if the deadlock goes away?  That
> way, maybe we can find any issues in current RCU that cause scheduler
> deadlocks in the situation you pointed. The reason I am asking is because
> recently additional commits [1] try to prevent deadlock and it'd be nice
> to
> ensure that other conditions are not lingering (I don't think they are but
> it'd be nice to be sure).
> 
> I am happy to do such testing myself if you want, however what does it
> take
> to apply the RT patchset to the latest mainline? Is it an achievable feat?

I did run such a test (cherry picking all RCU patches that aren't already in
RT, plus your RFC patch to rcu_read_unlock_special, rather than applying RT
to current mainline) with rcutorture plus a looping kernel build overnight,
and didn't see any splats with or without use_softirq.

-Scott


