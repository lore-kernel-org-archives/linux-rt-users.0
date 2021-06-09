Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCABCC48BCD
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C772B610E6
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhFII7L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:59:11 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43647 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhFII7I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Jun 2021 04:59:08 -0400
Received: by mail-ej1-f49.google.com with SMTP id ci15so37240459ejc.10
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2021 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sBK6iHLaIk7YDa2a/TVUI/Jsjo74HhYb0cg2sJrJ1q8=;
        b=nMNNJNNZWiWr0jM68HeESwYtIDhhOhXHXR0JIJnNugPa/2FVQWMrhaikdUvR5EEOhU
         9wIk8MM6HesOwpQhHaDXjH9qGzGalCMwVrKn+NX2c+XuoZs6FM6KWQ0AtZjDT5c5Oxn9
         yUtPJWDjZFoVvlCUHAGDZjkM4+vHlM86dOF+3T6NUexKiJDaTTT9OiGANRX2NltLVi1D
         6yzPBgXyvG5DrWuzAivWbbq53fT2em5dqBVunfHbxfJVPMk9hwFl8hDf8aLHMG75Mrkz
         YJhZvt9YHWkhYAtBjk7Kd4CKFQNs8ASFeAAXDRLJgpaBOVwvVM7QyKnwTsIdFWJ1+8Xz
         mHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBK6iHLaIk7YDa2a/TVUI/Jsjo74HhYb0cg2sJrJ1q8=;
        b=oFDiQkv+PDZjEyftRxG9l/bENuNQZxT0o9C/Dxj7DufudaxSjkTJVnIgHtcwv+hSrW
         qWQV/XZPNF45AyEiPuE/ackn+Mtl/X+ipt4zCWF0ko7B31QJKfL3HVdXJyYzCJvy2NeC
         5yAWM4s4CnJDc04X4YD1iffThMt6fAmQYjXkHv0TxUhQ9BSlB66iLsBSE+F6OicmPN08
         tgKKP9oMsVgoPBIVpQ7j046Kbsvg44xtOFmkeQWe85lQZhjyUwtAE2CM2x4eFw8r4yhJ
         Qx8xdJHFVgexwAwthHIBRk7kCna8xc2WhVgWKpBIegP2Yhq0I0zogYYqzESNYr2OUZfi
         MZFw==
X-Gm-Message-State: AOAM530seHrvI9kPkQ0detl2YlSAbC6GkCYLzb/dIfYsn1ThEfqyw/ry
        xCMD4dccGA+jDmKJIQKzOCg9B6ixebdOVw==
X-Google-Smtp-Source: ABdhPJz+0PUBDBAnjAuB8p5wgMUi5+4pc149dk2Co201gEz0tVJ95/3B2F4vivSEoBI3G+Ap0OAXBA==
X-Received: by 2002:a17:906:546:: with SMTP id k6mr27422341eja.53.1623228960242;
        Wed, 09 Jun 2021 01:56:00 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-82-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.82])
        by smtp.gmail.com with ESMTPSA id s5sm851756edi.93.2021.06.09.01.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:55:59 -0700 (PDT)
Subject: Re: Hung task in 4.9 using kvm 5.2
To:     Luis Goncalves <lgoncalv@redhat.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
References: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
 <YL842Rg3yRcTpW2r@lx-t490>
 <CAD8J--9oKRQ2Fb9Q6Rtnfg21iU0NHYk-u8oVN-Rn=HqsEu93gQ@mail.gmail.com>
From:   Christoph Mathys <eraserix@gmail.com>
Message-ID: <b7b5a1d2-472c-5202-6b10-d1e8bcfcf58b@gmail.com>
Date:   Wed, 9 Jun 2021 10:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD8J--9oKRQ2Fb9Q6Rtnfg21iU0NHYk-u8oVN-Rn=HqsEu93gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Thanks for taking the time!

On 08.06.21 22:32, Luis Goncalves wrote:
> Along with Ahmed's suggestion, would you mind testing with v4.9.271-rt182?

Just tried with the new kernel and I'm still seeing the problem:

[ 3073.054260] INFO: task kvm:8538 blocked for more than 120 seconds.
[ 3073.054262]       Tainted: G     U          4.9.271-realtime-1-prove-rt182 #1
[ 3073.054262] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3073.054263] kvm             D    0  8538   6582 0x00000320
[ 3073.054266]  0000000000000086 ffff88087e468900 ffff8807b2d2d000 ffff88086c0b5000
[ 3073.054268]  000000000000464d ffff88087e468918 ffffc90015feba98 ffffffff8182c3f8
[ 3073.054269]  0000000015febb70 ffff8807b2d2d5f8 ffff88087e468918 ffff88087e468900
[ 3073.054271] Call Trace:
[ 3073.054275]  [<ffffffff8182c3f8>] ? __schedule+0x308/0x830
[ 3073.054277]  [<ffffffff8182c969>] schedule+0x49/0xd0
[ 3073.054278]  [<ffffffff8182e30c>] __rt_mutex_slowlock+0x4c/0x190
[ 3073.054279]  [<ffffffff8182e842>] rt_mutex_slowlock_locked+0xa2/0x290
[ 3073.054281]  [<ffffffff8182f42b>] __down_read+0x7b/0xb0
[ 3073.054282]  [<ffffffff8182e030>] down_read+0x40/0x50
[ 3073.054284]  [<ffffffff81288cd0>] ? ext4_direct_IO+0x2e0/0xa40
[ 3073.054286]  [<ffffffff81288cd0>] ext4_direct_IO+0x2e0/0xa40
[ 3073.054288]  [<ffffffff81174319>] generic_file_read_iter+0x3c9/0x7a0
[ 3073.054290]  [<ffffffff810b69b1>] ? __lock_acquire+0x291/0x1760
[ 3073.054291]  [<ffffffff8123de9e>] aio_read+0xbe/0x140
[ 3073.054293]  [<ffffffff8120a888>] ? __fget+0x118/0x1e0
[ 3073.054294]  [<ffffffff8120a775>] ? __fget+0x5/0x1e0
[ 3073.054295]  [<ffffffff8120a9ba>] ? __fdget+0x2a/0x70
[ 3073.054296]  [<ffffffff8123f6c2>] do_io_submit+0x602/0x680
[ 3073.054297]  [<ffffffff8123f247>] ? do_io_submit+0x187/0x680
[ 3073.054298]  [<ffffffff8123f750>] SyS_io_submit+0x10/0x20
[ 3073.054300]  [<ffffffff81001e0b>] do_syscall_64+0x7b/0x160
[ 3073.054301]  [<ffffffff81831943>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
[ 3073.054302]
                Showing all locks held in the system:
[ 3073.054307] 2 locks held by khungtaskd/89:
[ 3073.054307]  #0:  (rcu_read_lock){......}, at: [<ffffffff81127d56>] watchdog+0xb6/0x5b0
[ 3073.054311]  #1:  (tasklist_lock){+.+...}, at: [<ffffffff817ff716>] debug_show_all_locks+0x48/0x161
[ 3073.054322] 1 lock held by in:imklog/839:
[ 3073.054323]  #0:  (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8120bc04>] __fdget_pos+0xa4/0xb0
[ 3073.054345] 1 lock held by in:imklog/6776:
[ 3073.054346]  #0:  (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8120bc04>] __fdget_pos+0xa4/0xb0
[ 3073.054351] 1 lock held by dmesg/8264:
[ 3073.054351]  #0:  (&user->lock){+.+.+.}, at: [<ffffffff810c530b>] devkmsg_read+0x3b/0x2b0
[ 3073.054354] 1 lock held by kvm/8538:
[ 3073.054355]  #0:  (&sb->s_type->i_mutex_key#11){++++++}, at: [<ffffffff81288cd0>] ext4_direct_IO+0x2e0/0xa40
[ 3073.054359] 2 locks held by worker/8909:
[ 3073.054359]  #0:  (sb_writers#7){.+.+.+}, at: [<ffffffff811e31cf>] vfs_fallocate+0x13f/0x250
[ 3073.054362]  #1:  (&sb->s_type->i_mutex_key#11){++++++}, at: [<ffffffff812b93cb>] ext4_fallocate+0x43b/0xe00

[ 3073.054366] =============================================

[ 3073.054367] INFO: task worker:8909 blocked for more than 120 seconds.
[ 3073.054368]       Tainted: G     U          4.9.271-realtime-1-prove-rt182 #1
[ 3073.054368] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3073.054369] worker          D    0  8909   6582 0x00000320
[ 3073.054370]  0000000000000082 ffff88087e368900 ffff8807bbb95000 ffff88086c0b0000
[ 3073.054372]  0000000000007417 ffff88087e368918 ffffc9001a62fda0 ffffffff8182c3f8
[ 3073.054374]  0000000081e0b810 ffff8807bbb955f8 ffff88087e368918 ffff88087e368900
[ 3073.054375] Call Trace:
[ 3073.054377]  [<ffffffff8182c3f8>] ? __schedule+0x308/0x830
[ 3073.054378]  [<ffffffff8182c969>] schedule+0x49/0xd0
[ 3073.054379]  [<ffffffff81207457>] inode_dio_wait+0xa7/0xd0
[ 3073.054380]  [<ffffffff810ad450>] ? wake_up_atomic_t+0x90/0x90
[ 3073.054382]  [<ffffffff812b9410>] ext4_fallocate+0x480/0xe00
[ 3073.054383]  [<ffffffff811e31eb>] vfs_fallocate+0x15b/0x250
[ 3073.054384]  [<ffffffff811e4444>] SyS_fallocate+0x44/0x70
[ 3073.054385]  [<ffffffff81001e0b>] do_syscall_64+0x7b/0x160
[ 3073.054386]  [<ffffffff81831943>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
[ 3073.054387]
                Showing all locks held in the system:
[ 3073.054389] 2 locks held by khungtaskd/89:
[ 3073.054390]  #0:  (rcu_read_lock){......}, at: [<ffffffff81127d56>] watchdog+0xb6/0x5b0
[ 3073.054392]  #1:  (tasklist_lock){+.+...}, at: [<ffffffff817ff716>] debug_show_all_locks+0x48/0x161
[ 3073.054398] 1 lock held by in:imklog/839:
[ 3073.054399]  #0:  (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8120bc04>] __fdget_pos+0xa4/0xb0
[ 3073.054415] 1 lock held by in:imklog/6776:
[ 3073.054415]  #0:  (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8120bc04>] __fdget_pos+0xa4/0xb0
[ 3073.054419] 1 lock held by dmesg/8264:
[ 3073.054419]  #0:  (&user->lock){+.+.+.}, at: [<ffffffff810c530b>] devkmsg_read+0x3b/0x2b0
[ 3073.054422] 1 lock held by kvm/8538:
[ 3073.054422]  #0:  (&sb->s_type->i_mutex_key#11){++++++}, at: [<ffffffff81288cd0>] ext4_direct_IO+0x2e0/0xa40
[ 3073.054425] 2 locks held by worker/8909:
[ 3073.054426]  #0:  (sb_writers#7){.+.+.+}, at: [<ffffffff811e31cf>] vfs_fallocate+0x13f/0x250
[ 3073.054428]  #1:  (&sb->s_type->i_mutex_key#11){++++++}, at: [<ffffffff812b93cb>] ext4_fallocate+0x43b/0xe00

[ 3073.054432] =============================================

> Also, is there any extra step to reproduce this problem or simply
> firing up a VM is enough to trigger the problem?

We are still trying to find a simple setup that triggers the
problem, but no luck so far. It seems to happen when a lot
of disk IO happens in the guest OS, but only with Windows.

It is a Windows 7 guest running inside kvm running inside a
Debian 11 Bullseye LXD container. The same test runs fine
inside a Debian 8 Jessie LXD container. I can provide the
kvm "cmdline" if this is any help...

Christoph
