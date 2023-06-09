Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0AC83005
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jun 2023 01:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjFIBCk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbjFIBCi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2023 21:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC42712
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jun 2023 18:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D032965281
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Jun 2023 01:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94EFC433D2;
        Fri,  9 Jun 2023 01:02:33 +0000 (UTC)
Date:   Thu, 8 Jun 2023 21:02:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
Message-ID: <20230608210232.056e731f@gandalf.local.home>
In-Reply-To: <ZIJwNBZa0UUTAx5i@uudg.org>
References: <ZIJwNBZa0UUTAx5i@uudg.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 8 Jun 2023 21:20:04 -0300
"Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:

> Sebastian, Steven,
> 
> I don't know if this is the best solution for the problem, but surely the
> simplest one. If this patch makes sense, it could probably go upstream as
> the changes only affect RT.
> 
> -------
> 
> rt: vmd: make cfg_lock a raw spinlock
> 
> This call sequence triggers the backtrace listed below:
> 
>     pci_user_read_config_dword()  --->  vmd_pci_read()

Since pci_user_read_config_dword() (and all other sizes) uses
raw_spin_lock(), I guess there's really no other choice than to have
vmd_pci_read() do the same.

-- Steve


> 
> The first function, pci_user_read_config_dword(), takes a raw_spin_lock
> (a classic spin lock) and disables preemption and interrupts. Then
> vmd_pci_read() takes a RT spinlock (a rtmutex), which can sleep, hence
> the complaint about a sleeping function being called from atomic context.
> 
> 
> [  168.466387] LTP: starting read_all_proc (read_all -d /proc -q -r 3)
> [  168.614389] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [  168.614393] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 10268, name: read_all
> [  168.614395] preempt_count: 1, expected: 0
> [  168.614396] RCU nest depth: 0, expected: 0
> [  168.614397] INFO: lockdep is turned off.
> [  168.614398] irq event stamp: 0
> [  168.614398] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  168.614402] hardirqs last disabled at (0): [<ffffffffa4b0f3bf>] copy_process+0x80f/0x1990
> [  168.614411] softirqs last  enabled at (0): [<ffffffffa4b0f3bf>] copy_process+0x80f/0x1990
> [  168.614414] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  168.614415] Preemption disabled at:
> [  168.614416] [<0000000000000000>] 0x0
> [  168.614418] CPU: 19 PID: 10268 Comm: read_all Tainted: G        W          6.4.0-rc5-rt4 #2
> [  168.614421] Hardware name: Dell Inc. Precision 7820 Tower/0804P1, BIOS 2.6.3 05/04/2020
> [  168.614422] Call Trace:
> [  168.614424]  <TASK>
> [  168.614425]  dump_stack_lvl+0x47/0x80
> [  168.614433]  __might_resched+0x19b/0x250
> [  168.614441]  rt_spin_lock+0x4c/0x100
> [  168.614446]  ? vmd_pci_read+0x85/0xf0
> [  168.614453]  vmd_pci_read+0x85/0xf0
> [  168.614456]  pci_user_read_config_dword+0x78/0x100
