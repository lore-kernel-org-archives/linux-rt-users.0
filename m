Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B06C4360C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E08207E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfI0UDE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfI0UDE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 16:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AC5B307D84D;
        Fri, 27 Sep 2019 20:03:04 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0ACD1001B07;
        Fri, 27 Sep 2019 20:02:57 +0000 (UTC)
Message-ID: <7804e2b7f629ff655bc8284bad17fb263d4a003a.camel@redhat.com>
Subject: Re: [PATCH RT 4/8] sched: migrate disable: Protect cpus_ptr with
 lock
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 27 Sep 2019 15:02:57 -0500
In-Reply-To: <20190927121954.3gbzk3i3jbpugrjo@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-5-swood@redhat.com>
         <20190926163940.khzhsp3a4h7vj7lw@linutronix.de>
         <f3b31297df859eb7d1dc86637c29b271fbf87970.camel@redhat.com>
         <20190927121954.3gbzk3i3jbpugrjo@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 20:03:04 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-09-27 at 14:19 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-26 11:52:42 [-0500], Scott Wood wrote:
> > Looks good, thanks!
> 
> Thanks, just released.
> Moving forward. It would be nice to have some DL-dev feedback on DL
> patch. For the remaining once, could please throw Steven's
> stress-test-hostplug-cpu-script? If that one does not complain I don't
> see a reason why not apply the patches (since they improve performance
> and do not break anything while doing so).

I'd been using a quick-and-dirty script that does something similar, and ran
it along with rcutorture, a kernel build, and something that randomly
changes affinities -- though with these loads I have to ignore occasional
RCU forward progress complaints that Paul said were expected with this
version of the RCU code, XFS warnings that happen even on unmodified non-RT, 
and sometimes a transitory netdev timeout that is not that surprising given
the heavy load and affinity stress (I get it without these patches as well,
though it takes longer).

I just ran Steven's script (both alone and with the other stuff above) and
saw no difference.

-Scott

