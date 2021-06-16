Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D2CC48BE6
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9D560FEE
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 07:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFPHTb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhFPHTb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 03:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623827845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kxGE2L7b0S1BOFAfdffIsHID0G8yx+5uEH+ORuy77bY=;
        b=btBOJjIjMlcjzIg6ZHjaLEOoD+SmWZ9cLUfDB9xdDUG8kzTQqa7ciRrnEAMtIlQR03cnXP
        9cjKDp3zjUB77JFl0c+KvKjzAbt0P7KtvQYNfpKcoj4bPUNJkhjfn04ZjWT9ZHSQrSQkyJ
        cz8Wk8BGLmEcbkZ+HwnvySf7Z6g2/Jw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-zhx1YMOCOqm1cij1VLfmnw-1; Wed, 16 Jun 2021 03:17:24 -0400
X-MC-Unique: zhx1YMOCOqm1cij1VLfmnw-1
Received: by mail-ed1-f70.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so488726edt.23
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 00:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxGE2L7b0S1BOFAfdffIsHID0G8yx+5uEH+ORuy77bY=;
        b=S/DcqqyRS17jOJ9YUKkGTZ1x9GDRR2HkiYfmsnMvtVSofNGO0kAiNGakmqx6w2M74d
         Q1YT/ipmHqN5i10iCst1qrWlcvBFAZggEAKt0ZIBKuNeSz0z708BHG6J80RO87iK9XgV
         BXStefyUGHrH2AEfWQVDGyVgmdYFCY2TSipqwF/l62SuTRwSEXTvkZVYIyYq10ZeymfX
         10ajVzi2nHZF5cXt3VftTP5YTqbBfJNEt7tOgBP5OFEXXQI4MnLOX595L+qIlXPx1dQY
         W++VhcfOdhvATucc+hhtrQLbZ9RVAqYyZriWUWasL2oyayEtELZ3pi9iMdzcn+1YRDSK
         hryA==
X-Gm-Message-State: AOAM5323SPT/HVxAuTv//8UrhesM34gpYsRrBb/dYyy0Ub3zUJEBIKns
        ZzspydnrJCuAHopXx/lV2eaL0x+PwGlUw/hstBRM8tYLha8lwOTBVWFqfrnfRdkKz628ZFFXv3Z
        VFJjvZFGiS38AtMcWvb8CBSR3t7k=
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr2459197edb.364.1623827842848;
        Wed, 16 Jun 2021 00:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA/rYPg6z9R5Nz+7wuzljU205VTmiezXdLy0eRMI3JtU3AcXflr4Sm2sokA2+2brbrND/vag==
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr2459174edb.364.1623827842666;
        Wed, 16 Jun 2021 00:17:22 -0700 (PDT)
Received: from localhost.localdomain.hub ([151.29.48.4])
        by smtp.gmail.com with ESMTPSA id lu21sm968074ejb.31.2021.06.16.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:17:22 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT v2 0/2] Add PINNED_HARD mode to hrtimers
Date:   Wed, 16 Jun 2021 09:17:03 +0200
Message-Id: <20210616071705.166658-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I rebased an RFC series I already proposed a while ago [1] and I'd like
people to consider it again for inclusion.

When running cyclictest on isolated CPUs with timer_migration enabled,
the following, where CPU0 is one of the housekeeping CPUs and CPU2 is
isolated, is (of course) happening:

     <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
     <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
     <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
     <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
 cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
 cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
 cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]

While cyclitest is arming the hrtimer while running on isolated CPU2
(by means of clock_nanosleep), the hrtimer is then firing on CPU0. This
is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
the timer is not pinned, as per timer_migration feature.

The problem with this is that we are measuring wake up latencies across
isolated and !isolated domains, which is against the purpose of
configuring the latter, while having timer_migration enabled is required
for certain workloads that are not using timers and don't want to be
ever interrupted.

Since PREEMPT_RT already forces HARD mode for hrtimers armed by tasks
running with RT policies, it seems to make sense to also force PINNED
mode under the same conditions.

This set implements the behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Sebastian didn't look against the proposed changes, but I didn't follow
up back then because it looked like we could meet workloads requirements
at that time w/o this set. Now things have changed, looks like the mix
of the two types of workloads - interrupt driven and always running - is
very relevant and we need to accommodate both types on the same system
setup.

Does this still make sense or do you suggest alternative approaches?

Thanks!

- Juri

1 - https://lore.kernel.org/lkml/20190214133716.10187-1-juri.lelli@redhat.com/

Juri Lelli (2):
  time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
  time/hrtimer: Embed hrtimer mode into hrtimer_sleeper

 include/linux/hrtimer.h |  3 +++
 kernel/time/hrtimer.c   | 13 +++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.31.1

