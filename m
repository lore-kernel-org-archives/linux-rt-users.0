Return-Path: <SRS0=egP0=6A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22451C2BB55
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04131217D8
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895133AbgDPNUh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895029AbgDPNU3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 09:20:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE3C061A0C;
        Thu, 16 Apr 2020 06:20:09 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jP4R4-0001Ih-Vg; Thu, 16 Apr 2020 15:20:07 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] printk: console must not schedule for drivers
References: <20200406212217.2323-1-john.ogness@linutronix.de>
        <20200415163416.r3fce3g5kokm4bub@linutronix.de>
        <87o8rrg864.fsf@vostro.fn.ogness.net>
Date:   Thu, 16 Apr 2020 15:20:04 +0200
In-Reply-To: <87o8rrg864.fsf@vostro.fn.ogness.net> (John Ogness's message of
        "Thu, 16 Apr 2020 10:13:23 +0200")
Message-ID: <87ftd3ftyz.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-16, John Ogness <john.ogness@linutronix.de> wrote:
>> - Is there a scenario in fbcon where this function is invoked and
>>   console_may_schedule is not 0?

Sorry, I overlooked that you were specifically asking about fbcon. In
console_conditional_schedule() when it is going to call cond_resched(),
I added a WARN_ON() with a condition that it would only trigger in
fbcon. This allowed me to quickly generate a backtrace. This is what
showed up (upon hitting the return key in the graphical console):

[   19.694698][ T1301] Call Trace:
[   19.694743][ T1301]  dump_stack+0xa0/0xea
[   19.694766][ T1301]  console_conditional_schedule+0xac/0xc0
[   19.694779][ T1301]  fbcon_redraw.isra.16+0x1d2/0x460
[   19.694825][ T1301]  fbcon_scroll+0x1b28/0x36d0
[   19.694872][ T1301]  con_scroll+0x2dd/0x650
[   19.694914][ T1301]  lf+0x240/0x2a0
[   19.694930][ T1301]  ? con_scroll+0x650/0x650
[   19.694948][ T1301]  ? find_held_lock+0x36/0x1d0
[   19.694983][ T1301]  do_con_trol+0x33c/0x6720
[   19.695001][ T1301]  ? lock_downgrade+0x850/0x850
[   19.695019][ T1301]  ? reset_palette+0x210/0x210
[   19.695051][ T1301]  ? __kasan_check_read+0x11/0x20
[   19.695080][ T1301]  ? __atomic_notifier_call_chain+0x9a/0x110
[   19.695108][ T1301]  do_con_write.part.28+0xae2/0x1ba0
[   19.695179][ T1301]  ? do_con_trol+0x6720/0x6720
[   19.695195][ T1301]  ? mutex_lock_io_nested+0x1240/0x1240
[   19.695212][ T1301]  ? console_unlock+0x67d/0xac0
[   19.695238][ T1301]  ? __kasan_check_write+0x14/0x20
[   19.695249][ T1301]  ? __mutex_unlock_slowpath+0xe5/0x6a0
[   19.695287][ T1301]  con_write+0x24/0x90
[   19.695305][ T1301]  do_output_char+0x4f8/0x710
[   19.695330][ T1301]  n_tty_write+0x52b/0xfc0
[   19.695345][ T1301]  ? __might_fault+0xcb/0x1b0
[   19.695400][ T1301]  ? n_tty_read+0x1900/0x1900
[   19.695419][ T1301]  ? prepare_to_wait_exclusive+0x2f0/0x2f0
[   19.695444][ T1301]  ? __kasan_check_write+0x14/0x20
[   19.695469][ T1301]  tty_write+0x3ba/0x800
[   19.695492][ T1301]  ? n_tty_read+0x1900/0x1900
[   19.695519][ T1301]  __vfs_write+0x66/0x120
[   19.695541][ T1301]  vfs_write+0x19c/0x4b0
[   19.695568][ T1301]  ksys_write+0x110/0x230
[   19.695588][ T1301]  ? __ia32_sys_read+0xb0/0xb0
[   19.695604][ T1301]  ? do_syscall_64+0x1d/0x470
[   19.695617][ T1301]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   19.695646][ T1301]  __x64_sys_write+0x73/0xb0
[   19.695664][ T1301]  do_syscall_64+0x9a/0x470
[   19.695684][ T1301]  entry_SYSCALL_64_after_hwframe+0x49/0xb3

So the answer to your question is "yes".

It would probably be a good idea if vt_console_print() could set
console_may_schedule=0 after taking the printing_lock (spinlock).

There are probably more of these quirky cases hiding in the kernel. I've
taken note of this and will look into it when I get some free cycles.

John Ogness
