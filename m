Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353CC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C389660FE6
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhIMIkb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238048AbhIMIkb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 04:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631522355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D0nlJoAiAZyFi9J9J2ZbLL6MAhxCs1NU/7pDXm5Wfk=;
        b=eP+wPuCcinDfFS+79W6C+I3u8mQTJ9dcy32iEftVzkbH8bTvgodpoA6YITAFLE4ew+D7xy
        owf46YJXaKUU6tO82J9EcaZHsMBGWg7YHdKW3BsryoJJqW2P1EpCFDUF/ClHWjzr6af1y2
        QoeLkqZaLEvuv/yDi3FQNer7e24s1dk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-gOm7tdx7MbiDdPsdP8NrDQ-1; Mon, 13 Sep 2021 04:39:13 -0400
X-MC-Unique: gOm7tdx7MbiDdPsdP8NrDQ-1
Received: by mail-wr1-f71.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so668476wrt.21
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 01:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D0nlJoAiAZyFi9J9J2ZbLL6MAhxCs1NU/7pDXm5Wfk=;
        b=dWcuUV/xOVQWzr0hAA3dSdF+1nfodn3jtFEouDZ/5+e30G0fxnvQbKk8Yn0gbbhi8l
         PnEraDXRKUE7mOLyqak5i8yHJvURJHebMHXrzZiG7hPjv6x1ok4nwFYRZiZv/zzjqPGh
         MF/oAOMyvMSoEt21pLnN6MNHo2fZrOXLsrwr1EfCTcivX0v+LcViaErlaUmpYCGN08+T
         +DF5rzOsve0Ac2ncjATbk6S49EeFOWE0s7oSMLMRl6C/5D1/XO2Q3Hm+1CYkD8BgOMwB
         1idNkCKMBjuYedwb+d0Ex/dPVqoF7tVi2RQqXuv2CkA0GIo8umnJ+JxmPcOeNSVSd293
         s8Gw==
X-Gm-Message-State: AOAM53257PWHOAV7VbFny5+ANYbuczNj7BZbSbu67o67/dJxGL3LtHuL
        lCSMqmhVtbfglSSk+FulrQ0ue2T82KS7hx/zIY3VLYe91JFrkKehoY9hKP6n7mkRwHMs8SOIgnZ
        t8eAFH0wm1AORfgB12ETOyIfLc+JAe/tgu/YMjTdnvSKb/6OeHNL2BFAGpzCMAU0wjD2E9XLXhj
        hhpW4=
X-Received: by 2002:a1c:c913:: with SMTP id f19mr9959512wmb.86.1631522352413;
        Mon, 13 Sep 2021 01:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx63M5oHf6YxN6G35h/Bf2q8YOyJ8mg2xDrlC1Bo1laO/EwUyA8CSa7Usp0/CmXOs5g857yWw==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr9959492wmb.86.1631522352199;
        Mon, 13 Sep 2021 01:39:12 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id u8sm6640688wmq.45.2021.09.13.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:39:11 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH v2 3/3] oslat: Allow for arch specific counter frequency measurements
Date:   Mon, 13 Sep 2021 10:39:08 +0200
Message-Id: <20210913083908.48408-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913083908.48408-1-nsaenzju@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Some architectures have special purpose registers to query the system
counter's frequency. Let's use that when available.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
--

Changes since v1:
 - Use cleaner method to have generic and arch functions to measure
   couter's freq

 src/oslat/oslat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index c90ec1a..5fce223 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -74,6 +74,16 @@ static inline void frc(uint64_t *pval)
 # elif defined(__aarch64__)
 #  define relax()          __asm__ __volatile("yield" : : : "memory")
 
+#define arch_measure_counter_mhz
+static unsigned int measure_counter_mhz(void)
+{
+	unsigned int val;
+
+	__asm__ __volatile__("mrs %0, cntfrq_el0" : "=r" (val));
+
+	return val / 1e6;
+}
+
 static inline void frc(uint64_t *pval)
 {
 	/*
@@ -241,6 +251,7 @@ static int move_to_core(int core_i)
 	return sched_setaffinity(0, sizeof(cpus), &cpus);
 }
 
+#ifndef arch_measure_counter_mhz
 static cycles_t __measure_counter_hz(void)
 {
 	struct timeval tvs, tve;
@@ -273,6 +284,7 @@ static unsigned int measure_counter_mhz(void)
 
 	return (unsigned int) (m / 1000000);
 }
+#endif
 
 static void thread_init(struct thread *t)
 {
-- 
2.31.1

