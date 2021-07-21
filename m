Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FBC12002
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EF260C40
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhGUIWk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:22:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhGUIOx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:14:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C277224E6;
        Wed, 21 Jul 2021 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626857044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV4EH+LUx8k8415eaM5w7Ajz0rH98YCcAorT7SWra2M=;
        b=vVq/1WSNagTpuOaRP4J6sYRPQuxJn2pGKuSP9JavQuUz36yD05vK0bPz3RoBgEj0Oj0s6o
        PbyFlaxQwY2Zgj25omAL7ezvzegkrCNXRdThVuoey29iVJ2es/XmaS22DdFtOnw4G0xCGB
        O208Ry8S32Mbs5FJeyJvIWNhwfhUqqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626857044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV4EH+LUx8k8415eaM5w7Ajz0rH98YCcAorT7SWra2M=;
        b=9aA7pfiAkFLFapS83qB/5qNs1S2qesMhB1eSq5paBhUFpgKlX/gwLWgT8dYgbaujc5j3u7
        LZBDX584pw9rABCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 425CA13BC9;
        Wed, 21 Jul 2021 08:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id hgh5D1Te92CwKQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 21 Jul 2021 08:44:04 +0000
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
 <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
 <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
 <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
Message-ID: <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
Date:   Wed, 21 Jul 2021 10:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/21/21 6:56 AM, Mike Galbraith wrote:
> On Tue, 2021-07-20 at 13:26 +0200, Mike Galbraith wrote:
>> On Tue, 2021-07-20 at 10:56 +0200, Vlastimil Babka wrote:
>> > > crash> bt -sx
>> > > PID: 18761  TASK: ffff88812fff0000  CPU: 0   COMMAND: "hackbench"
>> > >  #0 [ffff88818f8ff980] machine_kexec+0x14f at ffffffff81051c8f
>> > >  #1 [ffff88818f8ff9c8] __crash_kexec+0xd2 at ffffffff8111ef72
>> > >  #2 [ffff88818f8ffa88] crash_kexec+0x30 at ffffffff8111fd10
>> > >  #3 [ffff88818f8ffa98] oops_end+0xd3 at ffffffff810267e3
>> > >  #4 [ffff88818f8ffab8] exc_general_protection+0x195 at
>> > > ffffffff8179fdb5
>> > >  #5 [ffff88818f8ffb50] asm_exc_general_protection+0x1e at
>> > > ffffffff81800a0e
>> > >     [exception RIP: __unfreeze_partials+156]
>> >
>> > Hm going back to this report...
>> > So could it be that it was stillput_cpu_partial() preempting
>> > __slab_alloc() messing the partial list, but for some reason the
>> > put_cpu_partial() side crashed this time?
>>
>> Thinking this bug is toast, I emptied the trash bin, so no can peek.
> 
> I made fireworks while waiting for bike riding time, boom #10 was
> finally the right flavor, but...
> 
> crash> bt -sx
> PID: 32     TASK: ffff888100a56000  CPU: 3   COMMAND: "rcuc/3"
>  #0 [ffff888100aa7a90] machine_kexec+0x14f at ffffffff81051c8f
>  #1 [ffff888100aa7ad8] __crash_kexec+0xd2 at ffffffff81120612
>  #2 [ffff888100aa7b98] crash_kexec+0x30 at ffffffff811213b0
>  #3 [ffff888100aa7ba8] oops_end+0xd3 at ffffffff810267e3
>  #4 [ffff888100aa7bc8] exc_general_protection+0x195 at ffffffff817a2cc5
>  #5 [ffff888100aa7c60] asm_exc_general_protection+0x1e at ffffffff81800a0e
>     [exception RIP: __unfreeze_partials+149]
>     RIP: ffffffff8124a295  RSP: ffff888100aa7d10  RFLAGS: 00010202
>     RAX: 0000000000190016  RBX: 0000000000190016  RCX: 000000017fffffff
>     RDX: 00000001ffffffff  RSI: 0000000000000023  RDI: ffffffff81e58b10
>     RBP: ffff888100aa7da0   R8: 0000000000000000   R9: 0000000000190018
>     R10: ffff888100aa7db8  R11: 000000000002d9e4  R12: ffff888100190500
>     R13: ffff88810018c980  R14: 00000001ffffffff  R15: ffffea0004571588
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #6 [ffff888100aa7db0] put_cpu_partial+0x8e at ffffffff8124a56e
>  #7 [ffff888100aa7dd0] kmem_cache_free+0x3a8 at ffffffff8124d238
>  #8 [ffff888100aa7e08] rcu_do_batch+0x186 at ffffffff810eb246
>  #9 [ffff888100aa7e70] rcu_core+0x25f at ffffffff810eeb2f
> #10 [ffff888100aa7eb0] rcu_cpu_kthread+0x94 at ffffffff810eed24
> #11 [ffff888100aa7ee0] smpboot_thread_fn+0x249 at ffffffff8109e559
> #12 [ffff888100aa7f18] kthread+0x1ac at ffffffff810984dc
> #13 [ffff888100aa7f50] ret_from_fork+0x1f at ffffffff81001b1f
> crash> runq
> ...
> CPU 3 RUNQUEUE: ffff88840ece9980
>   CURRENT: PID: 32     TASK: ffff888100a56000  COMMAND: "rcuc/3"
>   RT PRIO_ARRAY: ffff88840ece9bc0
>      [ 94] PID: 32     TASK: ffff888100a56000  COMMAND: "rcuc/3"
>   CFS RB_ROOT: ffff88840ece9a40
>      [120] PID: 33     TASK: ffff888100a51000  COMMAND: "ksoftirqd/3"
> ...
> crash> bt -sx 33
> PID: 33     TASK: ffff888100a51000  CPU: 3   COMMAND: "ksoftirqd/3"
>  #0 [ffff888100aabdf0] __schedule+0x2d7 at ffffffff817ad3a7
>  #1 [ffff888100aabec8] schedule+0x3b at ffffffff817ae4eb
>  #2 [ffff888100aabee0] smpboot_thread_fn+0x18c at ffffffff8109e49c
>  #3 [ffff888100aabf18] kthread+0x1ac at ffffffff810984dc
>  #4 [ffff888100aabf50] ret_from_fork+0x1f at ffffffff81001b1f
> crash>

So this doesn't look like our put_cpu_partial() preempted a __slab_alloc() on
the same cpu, right? There might have been __slab_alloc() in irq handler
preempting us, but we won't see that anymore. I don't immediately see the root
cause and this scenario should be possible on !RT too where we however didn't
see these explosions.

BTW did my ugly patch work?

Thanks.
