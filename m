Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF70C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 18:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJFSAV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFSAT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 14:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987953CBEB
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665079216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBt3sW+7/6rjizIQv+AufkXX5YwsPMWw7lO8n9Us288=;
        b=h+OUArMvbD9DzfZyoFZZLG0i28OQcozuvuLCOJFRUXKKg9tg+3mYtR4dpsGinacheqA5sv
        m6fDHFyWT3ZnqWQ+w1dUQX7yQ7OXQvzRGkKMvSgF5C+hiLa4jx9iw1Uya/xvAqqGFsRbaP
        J/wb4J+aY6B1bmxdq2O0CvqGC+SS2r8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-tAV2-6SVP56QzlHFAXLfOQ-1; Thu, 06 Oct 2022 14:00:15 -0400
X-MC-Unique: tAV2-6SVP56QzlHFAXLfOQ-1
Received: by mail-lf1-f71.google.com with SMTP id 13-20020ac2484d000000b004a22f42201eso882598lfy.17
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Oct 2022 11:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBt3sW+7/6rjizIQv+AufkXX5YwsPMWw7lO8n9Us288=;
        b=zj6O7neuDoDDgAdmK7NCtbSRZMgAemzNGo9yewQ/giTOpmYJgpbA/RCEEV+XKdOSG3
         by6S2FfvM85xhNwxUMNQrn5xaS/ynPns3O/QC6SI5EcpUVU9FV0TNwB8BCVMgFL6BPFz
         /mVP6Lnt47XD+zltCouUKpWzb8R7xpqR0WoAptzleNb6cPXALIJAIs4KrFWSU5PWA8zX
         emvbTIhWAUwe23Qv8w6LqdRlACp5bBr6i5Gyv4bETiewsGeHCo45MiaOcPMlu9xIkCUt
         sYLzWxg8P3g3Cgvrt+Ngvvgm0Kel84mNC96mbLG+ugOlrj1n/iXcvsHtvmX4oyMJG/il
         ihAA==
X-Gm-Message-State: ACrzQf0VXszikGkLTi9dBLPM/alfafozHrytPQJMDHFf9cMSS2p8eS52
        gfToSoFUQ9x/4UYGSQA1K/7NA+zYPuvr7bzg/c3Xldd++OGE8W0dUqTs4EURrlsTbz2U47xV2J4
        WCPMsEyVA788IiAFahE5M/SNY87TtYHksBT2dkmYiqaE=
X-Received: by 2002:a05:6512:3f8b:b0:492:d1ed:5587 with SMTP id x11-20020a0565123f8b00b00492d1ed5587mr458149lfa.355.1665079214165;
        Thu, 06 Oct 2022 11:00:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM629h5qHybvxCYyZoGMID+GGze33Hw2Y1nYZ8wfY7vXchfjt7igWChEozoJ7PL9dVYjUClRLpQuShn6Yy3VvYQ=
X-Received: by 2002:a05:6512:3f8b:b0:492:d1ed:5587 with SMTP id
 x11-20020a0565123f8b00b00492d1ed5587mr458138lfa.355.1665079213894; Thu, 06
 Oct 2022 11:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEYdEeSpYW3wS=yXtsa9C0e-LmZDXNZ=AP3z33FYZKsgU7XcxQ@mail.gmail.com>
 <20221003201010.bebxyq7blirp5kfs@halaney-x13s> <CAEYdEeTdT0T6qmn+b4xG2o4g3OYHApbw4wSXP5a-7YBQ8YCu+A@mail.gmail.com>
 <CAMLffL-8_aqTr1GTR=oTjFRXXMg2g3UgvJrpQPfJ7uBcVcj8Rg@mail.gmail.com> <CAEYdEeRB+SLwQz9WzXN+rmQCC0hPAX6GU0TOSqm_tF6yJ1expA@mail.gmail.com>
In-Reply-To: <CAEYdEeRB+SLwQz9WzXN+rmQCC0hPAX6GU0TOSqm_tF6yJ1expA@mail.gmail.com>
From:   Clark Williams <williams@redhat.com>
Date:   Thu, 6 Oct 2022 18:00:02 +0000
Message-ID: <CAMLffL-GVGVa7fZOrjacmpK2k1uAaG_Ca8UTm_LqKMWm3utM-g@mail.gmail.com>
Subject: Re: Abort on boot for 5.15.7 patch RT 23
To:     Brian Wrenn <dcbrianw@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, athierry@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

yeah, the 5.0 - 5.9 time-frame was when Thomas and Sebastian were only
updating on the even numbered release. From 5.9 onward there were
corresponding RT releases with each kernel release.  So unfortunately
for you, no 5.7 PREEMPT_RT series.

You might try working your way forward, trying to apply your patches
onto the last 5.9-rt series.  working forwards to see if you get a
behavior change on boot.

Not sure what else to recommend at this point. Maybe yell for help from Linaro?

Clark

On Thu, Oct 6, 2022 at 4:58 PM Brian Wrenn <dcbrianw@gmail.com> wrote:
>
> Hi Clark,
>
> first, thank you and Andrew both for your help.  I first attempted to
> patch Linaro's 5.15.7 kernel with rt51, but some of the hunks failed.
> Next, I attempted to patch the Linaro's kernel based on 5.15.54 with
> rt51.  That boots the devboard, albeit with some system errors.  I'm
> constrained to the set of kernels Linaro releases since I'm building
> for the Snapdragon 410.  Booting the 5.15.54 with rt51 and Andrew's
> config change behaved similarly to booting 5.15.7 with rt23 and
> Andrew's config change.  At that stage, I can issue basic bash
> commands, but I don't have access to all the hardware features of the
> devboard.  Long story short, I'm trying to manually patch a Linaro
> kernel with Variscite-based customizations since I'm running Variscite
> hardware, and this involves some guesswork.  For the moment, I suspect
> my problems lie in the Variscite patching I've attempted to do myself.
> As for why I'm doing this, Variscite has only released kernels with
> their patches up to 5.7.0 and 4.14.0 prior to that.  Despite
> PREEMPT-RT supporting many Linux kernels, I didn't find one for Linux
> 5.7.0.
>
> Thank you again, and if I find more in pursuit of this topic, I will
> follow-up here.
>
> -Brian
>
> On Tue, Oct 4, 2022 at 3:04 PM Clark Williams <williams@redhat.com> wrote:
> >
> > I was going to tell you that I'd successfully booted and run
> > 5.15.7-rt23 on my Honeycomb board, but after talking with Andrew
> > realized that I wasn't going through the same code paths on boot
> > (Honeycomb is uefi/acpi, your board is DT). Glad Andrew's suggestion
> > works for you.
> >
> > I might suggest you taking the changes built on top of 5.15.7-rt23 and
> > try rebasing them onto the head of the v5.15-rt stable tree, which
> > should be v5.15.71-rt51.  Lots of fixes available there
> >
> > Clark
> >
> > On Tue, Oct 4, 2022 at 4:00 PM Brian Wrenn <dcbrianw@gmail.com> wrote:
> > >
> > > Hi Andrew,
> > >
> > > thank you for the suggestion.  I tried that.  The devboard boots into
> > > the PREEMPT-RT kernel.  I've still got some other problems to resolve,
> > > but those seem to be rooted elsewhere.
> > >
> > > -Brian
> > >
> > > On Mon, Oct 3, 2022 at 4:10 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> > > >
> > > > Hey Brian,
> > > >
> > > > On Fri, Sep 30, 2022 at 11:43:11AM -0400, Brian Wrenn wrote:
> > > > > Hi,
> > > > >
> > > > > I am building a kernel from source derived from Linaro 21.12, based on
> > > > > linux kernel 5.15.7.  It runs on a Variscite DART SD410 dev board.
> > > > > When I build that kernel, it will boots successfully.  When I build
> > > > > the same kernel source with the PREEMPT-RT patch, it aborts during
> > > > > boot.  I attached console output for each case.
> > > > >
> > > > > An incompatibility between the Variscite patches and PREEMPT-RT could
> > > > > cause this abort, but just to cover all my bases, I'm try to rule out
> > > > > the PREEMPT-RT patch itself.
> > > > >
> > > > > The call trace includes RT specific routines, so I'm wondering if
> > > > > there are any known problems with routines in this call state, and if
> > > > > any fix for them exists in some way applicable to the v23 patch.
> > > >
> > > > I've seen these backtraces before, but unfortunately don't have a proper
> > > > fix to point you to.
> > > >
> > > > > Format: Log Type - Time(microsec) - Message - Optional Info
> > > > > Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> > > > > S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.0-00288
> > > > > S - IMAGE_VARIANT_STRING=HAAAANAZA
> > > > > S - OEM_IMAGE_VERSION_STRING=CRM
> > > > > S - Boot Config, 0x000002e3
> > > > <snip>..
> > > > > [    0.882843] BUG: scheduling while atomic: swapper/2/0/0x00000002
> > > > > [    0.882858] Modules linked in:
> > > > > [    0.882867] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.15.7-qcomlt-arm64 #3
> > > > > [    0.882876] Hardware name: Variscite LTD. VAR-DART410 HDMI (DT)
> > > > > [    0.882881] Call trace:
> > > > > [    0.882883]  dump_backtrace+0x0/0x1e8
> > > > > [    0.882902]  show_stack+0x18/0x28
> > > > > [    0.882911]  dump_stack_lvl+0x68/0x84
> > > > > [    0.882922]  dump_stack+0x18/0x34
> > > > > [    0.882941]  __schedule_bug+0x54/0x78
> > > > > [    0.882958]  __schedule+0x730/0x838
> > > > > [    0.882972]  schedule_rtlock+0x28/0x58
> > > > > [    0.882986]  rtlock_slowlock_locked+0x228/0xcc8
> > > > > [    0.882998]  rt_spin_lock+0x7c/0xa8
> > > > > [    0.883013]  genpd_lock_nested_spin+0x1c/0x30
> > > > > [    0.883030]  genpd_power_off+0x18c/0x278
> > > > > [    0.883045]  genpd_runtime_suspend+0x1ec/0x300
> > > > > [    0.883062]  __rpm_callback+0x44/0x130
> > > > > [    0.883077]  rpm_callback+0x6c/0x78
> > > > > [    0.883094]  rpm_suspend+0xdc/0x470
> > > > > [    0.883105]  __pm_runtime_suspend+0x5c/0xa8
> > > > > [    0.883121]  __psci_enter_domain_idle_state.isra.5+0x54/0xe0
> > > > > [    0.883139]  psci_enter_domain_idle_state+0x18/0x28
> > > > > [    0.883153]  cpuidle_enter_state+0x25c/0x300
> > > > > [    0.883170]  cpuidle_enter+0x3c/0x58
> > > > > [    0.883179]  call_cpuidle+0x30/0x58
> > > > > [    0.883188]  do_idle+0x248/0x2a0
> > > > > [    0.883195]  cpu_startup_entry+0x24/0x70
> > > > > [    0.883203]  secondary_start_kernel+0x1b8/0x1e8
> > > > > [    0.883212]  __secondary_switched+0x90/0x94
> > > > > [    0.883227] bad: scheduling from the idle thread!
> > > > > [    0.883231] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         5.15.7-qcomlt-arm64 #3
> > > > > [    0.883239] Hardware name: Variscite LTD. VAR-DART410 HDMI (DT)
> > > > > [    0.883243] Call trace:
> > > > > [    0.883244]  dump_backtrace+0x0/0x1e8
> > > > > [    0.883254]  show_stack+0x18/0x28
> > > > > [    0.883262]  dump_stack_lvl+0x68/0x84
> > > > > [    0.883272]  dump_stack+0x18/0x34
> > > > > [    0.883281]  dequeue_task_idle+0x30/0x60
> > > > > [    0.883290]  __do_set_cpus_allowed+0x108/0x1e0
> > > > > [    0.883299]  __schedule+0x778/0x838
> > > > > [    0.883305]  schedule_rtlock+0x28/0x58
> > > > > [    0.883311]  rtlock_slowlock_locked+0x228/0xcc8
> > > > > [    0.883319]  rt_spin_lock+0x7c/0xa8
> > > > > [    0.883326]  genpd_lock_nested_spin+0x1c/0x30
> > > > > [    0.883333]  genpd_power_off+0x18c/0x278
> > > > > [    0.883340]  genpd_runtime_suspend+0x1ec/0x300
> > > > > [    0.883348]  __rpm_callback+0x44/0x130
> > > > > [    0.883357]  rpm_callback+0x6c/0x78
> > > > > [    0.883364]  rpm_suspend+0xdc/0x470
> > > > > [    0.883371]  __pm_runtime_suspend+0x5c/0xa8
> > > > > [    0.883379]  __psci_enter_domain_idle_state.isra.5+0x54/0xe0
> > > > > [    0.883388]  psci_enter_domain_idle_state+0x18/0x28
> > > > > [    0.883395]  cpuidle_enter_state+0x25c/0x300
> > > > > [    0.883401]  cpuidle_enter+0x3c/0x58
> > > > > [    0.883408]  call_cpuidle+0x30/0x58
> > > > > [    0.883420]  do_idle+0x248/0x2a0
> > > > > [    0.883437]  cpu_startup_entry+0x24/0x70
> > > > > [    0.883449]  secondary_start_kernel+0x1b8/0x1e8
> > > > > [    0.883458]  __secondary_switched+0x90/0x94
> > > > > [    0.883470] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > > > > [    0.883475] Mem abort info:
> > > > > [    0.883476]   ESR = 0x86000006
> > > > > [    0.883480]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > > > [    0.883484]   SET = 0, FnV = 0
> > > > > [    0.883487]   EA = 0, S1PTW = 0
> > > > > [    0.883490]   FSC = 0x06: level 2 translation fault
> > > > > [    0.883494] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000084c5b000
> > > > > [    0.883499] [0000000000000000] pgd=080000008547a003, p4d=080000008547a003, pud=080000008547b003, pmd=0000000000000000
> > > > > [    0.883513] Internal error: Oops: 86000006 [#1] PREEMPT_RT SMP
> > > > > [    0.883518] Modules linked in:
> > > > > [    0.883523] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         5.15.7-qcomlt-arm64 #3
> > > > > [    0.883530] Hardware name: Variscite LTD. VAR-DART410 HDMI (DT)
> > > > > [    0.883534] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > [    0.883542] pc : 0x0
> > > > > [    0.883547] lr : __do_set_cpus_allowed+0x140/0x1e0
> > > > > [    0.883558] sp : ffff800012573930
> > > > > [    0.883560] x29: ffff800012573930 x28: ffff00000322d588 x27: 0080000000000000
> > > > > [    0.883571] x26: ffff8000124bb000 x25: ffff000002960670 x24: ffff800011116528
> > > > > [    0.883581] x23: ffff80001113ae50 x22: 0000000000000002 x21: ffff000002960000
> > > > > [    0.883591] x20: ffff000002a10000 x19: ffff00003fc91580 x18: ffffffffffffffff
> > > > > [    0.883601] x17: 000000040044ffff x16: 00400032b5503510 x15: ffff8000119b0ea8
> > > > > [    0.883611] x14: 0000000000000000 x13: ffff80001257335c x12: 656c646920656874
> > > > > [    0.883621] x11: ffff800012573260 x10: 000000000000000a x9 : 00000000ffffffd0
> > > > > [    0.883631] x8 : 000000000000000a x7 : 000000000000001e x6 : ffff8000121cbfb8
> > > > > [    0.883641] x5 : ffff000002960a28 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > [    0.883650] x2 : 000000000000000a x1 : ffff000002960000 x0 : ffff00003fc91580
> > > > > [    0.883661] Call trace:
> > > > > [    0.883663]  0x0
> > > > > [    0.883668]  __schedule+0x778/0x838
> > > > > [    0.883676]  schedule_rtlock+0x28/0x58
> > > > > [    0.883685]  rtlock_slowlock_locked+0x228/0xcc8
> > > > > [    0.883693]  rt_spin_lock+0x7c/0xa8
> > > > > [    0.883706]  genpd_lock_nested_spin+0x1c/0x30
> > > > > [    0.883721]  genpd_power_off+0x18c/0x278
> > > > > [    0.883729]  genpd_runtime_suspend+0x1ec/0x300
> > > > > [    0.883736]  __rpm_callback+0x44/0x130
> > > > > [    0.883744]  rpm_callback+0x6c/0x78
> > > > > [    0.883751]  rpm_suspend+0xdc/0x470
> > > > > [    0.883759]  __pm_runtime_suspend+0x5c/0xa8
> > > > > [    0.883766]  __psci_enter_domain_idle_state.isra.5+0x54/0xe0
> > > > > [    0.883775]  psci_enter_domain_idle_state+0x18/0x28
> > > > > [    0.883783]  cpuidle_enter_state+0x25c/0x300
> > > > > [    0.883789]  cpuidle_enter+0x3c/0x58
> > > > > [    0.883795]  call_cpuidle+0x30/0x58
> > > > > [    0.883804]  do_idle+0x248/0x2a0
> > > > > [    0.883812]  cpu_startup_entry+0x24/0x70
> > > > > [    0.883820]  secondary_start_kernel+0x1b8/0x1e8
> > > > > [    0.883828]  __secondary_switched+0x90/0x94
> > > > > [    0.883843] Code: bad PC value
> > > > > [    0.883850] ---[ end trace 0000000000000002 ]---
> > > >
> > > > Here's where Adrien poked at it a little:
> > > >
> > > >     https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
> > > >
> > > > As a dirty workaround you could disable CONFIG_ARM_PSCI_CPUIDLE in your
> > > > config.
> > > >
> > > > Thanks,
> > > > Andrew
> > > >
> > >
> >
>

