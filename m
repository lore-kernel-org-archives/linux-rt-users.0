Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1FC55186
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7152166E
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587633187;
	bh=O10T2UR8aTOkEcaLjzdafkBdprz/u0SuzibtzuBzbZw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=kaSsrWTvy9x4iiV7bedBnnKFfR8UmgaTLWPn4wFHtPtkR0MUulW5oVSOranpdNH/6
	 imPfJ2rJIEAkanBsvVUsJbkny0B2ojrSIDpIgmXu2IHvKwYbs8L5k/6DXNTf4sPAIB
	 2A0I9J4r/d18/VcvnoOJAWeVjuo+Q7rtJu21qLuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDWJNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgDWJNE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 05:13:04 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CCD2075A;
        Thu, 23 Apr 2020 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587633183;
        bh=O10T2UR8aTOkEcaLjzdafkBdprz/u0SuzibtzuBzbZw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=i/HoOCUIiot0hwOgxIq/Y3x3Y5ojRlx/FYGqOUujYgpQJkvGYdbwzfmgyPOcHvCzh
         TLiA76lLyVJ7pKuk9LBl4D0l0CBigabtPvIeV7+vdy2KthJ+g6V65YwVEM2PWgSzuB
         aq8YTpQlSt0utBj0UkYRC5NpyDm8WSL8tdjo/TPw=
Date:   Thu, 23 Apr 2020 11:12:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
In-Reply-To: <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
Message-ID: <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de> <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 23 Apr 2020, Jiri Kosina wrote:

> > I'm pleased to announce the v5.4.28-rt19 patch set. 
> 
> First, I don't believe this is necessarily a regression coming with this 
> particular version, but this is the first kernel where I tried this and it 
> crashed.

I just tried with 5.6.4-rt3, and I can make it explode exactly the same 
way:

[   46.523586] 000: irq 4: nobody cared (try booting with the "irqpoll" option)
4187418741874187[   46.523608] 000: CPU: 0 PID: 1219 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19+ #10
[   46.523611] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   46.523613] 000: Call Trace:
[   46.523630] 000:  <IRQ>
[   46.523638] 000:  dump_stack+0x50/0x6b
[   46.523655] 000:  __report_bad_irq+0x2b/0xb0
[   46.523662] 000:  note_interrupt+0x22e/0x280
[   46.523666] 000:  ? io_serial_out+0x11/0x20
[   46.523671] 000:  handle_irq_event_percpu+0x6e/0x90
[   46.523676] 000:  handle_irq_event+0x48/0x90
[   46.523678] 000:  handle_edge_irq+0x95/0x1f0
[   46.523683] 000:  do_IRQ+0x6c/0x120
[   46.523692] 000:  common_interrupt+0xf/0xf
[   46.523700] 000:  </IRQ>
[   46.523701] 000: RIP: 0010:io_serial_out+0x11/0x20
[   46.523706] 000: Code: 8b 57 30 d3 e6 01 f2 ec 0f b6 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f b6 8f e1 00 00 00 89 d0 8b 57 30 d3 e6 01 f2 ee <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f b6 87 e2 00 00 00
[   46.523709] 000: RSP: 0018:ffffa4ce80813de8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdb
[   46.523710] 000: RAX: 0000000000000031 RBX: ffffffffb57a0de0 RCX: 0000000000000000
[   46.523716] 000: RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffffb57a0de0
[   46.523718] 000: RBP: ffffa30bf9320000 R08: ffffffffb4c0b7a0 R09: 0000000000000001
[   46.523719] 000: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000010
[   46.523720] 000: R13: 0000000000000020 R14: 0000000000000001 R15: ffffa30bfa737498
[   46.523730] 000:  ? io_serial_in+0x20/0x20
[   46.523732] 000:  serial8250_tx_chars+0x121/0x310
[   46.523735] 000:  ? migrate_disable+0x33/0x90
[   46.523739] 000:  serial8250_handle_irq.part.26+0xbb/0xc0
[   46.523745] 000:  serial8250_default_handle_irq+0x45/0x50
[   46.523747] 000:  serial8250_interrupt+0x51/0xa0
[   46.523750] 000:  ? irq_finalize_oneshot.part.46+0xd0/0xd0
[   46.523752] 000:  irq_forced_thread_fn+0x2b/0x70
[   46.523754] 000:  irq_thread+0xd8/0x170
[   46.523757] 000:  ? wake_threads_waitq+0x30/0x30
[   46.523759] 000:  ? irq_thread_dtor+0x90/0x90
[   46.523760] 000:  kthread+0x10e/0x130
[   46.523765] 000:  ? kthread_park+0x80/0x80
[   46.523766] 000:  ret_from_fork+0x35/0x40
[   46.523772] 000: handlers:
[   46.523776] 000: [<00000000cdfd4a1d>] irq_default_primary_handler threaded [<0000000078f3e5cd>] serial8250_interrupt
[   46.523778] 000: Disabling IRQ #4

-- 
Jiri Kosina
SUSE Labs

