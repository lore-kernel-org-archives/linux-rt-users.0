Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65EBC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEF56109E
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhIUQPF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231690AbhIUQPE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qpu+HTkDrTU2emAVPYaio1EuujPd/r4QIzzzcyyaBgg=;
        b=TkhoJv3S+N9FgvKAQgv269srhFF3NGONY3IruZJpi56O+XEg8aDS+m0GGrjGI8gOq4JavC
        et8jjpI1P7dbyK5YwBdCFKRVMzmIe2FyHsO87IfvavQ2BX/4DuWE2CrZVA7UnP6kuQEc5W
        kQ5UUhg6RtNVNm1GKEPh1PluI2eloHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-wuArdEVpNqKL7jH24yDztg-1; Tue, 21 Sep 2021 12:13:34 -0400
X-MC-Unique: wuArdEVpNqKL7jH24yDztg-1
Received: by mail-wr1-f71.google.com with SMTP id j16-20020adfa550000000b0016012acc443so3894164wrb.14
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Sep 2021 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpu+HTkDrTU2emAVPYaio1EuujPd/r4QIzzzcyyaBgg=;
        b=PSVfkGh1Umvt8wvX+X/rHWx3ICnvVGDVpQBWIxr584p1X6LScmMCrol+einxHjsWSM
         mYhvSKT3+bTddi/PeSn7kHNuYTxbhm9aD0ykdV9he7cdnzxcZya7Ah/Cu4NX0OZinSqC
         L8QOyryNAKxQ0FTHM4kccfIxuwhGI2X04CF/DfMk3q9D2CgOVC6sVgAcxEfKaZ/JuCOO
         m+Sw6gUt+yCN3iVd6k2IOkIqx1H/uRYZ0X2rlDcxrxRNgsvV5y1s8rhUdI/WInkTVUmP
         nySFOHYoxpdls1SwI+s7RV9NwF5B2df1rKdx2VBwqSM6IHAXzBexa++/8z3S1e2gWFPk
         xnYw==
X-Gm-Message-State: AOAM530u4rcqxuSHqB9rgANxHgtZ7R1TXZxYWaWlNbWwi8XK1l0E6FwY
        OgmhMsBC497HpX7ZIxM4KSspj995PUcw+F/x6MV5u1dNkfw0HyGoncCkLwevSO57Q9n4723p+0Q
        kBTks+ePDX7Ly1Ry2uDCYJTG5ZNo=
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr8786523wrz.319.1632240813484;
        Tue, 21 Sep 2021 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCaTYPwc/9t2AtLYmgJlq3XzRG6bZgmYBolkh1RNI380hxk+8ra/35JT3nNBei0WBHtrFC/g==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr8786498wrz.319.1632240813317;
        Tue, 21 Sep 2021 09:13:33 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:32 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page list drain support
Date:   Tue, 21 Sep 2021 18:13:18 +0200
Message-Id: <20210921161323.607817-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series introduces an alternative locking scheme around mm/swap.c's per-cpu
LRU pagevec caches and mm/page_alloc.c's per-cpu page lists which will allow
for remote CPUs to drain them. Currently, only a local CPU is permitted to
change its per-cpu lists, and it's expected to do so, on-demand, whenever a
process demands it (by means of queueing an drain task on the local CPU). Most
systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
that can't take any sort of interruption without breaking their functional
guarantees (latency, bandwidth, etc...). Having a way for these processes to
remotely drain the lists themselves will make co-existing with isolated CPUs
possible, at the cost of more constraining locks.

Fortunately for non-NOHZ_FULL users, the alternative locking scheme and remote
drain code are conditional to a static key which is disabled by default. This
guarantees minimal functional or performance regressions. The feature will only
be enabled if NOHZ_FULL's initialization process was successful.

This work is based on a previous series by Thomas Gleixner, Anna-Maria
Gleixner, and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/

Nicolas Saenz Julienne (6):
  mm/swap: Introduce lru_cpu_needs_drain()
  mm/swap: Introduce alternative per-cpu LRU cache locking
  mm/swap: Allow remote LRU cache draining
  mm/page_alloc: Introduce alternative per-cpu list locking
  mm/page_alloc: Allow remote per-cpu page list draining
  sched/isolation: Enable 'remote_pcpu_cache_access' on NOHZ_FULL
    systems

 kernel/sched/isolation.c |   9 +-
 mm/internal.h            |   2 +
 mm/page_alloc.c          | 111 ++++++++++++++++-----
 mm/swap.c                | 202 ++++++++++++++++++++++++++++++---------
 4 files changed, 253 insertions(+), 71 deletions(-)

-- 
2.31.1

