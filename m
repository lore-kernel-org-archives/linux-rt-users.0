Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A32DC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EF760F39
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDQm2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230058AbhKDQm1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636043989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtWxj5bVWIRUkIdmlTWUpr8g05fwqa8qk6FC6Lvym2I=;
        b=RjpImdNfD1xOfH5tt3Td5HBruAvRSrzPKe486cDGDIZvl9SQxvqJB1qVZeyYOpEsOrEPWB
        XOeI686T3ogUOQwiMyDnp96OiwYhTKtRxThehjXPT2tQfPw7YaLew+3ppktHKnnrXtsglX
        34Wr+Mg5Y+g5fD405Et7as3bt2zgQ3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-gduqOEPsMRWWarlfcsFYFw-1; Thu, 04 Nov 2021 12:39:48 -0400
X-MC-Unique: gduqOEPsMRWWarlfcsFYFw-1
Received: by mail-wr1-f72.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso1201819wrq.16
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2021 09:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WtWxj5bVWIRUkIdmlTWUpr8g05fwqa8qk6FC6Lvym2I=;
        b=ksoo39gwy7q0I7ClqUlA8+g3UTxZ2IccUMc3NW21VA4T0Mi7sraaWv5t9n/+cBwTR6
         w5A8rQ4pHnoXqzTf0InMFZc066IXgoShcCpBWDJv7CDnDZR9PNrnZA3RW1cIqwj19o3p
         DMXLzvjOoZ+gog0sePeIzVhp11ipVfd48qVFFsrYSFQBcBIFK/j07BUQuZAjPjdtIzAY
         UNNtZ3LDqB0w5QN0uDlHF072TpUBymzzQeG5CkE8BSV0+ajhpj+Z9meQ57ii9QmOMPxF
         ad0X2liEJuw4Z0VmGXO6750VBjQ06ylZh17h3Dnyv0DoG0DLC7HkU/oYY8Z+b6dn4XAO
         geOQ==
X-Gm-Message-State: AOAM532mi3aDbZdpeyoSu+QYtL6wuN5GouDH7iqqjhpgiHfK4Ej2n8YY
        3r+MwhtkUVKLIGheWjKFyMDnp/wywPboYZ6PKVeZ3V8D943jCsoOF4JCIbXtA3JhrgtdGtYTqzE
        uEsCiT0rODtSikNKGB0rWfX/Pv8U=
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr24191256wmn.190.1636043985917;
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIH+cjej3i1dltEBRmTsfN3a+98KZkYrNCWjyE5e0C19BkFlHpqTrypOIBu2BPOpHV6iXeUQ==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr24191228wmn.190.1636043985650;
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id u16sm8594883wmc.21.2021.11.04.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:39:45 -0700 (PDT)
Message-ID: <3190fc080138108c189626e22676aaae80b72414.camel@redhat.com>
Subject: Re: [mm/page_alloc]  5541e53659: BUG:spinlock_bad_magic_on_CPU
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com
Date:   Thu, 04 Nov 2021 17:39:44 +0100
In-Reply-To: <20211104143809.GB6499@xsang-OptiPlex-9020>
References: <20211104143809.GB6499@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (3.42.0-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-11-04 at 22:38 +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 5541e5365954069e4c7b649831c0e41bc9e5e081 ("[PATCH v2 2/3] mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin locks")
> url: https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/mm-page_alloc-Remote-per-cpu-page-list-drain-support/20211104-010825
> base: https://github.com/hnaz/linux-mm master
> patch link: https://lore.kernel.org/lkml/20211103170512.2745765-3-nsaenzju@redhat.com
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------+------------+------------+
> >                                            | 69c421f2b4 | 5541e53659 |
> +--------------------------------------------+------------+------------+
> > boot_successes                             | 11         | 0          |
> > boot_failures                              | 0          | 11         |
> > BUG:spinlock_bad_magic_on_CPU              | 0          | 11         |
> > BUG:using_smp_processor_id()in_preemptible | 0          | 11         |
> +--------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    0.161872][    T0] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.162248][    T0]  lock: 0xeb24bef0, .magic: 00000000, .owner: swapper/0, .owner_cpu: 0
> [    0.162767][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc7-mm1-00437-g5541e5365954 #1
> [    0.163325][    T0] Call Trace:
> [ 0.163524][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> [ 0.163802][ T0] dump_stack (lib/dump_stack.c:114) 
> [ 0.164050][ T0] spin_bug (kernel/locking/spinlock_debug.c:70 kernel/locking/spinlock_debug.c:77) 
> [ 0.164296][ T0] do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
> [ 0.164624][ T0] _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:194) 
> [ 0.164971][ T0] free_unref_page (include/linux/spinlock.h:423 mm/page_alloc.c:3400) 
> [ 0.165253][ T0] free_the_page (mm/page_alloc.c:699) 
> [ 0.165521][ T0] __free_pages (mm/page_alloc.c:5453) 
> [ 0.165785][ T0] add_highpages_with_active_regions (include/linux/mm.h:2511 arch/x86/mm/init_32.c:416) 
> [ 0.166179][ T0] set_highmem_pages_init (arch/x86/mm/highmem_32.c:30) 
> [ 0.166501][ T0] mem_init (arch/x86/mm/init_32.c:749 (discriminator 2)) 
> [ 0.166749][ T0] start_kernel (init/main.c:842 init/main.c:988) 
> [ 0.167026][ T0] ? early_idt_handler_common (arch/x86/kernel/head_32.S:417) 
> [ 0.167369][ T0] i386_start_kernel (arch/x86/kernel/head32.c:57) 
> [ 0.167662][ T0] startup_32_smp (arch/x86/kernel/head_32.S:328) 

I did test this with lock debugging enabled, but I somehow missed this stack
trace. Here's the fix:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7dbdab100461..c8964e28aa59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6853,6 +6853,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
        pcp->high = BOOT_PAGESET_HIGH;
        pcp->batch = BOOT_PAGESET_BATCH;
        pcp->free_factor = 0;
+       spin_lock_init(&pcp->lock);
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
@@ -6902,7 +6903,6 @@ void __meminit setup_zone_pageset(struct zone *zone)
                struct per_cpu_zonestat *pzstats;
 
                pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-               spin_lock_init(&pcp->lock);
                pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
                per_cpu_pages_init(pcp, pzstats);
        }

-- 
Nicolás Sáenz

