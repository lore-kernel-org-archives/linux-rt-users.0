Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB918C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A660F00
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhHLVbf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:31:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHLVbd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 17:31:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 689381FD65;
        Thu, 12 Aug 2021 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628803866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OT4+yUi76ZWjpNppD2dkFGjpY6uzS5Eal1ClxeLIWkk=;
        b=213EeynWyaL9Ah9PNtL4SU7jnfPmgcrApSgVY5oMDl+W4ZoQyUWiJqI8ouw79Xih1ELvME
        5Y/G8Cm8Ky5qK4Z6wXUvVaB28b7pdO7CUCoVuNJwMFh8mEtv6MXoMBUrgSwmy9olxPCCuj
        3dFgMKA0x+8oceqGaoFYiozwipIvqbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628803866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OT4+yUi76ZWjpNppD2dkFGjpY6uzS5Eal1ClxeLIWkk=;
        b=8GmFKOeOf24qOJl179DI4v4RUa/Dyt+VtthEgyiSS3KwDh5PjzsRfr2J5DrbrbPhDCFnAt
        JLOrr5aLZv6IIcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AC8613C80;
        Thu, 12 Aug 2021 21:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B1BQERqTFWHAawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 21:31:06 +0000
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
To:     Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
 <20210812151803.52f84aaf@theseus.lan>
 <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
 <20210812162448.26274298@theseus.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
Date:   Thu, 12 Aug 2021 23:30:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812162448.26274298@theseus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/12/21 11:24 PM, Clark Williams wrote:
> On Thu, 12 Aug 2021 22:45:19 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 8/12/21 10:18 PM, Clark Williams wrote:
>>> On Tue, 10 Aug 2021 18:37:31 +0200
>>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>>
>>> Sebastian, et al,
>>>
>>> Got the following panic running v5.14-rc5-rt8:
>>>
>>> Aug 13 06:35:05 oberon kernel: page:000000009ac5dd73 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ab3db
>>> Aug 13 06:35:05 oberon kernel: flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>>> Aug 13 06:35:05 oberon kernel: raw: 0017ffffc0000000 ffffee1286aceb88 ffffee1287b66288 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: raw: 0000000000000000 0000000000100000 00000000ffffffff 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: page dumped because: VM_BUG_ON_PAGE(!PageSlab(page))
>>> Aug 13 06:35:05 oberon kernel: ------------[ cut here ]------------
>>> Aug 13 06:35:05 oberon kernel: kernel BUG at include/linux/page-flags.h:814!
>>> Aug 13 06:35:05 oberon kernel: invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
>>> Aug 13 06:35:05 oberon kernel: CPU: 3 PID: 12345 Comm: hackbench Not tainted 5.14.0-rc5-rt8+ #12
>>> Aug 13 06:35:05 oberon kernel: Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0359.2016.0906.1028 09/06/2016
>>> Aug 13 06:35:05 oberon kernel: RIP: 0010:___slab_alloc+0x340/0x940  
>>
>> Are you able to translate this RIP via addr2line?
> 
> $ addr2line -e /data/o/linux-5.14.y-rt/vmlinux ___slab_alloc+0x340/0x940
> <snip>/arch/x86/include/asm/processor.h:440

Hm that's not much useful, I'd need the line in mm/slub.c
does ./scripts/faddr2line give better output?

>>
>>> Aug 13 06:35:05 oberon kernel: Code: c6 48 0f a3 05 b1 7b 57 03 72 99 c7 85 78 ff ff ff ff ff ff ff 48 8b 7d 88 e9 8d fd ff ff 48 c7 c6 50 5a 7c b0 e>
>>> Aug 13 06:35:05 oberon kernel: RSP: 0018:ffffba1c4a8b7ab0 EFLAGS: 00010293
>>> Aug 13 06:35:05 oberon kernel: RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9bb765118000
>>> Aug 13 06:35:05 oberon kernel: RDX: 0000000000000000 RSI: ffffffffaf426050 RDI: 00000000ffffffff
>>> Aug 13 06:35:05 oberon kernel: RBP: ffffba1c4a8b7b70 R08: 0000000000000000 R09: 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff9bb7410d3600
>>> Aug 13 06:35:05 oberon kernel: R13: 0000000000400cc0 R14: 00000000001f7770 R15: ffff9bbe76df7770
>>> Aug 13 06:35:05 oberon kernel: FS:  00007f474b1be740(0000) GS:ffff9bbe76c00000(0000) knlGS:0000000000000000
>>> Aug 13 06:35:05 oberon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Aug 13 06:35:05 oberon kernel: CR2: 00007f60c04bdaf8 CR3: 0000000124f3a003 CR4: 00000000003706e0
>>> Aug 13 06:35:05 oberon kernel: Call Trace:
>>> Aug 13 06:35:05 oberon kernel:  ? __alloc_skb+0x1db/0x270
>>> Aug 13 06:35:05 oberon kernel:  ? __alloc_skb+0x1db/0x270
>>> Aug 13 06:35:05 oberon kernel:  ? kmem_cache_alloc_node+0xa4/0x2b0
>>> Aug 13 06:35:05 oberon kernel:  kmem_cache_alloc_node+0xa4/0x2b0
>>> Aug 13 06:35:05 oberon kernel:  __alloc_skb+0x1db/0x270
>>> Aug 13 06:35:05 oberon kernel:  alloc_skb_with_frags+0x64/0x250
>>> Aug 13 06:35:05 oberon kernel:  sock_alloc_send_pskb+0x260/0x2b0
>>> Aug 13 06:35:05 oberon kernel:  ? bpf_lsm_socket_getpeersec_dgram+0xa/0x10
>>> Aug 13 06:35:05 oberon kernel:  unix_stream_sendmsg+0x27c/0x550
>>> Aug 13 06:35:05 oberon kernel:  ? unix_seqpacket_recvmsg+0x60/0x60
>>> Aug 13 06:35:05 oberon kernel:  sock_sendmsg+0xbd/0xd0
>>> Aug 13 06:35:05 oberon kernel:  sock_write_iter+0xb9/0x120
>>> Aug 13 06:35:05 oberon kernel:  new_sync_write+0x175/0x200
>>> Aug 13 06:35:05 oberon kernel:  vfs_write+0x3c4/0x510
>>> Aug 13 06:35:05 oberon kernel:  ksys_write+0xc9/0x110
>>> Aug 13 06:35:05 oberon kernel:  do_syscall_64+0x3b/0x90
>>> Aug 13 06:35:05 oberon kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae  
>>
>> While SLUB RT rewrite is obvious suspect, could be also a boring slab
>> misuse (use-after-free etc), wouldn't be the first related to skb's...
>> If this reproduces well, could you try booting with slub_debug boot
>> param. Could catch the culprit sooner (but also hide the bug,
>> unfortunately).
> 
> Without 'slub_debug' it panic's consistently. 
> 
> Adding 'slub_debug' to the boot command line causes odd behavior where load and measurement tasks
> run by 'rteval' crash, but (so far) no kernel panic. 

Huh. And nothing in dmesg about corrupted slabs with slub_debug?

>>> Aug 13 06:35:05 oberon kernel: RIP: 0033:0x7f474b3a2877
>>> Aug 13 06:35:05 oberon kernel: Code: 75 05 48 83 c4 58 c3 e8 37 4e ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 0>
>>> Aug 13 06:35:05 oberon kernel: RSP: 002b:00007ffe5e71e7a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> Aug 13 06:35:05 oberon kernel: RAX: ffffffffffffffda RBX: 00000000000003e8 RCX: 00007f474b3a2877
>>> Aug 13 06:35:05 oberon kernel: RDX: 00000000000003e8 RSI: 00007ffe5e71e7b0 RDI: 0000000000000010
>>> Aug 13 06:35:05 oberon kernel: RBP: 00007ffe5e71ebf0 R08: 00007ffe5e71e700 R09: 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffe5e71e7b0
>>> Aug 13 06:35:05 oberon kernel: R13: 0000000000000008 R14: 0000560b46008210 R15: 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tf>
>>> Aug 13 06:35:05 oberon kernel:  snd_intel_dspcfg snd_hda_codec mei_hdcp snd_hda_core snd_hwdep cfg80211 snd_seq iTCO_wdt snd_seq_device intel_pmc_bxt>
>>> Aug 13 06:35:05 oberon kernel: ---[ end trace 0000000000000002 ]---
>>> Aug 13 06:35:05 oberon kernel: RIP: 0010:___slab_alloc+0x340/0x940
>>> Aug 13 06:35:05 oberon kernel: Code: c6 48 0f a3 05 b1 7b 57 03 72 99 c7 85 78 ff ff ff ff ff ff ff 48 8b 7d 88 e9 8d fd ff ff 48 c7 c6 50 5a 7c b0 e>
>>> Aug 13 06:35:05 oberon kernel: RSP: 0018:ffffba1c4a8b7ab0 EFLAGS: 00010293
>>> Aug 13 06:35:05 oberon kernel: RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9bb765118000
>>> Aug 13 06:35:05 oberon kernel: RDX: 0000000000000000 RSI: ffffffffaf426050 RDI: 00000000ffffffff
>>> Aug 13 06:35:05 oberon kernel: RBP: ffffba1c4a8b7b70 R08: 0000000000000000 R09: 0000000000000000
>>> Aug 13 06:35:05 oberon kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff9bb7410d3600
>>> Aug 13 06:35:05 oberon kernel: R13: 0000000000400cc0 R14: 00000000001f7770 R15: ffff9bbe76df7770
>>> Aug 13 06:35:05 oberon kernel: FS:  00007f474b1be740(0000) GS:ffff9bbe76c00000(0000) knlGS:0000000000000000
>>> Aug 13 06:35:05 oberon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Aug 13 06:35:05 oberon kernel: CR2: 00007f60c1d901a0 CR3: 0000000124f3a003 CR4: 00000000003706e0
>>> Aug 13 06:35:05 oberon kernel: Kernel panic - not syncing:
>>>
>>> Config is attached. 
>>>
>>> I was running the rteval script that kicks off parallel kernel builds and hackbench runs as loads and runs cyclictest with a thread on each core:
>>>
>>> $ sudo rteval --duration=10m
>>>
>>> Clark
>>>   
>>
> 
> 

