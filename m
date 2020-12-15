Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F8C4361B
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Dec 2020 14:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0650224D2
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Dec 2020 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLOOGL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbgLOOGD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Dec 2020 09:06:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E021F224D2;
        Tue, 15 Dec 2020 14:05:21 +0000 (UTC)
Date:   Tue, 15 Dec 2020 09:05:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Orivej Desh <c@orivej.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201215090520.609b76dc@gandalf.local.home>
In-Reply-To: <6307cab9d73d88b16e1e87ddb273a7b27d3e51f6.camel@gmx.de>
References: <20201208212841.694b3022@orivej.orivej.org>
        <20201214123302.w2bem7tlb664jdvx@linutronix.de>
        <6307cab9d73d88b16e1e87ddb273a7b27d3e51f6.camel@gmx.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 15 Dec 2020 04:19:23 +0100
Mike Galbraith <efault@gmx.de> wrote:

> From 859a31c5ec958326dd046f4e41f6fa0db0ce98c3 Mon Sep 17 00:00:00 2001
> From: Steven Rostedt <srostedt@redhat.com>
> Date: Mon, 16 Apr 2012 21:51:54 -0400
> Subject: rt: Make migrate_disable/enable() and __rt_mutex_init non-GPL only
> 
> Modules that load on the normal vanilla kernel should also load on
> an -rt kernel as well. This does not mean we condone non-GPL modules,
> we are only being consistent.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Yep,

Back in the day (like in 2005), we said that -rt should strive to work
wherever vanilla Linux works. Thus, if we add a symbol that replaces a non
GPL symbol, we need to keep that symbol non GPL.

-- Steve
