Return-Path: <SRS0=oQYw=3I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A572C33CB1
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Jan 2020 10:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0720674
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Jan 2020 10:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgASKeI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 19 Jan 2020 05:34:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgASKeI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 19 Jan 2020 05:34:08 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1it7u4-0001Xn-Ky; Sun, 19 Jan 2020 11:34:00 +0100
Date:   Sun, 19 Jan 2020 11:34:00 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] Revert "cpumask: Disable CONFIG_CPUMASK_OFFSTACK for
 RT"
Message-ID: <20200119103400.3vj4dr4sr4hxyxus@linutronix.de>
References: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
 <f19f0181e819989b13dc3605c25b110aa2677189.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f19f0181e819989b13dc3605c25b110aa2677189.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-01-19 02:03:23 [-0600], Scott Wood wrote:
> I get splats with this due to zalloc_cpumask_var() with preemption disabled
> (from the get_cpu() in x86 flush_tlb_mm_range()):

Is 
	http://lkml.kernel.org/r/20200117090137.1205765-1-bigeasy@linutronix.de

solving the issue?

Sebastian
