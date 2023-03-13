Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5521C61DA4
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Mar 2023 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCMPLb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCMPL3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Mar 2023 11:11:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA96F626
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 08:11:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id ay18so7833213pfb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1678720276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fip+oK51E6igCNWfX0sBR/riAFi5CSyyNV880+IOiHo=;
        b=SPhETflslmMJEnKr8njfLHAiD8x9uqznQJv1kTO2bTOfQa81SKK/sW2WqHPNyZAxO7
         Ng3QIVM107wvTv7toSjSMwkAIQbpXaVpATtwfClBF2cfxNbvdUovcjy+JzlZFMorB28K
         XmdDir3MqxSX2gA7Adsre4I/jKH1OrImDhzZ/e06q60C0Uwwn7c5irPnnjJEqb+KTdFG
         al3o6bkOss45q3nWr0b7G++ZQqu7JwY3ahAn6d1tWf31/C7GShT7sYx43LbsS+b8JTZg
         fVNE9E7JfSAtspFg3saht++3w2QUYF6xUrKkFSSoQroZ2faYWy+BUJkhaSDl8+bJKwZS
         317w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fip+oK51E6igCNWfX0sBR/riAFi5CSyyNV880+IOiHo=;
        b=10TwFmpfkfWP9fGTK7AbtdV/GCbMz4egRSht+3O3mauOKF/x0cUBWb7tVMOxsFOwZf
         716zrXDCV7+0U+bIvDMqLo961PBYKf5aB1KDXYdfRtHU1DZhjT1FSH0YoBM1554/y2ir
         aszQlB/YrqEya4/P4qk4NvypqpFDsrVr/rLEDsfb7RC8D+2pCFTlyO5ENHtUwML48WOa
         s/2lud9+DcBhRdUIfdZR0ftERI/kPpDdGGP76cXt7OarC/7t0D9S6lHEYd9gPlItkaXq
         v5ijCcAHaWAgrELgVI1acj3LaXhZGhX7KYiM+OkmS3imQ7NkVBCmoGoJ8My/C84GPZnN
         ksxw==
X-Gm-Message-State: AO0yUKVZdigor1ZOPx118uh5ACxTYWkPHrI7QjZJIdQDwOjW4dCZE654
        lLvdm+Qi9GtfmUgUPkal3jDZNelny388XD7cTFINmA==
X-Google-Smtp-Source: AK7set/zYg3tfS8OU0FVwo2WZFdQuPpnmi+OSvQiuvQze5PEiAtfur+2bSMdAWwNsylBeGx7m3xJQoA5OwgXLCYAAVk=
X-Received: by 2002:a63:8c1d:0:b0:503:2535:44c3 with SMTP id
 m29-20020a638c1d000000b00503253544c3mr11656298pgd.4.1678720276124; Mon, 13
 Mar 2023 08:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
 <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com> <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
 <c4fe632e-568b-7c60-c6d2-99e0148680ad@canonical.com> <Y+5kz/DfgypT8Hsr@linutronix.de>
 <daaa77a0-5091-1c21-2d53-160220f27594@canonical.com>
In-Reply-To: <daaa77a0-5091-1c21-2d53-160220f27594@canonical.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Mon, 13 Mar 2023 08:11:05 -0700
Message-ID: <CAFzL-7sKDBRRoCBFsonhEVB2vhcZ8_GLkk1=se2-v41=GE9HUw@mail.gmail.com>
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, williams@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> On 2/16/23 12:15, Sebastian Andrzej Siewior wrote:
> > On 2023-01-18 13:52:21 [-0500], Joseph Salisbury wrote:
> >> I'll add more details to this thread as I continue.
> > Any update on this?
> > Does the system really hang? The dmesg says:
> > |[ 8235.110075] INFO: task stress-ng:9466 blocked for more than 122 sec=
onds.
> >
> > which means stress-ng is blocked for quite some time due to I/O
> > according to the backtrace. This appears once for each stress-ng
> > process, 10 times in total. It does not repeat and the system runs at
> > least until
> >
> > | [50733.471625] hid-generic 0003:03F0:7029.0004: input,hidraw1: USB HI=
D v1.10 Mouse [iLO Virtual Keyboard] on usb-0000:01:00.4-1/input1
> >
> > ~11h after that report.
> > Based on that it looks like the system complained about slow I/O but di=
d
> > not hang as it completed its task.
> >
> > Sebastian

On Fri, Mar 10, 2023 at 1:09=E2=80=AFPM Joseph Salisbury  wrote:
> A bisect has not provided additional detail. This issue does not appear
> to be a regression and appears to have always existed.
>
> I was able to get additional debug info, by enabling
> CONFIG_DEBUG_PREEMPT, CONFIG_PROVE_LOCKING and CONFIG_JBD2_DEBUG.
> Enabling these configs shows a circular locking issue[0] and a call
> trace[1].
>
> I don't think the circular locking report is related.  I think your
> correct that the system is not actually hanging.  The interactive
> response make it seem like it's hung.  For example, once the issue
> starts to happen, no other interactive commands can be issues without
> taking at least days (I never waiting more that 3 days :-) )  I'm also
> not able to log in or log out while the system "Appears" hung.  I was
> able to get a sysrq-W while the system was in this state[2].
>
> I think I may have starting investigating too deep at first (By
> bisecting and enabling trace, etc).  I stepped back and looked at the
> high level stats.  The stress-ng test is started with one process for
> each core, and there are 96 of them.  I looked at top[3] during a hang,
> and many of the stress-ng processes are running 'R'. However, a sysrq-q
> also shows many stress-ng processes are 'D' in uninterruptible sleep.
> What also sticks out to me is all the stress-ng processes are running as
> root with a priority of 20. Looking back at one of the call traces[1], I
> see jbd2 stuck in an uninterruptible state:
> ...
> [ 4461.908213] task:journal-offline state:D stack:    0 pid:17541
> ppid:     1 flags:0x00000226
> ...
>
>
> The jdb2 kernel thread also runs with a priority of 20[4].  When the
> hang happens, jbd2 is also stuck in an uninterruptible state(As well as
> systemd-journal):
> 1521 root      20   0       0      0      0 D   0.0   0.0   4:10.48
> jbd2/sda2-8
> 1593 root      19  -1   64692  15832  14512 D   0.0   0.1   0:01.54
> systemd-journal
>
>
>
> I don't yet know why running the test the same way for a generic kernel
> does not cause this behavior when it does for a preempt-rt kernel.
> Maybe it's a case of priority 'Sameness' and not priority inversion :-) ?
>
> I tried to pin all of the stress-ng threads to cores 1-95 and the kernel
> threads to a housekeeping cpu, 0. I recall though that there are certain
> kernel threads that need to run on every core and kworker is one of
> them.  Output from cmdline:
> "BOOT_IMAGE=3D/boot/vmlinuz-5.15.0-1033-realtime
> root=3DUUID=3D3583d8c4-d539-439f-9d50-4341675268cc ro console=3Dtty0
> console=3DttyS0,115200 skew_tick=3D1 isolcpus=3Dmanaged_irq,domain,1-95
> intel_pstate=3Ddisable nosoftlockup tsc=3Dnowatchdog
> crashkernel=3D0M-2G:128M,2G-6G:256M,6G-8G:512M,8G-:768M"
>
> However, even with this pinning, stress-ng ends up running on cpu 0, per
> the ps output[4].  This may be why it is interfering with jbd2.
>
> I'll see if I can modify the test to run as a non-root user or with a
> lower priority.  I could also try bumping the priority of jdb2. Maybe
> one of these would allow the journal to complete it's work and the test
> to finish?
>
> Could it be that that the system is not hung, it is just waiting to
> complete I/O, which will never happen since the jdb2 threads are stuck.
> In this case, this is not a bug, but a test that is not configured
> correctly for a real-time system.  Does that sound plausible?  If you
> think that is the case, I'll talk with the bug reporter and assist them
> with running the test properly for a real-time system.

Have you tried checking for low-memory during the test?   Maybe the
system is unable to write because of slow page-cache allocations (see
https://www.socallinuxexpo.org/sites/default/files/presentations/Exploring%=
20%20Linux%20Memory%20Usage%20and%20%20Disk%20IO%20performance%20version%20=
3.pdf)
or perhaps there is massive inter-NUMA-node rebalancing going on in
such a large system?      Turning on CONFIG_PSI is a relatively easy
way to monitor memory problems.   Also, have you tried connecting to
systemd-journald with GDB during the test, to see what it is doing?
Or tried calculating if the bandwidth to your storage devices is
simply maxed out?

-- Alison Chaiken
Aurora Innovation
achaiken@aurora.tech
