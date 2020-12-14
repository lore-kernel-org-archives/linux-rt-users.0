Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10760C4361B
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C393422510
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 23:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgLNXcX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:32:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44821 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgLNXcV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 18:32:21 -0500
X-Originating-IP: 193.27.14.10
Received: from orivej.orivej.org (unknown [193.27.14.10])
        (Authenticated sender: orivej@orivej.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C32A6240003;
        Mon, 14 Dec 2020 23:31:36 +0000 (UTC)
Date:   Mon, 14 Dec 2020 23:31:34 +0000
From:   Orivej Desh <c@orivej.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201214233134.06f12bbb@orivej.orivej.org>
In-Reply-To: <20201214123302.w2bem7tlb664jdvx@linutronix.de>
References: <20201208212841.694b3022@orivej.orivej.org>
        <20201214123302.w2bem7tlb664jdvx@linutronix.de>
X-Mailer: Claws Mail 3.99.0 (GTK+ 3.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [2020-12-14]
> On 2020-12-08 23:58:27 [+0000], Orivej Desh wrote:
> > With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [1]
> > linux-rt defines functions migrate_disable and migrate_enable.
> > They are used in linux headers in various macros and static inline
> > functions, and in particular in kmap_atomic and kunmap_atomic.
> > The latter are needed by ZFS which currently fails to build against
> > 5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL.
> > Could you export them with EXPORT_SYMBOL instead?  
> 
> This is out of my jurisdiction, so just a few notes:
> - v5.9 is out of maintenance. Be careful.

Thanks! I have noticed a bug with usb-storage (using smp_processor_id
in preemptible code) in 5.9.1-rt20 thas has been fixed in 5.10-rt17.

> - We don't export symbols for out-of-tree modules.

The issue is that in the vanilla kernel these two functions are
available as macros that expand into EXPORT_SYMBOL function calls
(kunmap_atomic_high, etc.). If I am not mistaken the kernel is
generally supposed to keep the API made available to non-GPL modules
still available, for example here https://lwn.net/Articles/171838/ :
"When GPL-only exports were first added to the kernel, they went in
with the understanding that only new symbols would be tagged
GPL-only. The current module interface - while always subject to
change - was not to have symbols withdrawn arbitrarily." The current
rt patch has this effect: it makes non-GPL API of the vanilla kernel
GPL-only.
