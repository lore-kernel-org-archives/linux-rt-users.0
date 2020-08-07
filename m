Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A30C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46532177B
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biKl23aT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHGJvY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgHGJvX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4qR48J/hEHBI8WQZHhJvxYXozsSkTPR+3Eg1XuaID0=;
        b=biKl23aTwA+pskABZYkvtsewiRY6OkFEZ5K3MaVnKPixzECNvovUsi2GK5r6jMgPdPSJPL
        UhW4lUIqMs3Z1GWkUD6g5NonKHiw2tb7SAXhOgsvukEDaEVkUbZkCASVXFDdIYdApAHxig
        h9OuoyAabHDuqJ9L327yqqB2CJeVHLY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-AxDtLW7vOfOXS1XOCiNJMA-1; Fri, 07 Aug 2020 05:51:20 -0400
X-MC-Unique: AxDtLW7vOfOXS1XOCiNJMA-1
Received: by mail-wr1-f72.google.com with SMTP id k11so542247wrv.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 02:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4qR48J/hEHBI8WQZHhJvxYXozsSkTPR+3Eg1XuaID0=;
        b=ifBQ2lMb6ien0O4xBE+fUi4uZwbjR06sOlTl4Rk5CpmrVdJvSJqP9MbOuo56w219qW
         9w5YHjnxyGcGuf28pwol52K4egVyYb5O03nWet4TLwo6btGhqNFIU2nOLL9JSzk8Kgrt
         V7n1elNWM0sTK/UPVIuJJeCSMJKuNZJD4jYMsPwNUx6r7Y4apXTLEpyAZjcoQVKQZq7T
         krcp1I238Ei2VDW9iHJ5RKfxNc6FPqcYWySEmn8fuxcR0OUdp7tAdfWYvhkpYAlS1zLX
         BthQww1LGC/JkSKqWp8nESFny/7ikEHFDzRO+OnfPT6g+32s1MKAod/gfcnPXUUSsw61
         AfPg==
X-Gm-Message-State: AOAM532pPxZvVT2lMdFBfekeSsRdPOS2jJY/Q/vX/c2wichisBmPBMWk
        TfYlzEbqKZ1QlQLGPBdYN4zpTKT4ykXeNdXLiThGXWAxzLjLvMTN3CyOvMp6Y1MAr3VZqgSqAhZ
        QFxE2BWog5gpxtaYatT0se2Pm/wc=
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr12781597wmj.128.1596793879015;
        Fri, 07 Aug 2020 02:51:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzzVmicPXTT3okcGVa9VLbw49o3MMEOIxvUgOP+IQn53JB4z5ILTkgxtRPEyGWk8QO3iBRpg==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr12781570wmj.128.1596793878688;
        Fri, 07 Aug 2020 02:51:18 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:17 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Date:   Fri,  7 Aug 2020 11:50:45 +0200
Message-Id: <20200807095051.385985-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
implementation [1].

SCHED_DEADLINE servers can help fixing starvation issues of low priority
tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
cycles. Today we have RT Throttling; DEADLINE servers should be able to
replace and improve that.

I rebased Peter's patches (adding changelogs where needed) on
tip/sched/core as of today and incorporated fixes to issues discussed
during RFC v1. Current set seems to even boot on real HW! :-)

While playing with RFC v1 set (and discussing it further offline with
Daniel) it has emerged the need to slightly change the behavior. Patch
6/6 is a (cumbersome?) attempt to show what's probably needed.
The problem with "original" implementation is that FIFO tasks might
suffer preemption from NORMAL even when spare CPU cycles are available.
In fact, fair deadline server is enqueued right away when NORMAL tasks
wake up and they are first scheduled by the server, thus potentially
preempting a well behaving FIFO task. This is of course not ideal.
So, in patch 6/6 I propose to use some kind of starvation monitor/
watchdog that delays enqueuing of deadline servers to the point when
fair tasks might start to actually suffer from starvation (just randomly
picked HZ/2 for now). One problem I already see with the current
implementation is that it adds overhead to fair paths, so I'm pretty
sure there are better ways to implement the idea (e.g., Daniel already
suggested using a starvation monitor kthread sort of thing).

Receiving comments and suggestions is the sole purpose of this posting
at this stage. Hopefully we can further discuss the idea at Plumbers in
a few weeks. So, please don't focus too much into actual implementation
(which I plan to revise anyway after I'm back from pto :), but try to
see if this might actually fly. The feature seems to be very much needed.

Thanks!

Juri

1 - https://lore.kernel.org/lkml/20190726145409.947503076@infradead.org/

Juri Lelli (1):
  sched/fair: Implement starvation monitor

Peter Zijlstra (5):
  sched: Unify runtime accounting across classes
  sched/deadline: Collect sched_dl_entity initialization
  sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
  sched/deadline: Introduce deadline servers
  sched/fair: Add trivial fair server

 include/linux/sched.h    |  28 ++-
 kernel/sched/core.c      |  23 +-
 kernel/sched/deadline.c  | 483 ++++++++++++++++++++++++---------------
 kernel/sched/fair.c      | 136 ++++++++++-
 kernel/sched/rt.c        |  17 +-
 kernel/sched/sched.h     |  50 +++-
 kernel/sched/stop_task.c |  16 +-
 7 files changed, 522 insertions(+), 231 deletions(-)

-- 
2.26.2

