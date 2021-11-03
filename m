Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38839C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D683610EA
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhKCRH6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbhKCRH5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Nov 2021 13:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635959120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+f9atatdU2nnvM9ItKdkQH/ZAOJGs+MlbwdXfCEnlhQ=;
        b=i6GAOidBxHvU4aAXtx+Xog5k4euHIbFK+qc4AHf6IvOeVq3pK58fvwxED8WxyODQn2jnH3
        a4/YHThKyPaJTxxqy/+X/iBqhTCfH4uSN7I5E9YZFZ/8yVEqgOgvGJmIUbXixBvDXaMIgt
        Pm6ANSKsK4N6L4sYWsAygXFyjJZC90w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-ndQMUxMiO86hbed15GxZ0g-1; Wed, 03 Nov 2021 13:05:18 -0400
X-MC-Unique: ndQMUxMiO86hbed15GxZ0g-1
Received: by mail-wr1-f70.google.com with SMTP id p17-20020adff211000000b0017b902a7701so560152wro.19
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Nov 2021 10:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+f9atatdU2nnvM9ItKdkQH/ZAOJGs+MlbwdXfCEnlhQ=;
        b=gmt2lX6vOg0iZaE8n0rFDs1sWCED+SKj7zPly2b9+/2+byHiZArpjKwYXpJZerhxLF
         jI9808i35s5DpZT+KfpHJ/MkGEYUeQg8eYqaruPY3Voaf2bXKIAM4sBH9je3eyzof8eb
         RtIQv6+BlvG8WJ7XwF9TBnJrHpv2PlFzyXFSYgSBxqcB6jotPZ+I3kH0g7SR2Yv/3uXu
         zVCBzTsfP7EfmRrUcXYR9U3ao/WKsRO8vQVYuo+6V3IfqDiM+ih/QvoGARzZBZuAwgoT
         pzUvmFajMOyX6aEnNOZqkxi2uYWHdykG5n/SqmbdWpaYFGki/itWtUTY+w1BSwUeaPC9
         LS8w==
X-Gm-Message-State: AOAM533gN7UoQuqxrH4ooezZKsPveJG9vJtlqo7YmFaCBVX/RnIbPTO4
        7HuGyihdpm+JcmGdIrFWjUS3OhZ6HekdBXnhDtuv90KipHU9lk5BoiWMism+8UwJacYEfvwF/UI
        N7zrIv3fxxgjRgSXVl1hZ/qwqD2A=
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr16394376wmg.58.1635959117569;
        Wed, 03 Nov 2021 10:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLQHIxWBGipmQG2N4mWPaZQrmHOYgh8w0bbIdQ9xPNXlaB1oCioABznXluNH8LAtEML5rCZQ==
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr16394343wmg.58.1635959117291;
        Wed, 03 Nov 2021 10:05:17 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h22sm2900610wmq.14.2021.11.03.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:05:16 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 0/3] mm/page_alloc: Remote per-cpu page list drain support
Date:   Wed,  3 Nov 2021 18:05:09 +0100
Message-Id: <20211103170512.2745765-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series introduces a new locking scheme around mm/page_alloc.c's per-cpu
page lists which will allow for remote CPUs to drain them. Currently, only a
local CPU is permitted to change its per-cpu lists, and it's expected to do so,
on-demand, whenever a process demands it (by means of queueing an drain task on
the local CPU). Most systems will handle this promptly, but it'll cause
problems for NOHZ_FULL CPUs that can't take any sort of interruption without
breaking their functional guarantees (latency, bandwidth, etc...).

This new locking scheme, based on per-cpu spinlocks, is the simpler and more
maintainable approach so far[1], although also has some drawbacks: it comes
with a small performance. Depending on the page allocation code path
micro-benchmark we can expect 0% to 0.6% degradation on x86_64, and 0% to 2% on
arm64[2].

Assuming there is nothing too horrible in the patches themselves I believe it
all comes down to whether we prefer to take the small performance hit vs the
maintenance burden of a more complex solution[1]. I don't have enough
experience with performance tuning, nor with maintenance to have an
authoritative opinion here, so I'll defer to whatever is hopefully discussed
here. Also, I'll be happy to run any extra tests that I might have missed.

Patch #1 could be taken regardless of the rest of the series as it removes dead
code.

The series is based on today's linux-next. 

Changes since v2:
 - Provide performance numbers
 - Unanimously use per-cpu spinlocks

[1] Other approaches can be found here:

  - Static branch conditional on nohz_full, no performance loss, the extra
    config option makes is painful to maintain (v1):
    https://lore.kernel.org/linux-mm/20210921161323.607817-5-nsaenzju@redhat.com/

  - RCU based approach, complex, yet a bit less taxing performance wise
    (RFC):
    https://lore.kernel.org/linux-mm/20211008161922.942459-4-nsaenzju@redhat.com/

[2] See individual patches for in-depth results

---

Nicolas Saenz Julienne (3):
  mm/page_alloc: Don't pass pfn to free_unref_page_commit()
  mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin
    locks
  mm/page_alloc: Remotely drain per-cpu lists

 include/linux/mmzone.h |   1 +
 mm/page_alloc.c        | 151 ++++++++++++++---------------------------
 2 files changed, 52 insertions(+), 100 deletions(-)

-- 
2.33.1

