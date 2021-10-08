Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E0C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF4861019
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJHQVb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhJHQVb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Oct 2021 12:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3cEPXatX2ZSJNov0QZ84u3WSw59F+CiwA/vBLiu9m6E=;
        b=hOxHtK1dCqRFThV4wDE5SWvTn3+3ID2aaS2RnY0IBxxMMBHZcSR/Q902tGaorHDXy9X47k
        lWUDbc7AUv1LtTWalBsSS4DDMXDMOIwIvk+dM3oMOKy1Nk+zrOt/UbmA3L8jqSQm5KtjeH
        CHtOou1Miq91L3/s4/A6W3HX2tP2Sbc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-czJkj4E0Ox-PAhedlr-bsg-1; Fri, 08 Oct 2021 12:19:34 -0400
X-MC-Unique: czJkj4E0Ox-PAhedlr-bsg-1
Received: by mail-wr1-f71.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1919913wrc.9
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Oct 2021 09:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cEPXatX2ZSJNov0QZ84u3WSw59F+CiwA/vBLiu9m6E=;
        b=tW7jIx0bn6rqbW+s0CJTk4Ms6GWXqXqnJMrZEclPjCo1U/BBr5Aa7yMGZP0wNpX6Na
         LbLWWFny15CMTYwW33neKkVHsBHUoDn+FgnkyT4Ts3sJuDmTdKR/QJ8OIUiI+tydUzQD
         YYqmSSRIA35QNGyYNm3udeelyoCDr0a9JlY6R/1pRMvfNAGqf+42rdjqF6/qf2cKSvnF
         lCxgbH5+5J6xmueyZ57hS7TiKp9yAIc7ky3vC4wMKSDkP/6Iiwhf4Q4mbsWXOxKiwD+8
         ajKw9kwKZ7xfWJ/D9v/VAY99qCnxct/5JMzpeZp6TlZInBC50DZo7Fq50EqSqGsRTYho
         vxdg==
X-Gm-Message-State: AOAM5314l/byVG4gFMTgnzZw4BqqKG0uXAxj5af258JYEdwkwl5mWHeP
        HHIS4FK8z403jbm8N7j3h4Mc0tiuflfThqAatwvhaCeX7JfqJ9v5UcpKEIrUkfsTLA0xGZtgtUG
        F3FC8EGEd9XTTPjLL5a3uaAw4UCU=
X-Received: by 2002:a1c:7d91:: with SMTP id y139mr4493834wmc.57.1633709973136;
        Fri, 08 Oct 2021 09:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKKijO+74izv+qNkXyDuYFKonDBhllUKwll6+hoH5cpRMPBMvTIj5SMLDKxABYXEH63mxR+A==
X-Received: by 2002:a1c:7d91:: with SMTP id y139mr4493808wmc.57.1633709972941;
        Fri, 08 Oct 2021 09:19:32 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f184sm2901753wmf.22.2021.10.08.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:19:32 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, ppandit@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 0/3] mm/page_alloc: Remote per-cpu lists drain support
Date:   Fri,  8 Oct 2021 18:19:19 +0200
Message-Id: <20211008161922.942459-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series replaces mm/page_alloc's per-cpu lists drain mechanism in order for
it to be able to be run remotely. Currently, only a local CPU is permitted to
change its per-cpu lists, and it's expected to do so, on-demand, whenever a
process demands it (by means of queueing a drain task on the local CPU). Most
systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
that can't take any sort of interruption without breaking their functional
guarantees (latency, bandwidth, etc...). Having a way for these processes to
remotely drain the lists themselves will make co-existing with isolated CPUs
possible, and comes with minimal performance[1]/memory cost to other users.

The new algorithm will atomically switch the pointer to the per-cpu lists and
use RCU to make sure it's not being used before draining them. 

I'm interested in an sort of feedback, but especially validating that the
approach is acceptable, and any tests/benchmarks you'd like to see run against
it. For now, I've been testing this successfully on both arm64 and x86_64
systems while forcing high memory pressure (i.e. forcing the
page_alloc's slow path).

Patches 1-2 serve as cleanups/preparation to make patch 3 easier to follow.

Here's my previous attempt at fixing this:
https://lkml.org/lkml/2021/9/21/599

[1] Proper performance numbers will be provided if the approach is deemed
    acceptable. That said, mm/page_alloc.c's fast paths only grow by an extra
    pointer indirection and a compiler barrier, which I think is unlikely to be
    measurable.

---

Nicolas Saenz Julienne (3):
  mm/page_alloc: Simplify __rmqueue_pcplist()'s arguments
  mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
  mm/page_alloc: Add remote draining support to per-cpu lists

 include/linux/mmzone.h |  24 +++++-
 mm/page_alloc.c        | 173 +++++++++++++++++++++--------------------
 mm/vmstat.c            |   6 +-
 3 files changed, 114 insertions(+), 89 deletions(-)

-- 
2.31.1

