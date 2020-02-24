Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD9C3567B
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6871F20836
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBXJnx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:43:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXJnx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 04:43:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6AHG-0006zr-03; Mon, 24 Feb 2020 10:43:50 +0100
Date:   Mon, 24 Feb 2020 10:43:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 15/25] sched: migrate_enable: Use select_fallback_rq()
Message-ID: <20200224094349.5x6dca4tggtmmbnq@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <eb183ce95bb3d92b426bdadf36f0648cda474379.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb183ce95bb3d92b426bdadf36f0648cda474379.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 15:24:43 [-0600], zanussi@kernel.org wrote:
> From: Scott Wood <swood@redhat.com>
> 
> v4.14.170-rt75-rc1 stable review patch.
> If anyone has any objections, please let me know.

This creates bug which is stuffed later via
	sched: migrate_enable: Busy loop until the migration request is completed

So if apply this, please take the bug fix, too. This is Stevens queue
for reference:
|[PATCH RT 22/30] sched: migrate_enable: Use select_fallback_rq()
^^ bug introduced

|[PATCH RT 23/30] sched: Lazy migrate_disable processing                                                                              
|[PATCH RT 24/30] sched: migrate_enable: Use stop_one_cpu_nowait()
|[PATCH RT 25/30] Revert "ARM: Initialize split page table locks for vector page"
|[PATCH RT 26/30] locking: Make spinlock_t and rwlock_t a RCU section on RT
|[PATCH RT 27/30] sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
|[PATCH RT 28/30] lib/smp_processor_id: Adjust check_preemption_disabled()
|[PATCH RT 29/30] sched: migrate_enable: Busy loop until the migration request is completed
^^ bug fixed

Sebastian
