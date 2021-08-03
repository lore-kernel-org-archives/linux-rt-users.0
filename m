Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA71C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E15A6056B
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhHCWzC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:55:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhHCWzB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Aug 2021 18:55:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A5413A1;
        Tue,  3 Aug 2021 15:54:49 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D252D3F66F;
        Tue,  3 Aug 2021 15:54:47 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/2] rcutorture: Some PREEMPT_RT fixlets
Date:   Tue,  3 Aug 2021 23:54:35 +0100
Message-Id: <20210803225437.3612591-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

I've been meaning to run RCU torture under v5.13-rt1 to validate my hacking
around the RCU offloaded state [1], but have hit some warnings.


The second patch clearly isn't a thing of beauty, but FWIW it lets me run RCU
torture tests without any extra steps.

As mentioned over IRC, this started as a .setup() callback for the kosftirqd
threads gated behind CONFIG_RCU_BOOST && CONFIG_RCU_TORTURE_TEST, but I figured
keeping RCU torture specific stuff within rcutorture.c would be a tad smarter.
I hate either version, but here it is regardless.

[1]: https://lore.kernel.org/lkml/20210728220137.GD293265@lothringen/

Cheers,
Valentin

Valentin Schneider (2):
  rcutorture: Don't disable softirqs with preemption disabled when
    PREEMPT_RT
  rcutorture: Nudge ksoftirqd priority for RCU boost testing

 kernel/rcu/rcutorture.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--
2.25.1

