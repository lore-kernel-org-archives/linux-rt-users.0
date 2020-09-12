Return-Path: <SRS0=oRme=CV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12935C433E2
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Sep 2020 03:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2698208FE
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Sep 2020 03:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgILDsU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Sep 2020 23:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgILDsT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Sep 2020 23:48:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725C3208FE;
        Sat, 12 Sep 2020 03:48:18 +0000 (UTC)
Date:   Fri, 11 Sep 2020 23:48:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Bo Gan <ganb@vmware.com>, Sharath George <sharathg@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>
Subject: [REGRESSION] Needless shutting down of oneshot timer in nohz mode
Message-ID: <20200911234816.474ad4bd@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Thomas,

The VMware PhotonOS team is evaluating 4.19-rt compared to CentOS
3.10-rt (franken kernel from Red Hat). They found a regression between
the two kernels that was found to be introduced by:

 d25408756accb ("clockevents: Stop unused clockevent devices")

The issue is running this on a guest, and it causes a noticeable wake
up latency in cyclictest. The 4.19-rt kernel has two extra apic
instructions causing for two extra VMEXITs to occur over the 3.10-rt
kernel. I found out the reason why, and this is true for vanilla 5.9-rc
as well.

When running isocpus with NOHZ_FULL, I see the following.

  tick_nohz_idle_stop_tick() {
	hrtimer_start_range_ns() {
		remove_hrtimer(timer)
			/* no more timers on the base */
			expires = KTIME_MAX;
			tick_program_event() {
				clock_switch_state(ONESHOT_STOPPED);
				/* call to apic to shutdown timer */
			}
		}
		[..]
		hrtimer_reprogram(timer) {
			tick_program_event() {
				clock_switch_state(ONESHOT);
				/* call to apic to enable timer again! */
		}
	}
 }


Thus, we are needlessly shutting down and restarting the apic every
time we call tick_nohz_stop_tick() if there is a timer still on the
queue.

I'm not exactly sure how to fix this. Is there a way we can hold off
disabling the clock here until we know that it isn't going to be
immediately enabled again?

-- Steve
