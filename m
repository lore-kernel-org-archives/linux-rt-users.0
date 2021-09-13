Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF85C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C9A60F11
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhIMIk3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238012AbhIMIk2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 04:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631522353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zNADHyJRyF5z79P7UWadu367zvlPvteYzuMxkFDzfQk=;
        b=AIYl+QI+ukidIcClZoL9X/WzZjforHEOEq1JEaHPzKuORvgLABindvPya6unfTqyusV6+i
        H5NSrxSX+GwEy4i0Cr9AgmZIpalSdLZXdrj3uJdWnxfypyfCwlpgyKVHc5RWw8qzBR8BXb
        Oj2tUhSAE44vvaB1RmVWkD9FXQ0SwcI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-VE1C7LjsP9SiYxMYA4z95Q-1; Mon, 13 Sep 2021 04:39:12 -0400
X-MC-Unique: VE1C7LjsP9SiYxMYA4z95Q-1
Received: by mail-wr1-f70.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so668459wrt.21
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 01:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNADHyJRyF5z79P7UWadu367zvlPvteYzuMxkFDzfQk=;
        b=T31aU9Qg8HVqoSvAY4NZrK9Sr/5xLTTP/Afyy6wOUG3zA6Wp3Vny0yn4u8q50sZgFl
         uN22CQiIvxbc9bBYAkJcr9Ta5OEnI3tLQ+34E8Ldldf9JogdmlAhuSNQXyeyvtqI8ToA
         dXpdYwhkHYwMwlyv5HoskQgA3Deg5uocqxYi5k/09fnxKdDPhwDuvepq1zqbOvPT3idX
         DDlfxO8mGRKz/dm46vW+UTRhMLtM+u/QiuL5gxpkYSEDmQe+d9OsyskL7IUWywFzDfra
         0mPC86J4lcczqLpzkTVRZzmfQrxTQK0Zqtwf3bOAVX24CFd6u1zp4K/2nLICcioYvmc4
         QCoQ==
X-Gm-Message-State: AOAM532qJcBQz0ESbCRazB7E35nDVrOeW9Ah4uEucZlSJNO67JNePROB
        UqhqspFDu4xITCD6oTzAnnhL2cEvd4y7bmIHjI8oZVxqTyv3EvxwbKl5r3151YVdx36Ha5LRQh9
        TT/Vr4M3XuHmeG5+4sHfn1bpl/HyM6DWeu1BtS9VDTyXQUk46D7htoMFbNWlO1kZblcbNawcBmm
        BJw3s=
X-Received: by 2002:adf:9d45:: with SMTP id o5mr11086538wre.226.1631522350760;
        Mon, 13 Sep 2021 01:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOyP4IVsFeOis3B2RVH3TydvO7GILyNqcaBR3z2fczrsUyo2dv8hzBQTA+LE/VQ7xF5ro/9g==
X-Received: by 2002:adf:9d45:: with SMTP id o5mr11086516wre.226.1631522350528;
        Mon, 13 Sep 2021 01:39:10 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id u8sm6640688wmq.45.2021.09.13.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:39:10 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH v2 1/3] oslat: Rename cpu_mhz/cpu_hz to counter_mhz/counter_hz
Date:   Mon, 13 Sep 2021 10:39:06 +0200
Message-Id: <20210913083908.48408-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

'cpu_mhz' in oslat actually represents the frequency at which the high
frequency counter we measure with ticks. There is no requirement for the
counter to match the CPU frequency, nor is forced to do so on any of the
supported architectures[1][2]. So rename it to 'counter_mhz' in order to
better match reality.

[1] x86_64
Intel TRM Vol 3B, 17.17 Time Stamp Counter:
"Constant TSC behavior ensures that the duration of each clock tick is
uniform and supports the use of the TSC as a wall clock timer even if
the processor core changes frequency."

[2] ppc64
From __ppc_get_timebase() manpages: The Time Base Register is a 64-bit
register provided by Power Architecture processors. It stores a
monotonically incremented value that is updated at a system-dependent
frequency that may be different from the processor frequency. Note that
glibc's __ppc_get_timebase() and oslat's ppc64 frc() implementations are
the same.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

Changes since v1:
 - More complete commit message
 - s/timer/counter/

 src/oslat/oslat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 6ff5ba8..33cccd3 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -123,7 +123,7 @@ struct thread {
 	pthread_t            thread_id;
 
 	/* NOTE! this is also how many ticks per us */
-	unsigned int         cpu_mhz;
+	unsigned int         counter_mhz;
 	cycles_t             int_total;
 	stamp_t              frc_start;
 	stamp_t              frc_stop;
@@ -228,7 +228,7 @@ static int move_to_core(int core_i)
 	return sched_setaffinity(0, sizeof(cpus), &cpus);
 }
 
-static cycles_t __measure_cpu_hz(void)
+static cycles_t __measure_counter_hz(void)
 {
 	struct timeval tvs, tve;
 	stamp_t s, e;
@@ -244,13 +244,13 @@ static cycles_t __measure_cpu_hz(void)
 	return (cycles_t) ((e - s) / sec);
 }
 
-static unsigned int measure_cpu_mhz(void)
+static unsigned int measure_counter_mhz(void)
 {
 	cycles_t m, mprev, d;
 
-	mprev = __measure_cpu_hz();
+	mprev = __measure_counter_hz();
 	do {
-		m = __measure_cpu_hz();
+		m = __measure_counter_hz();
 		if (m > mprev)
 			d = m - mprev;
 		else
@@ -263,7 +263,7 @@ static unsigned int measure_cpu_mhz(void)
 
 static void thread_init(struct thread *t)
 {
-	t->cpu_mhz = measure_cpu_mhz();
+	t->counter_mhz = measure_counter_mhz();
 	t->maxlat = 0;
 	t->overflow_sum = 0;
 	t->minlat = (uint64_t)-1;
@@ -288,7 +288,7 @@ static void thread_init(struct thread *t)
 
 static float cycles_to_sec(const struct thread *t, uint64_t cycles)
 {
-	return cycles / (t->cpu_mhz * 1e6);
+	return cycles / (t->counter_mhz * 1e6);
 }
 
 static void insert_bucket(struct thread *t, stamp_t value)
@@ -296,7 +296,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	int index, us;
 	uint64_t extra;
 
-	index = value / t->cpu_mhz;
+	index = value / t->counter_mhz;
 	assert(index >= 0);
 	us = index + 1;
 	assert(us > 0);
@@ -450,7 +450,7 @@ static void write_summary(struct thread *t)
 	calculate(t);
 
 	putfield("Core", t[i].core_i, "d", "");
-	putfield("CPU Freq", t[i].cpu_mhz, "u", " (Mhz)");
+	putfield("Counter Freq", t[i].counter_mhz, "u", " (Mhz)");
 
 	for (j = 0; j < g.bucket_size; j++) {
 		if (j < g.bucket_size-1 && g.output_omit_zero_buckets) {
@@ -494,7 +494,7 @@ static void write_summary_json(FILE *f, void *data)
 	for (i = 0; i < g.n_threads; ++i) {
 		fprintf(f, "    \"%u\": {\n", i);
 		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
-		fprintf(f, "      \"freq\": %d,\n", t[i].cpu_mhz);
+		fprintf(f, "      \"freq\": %d,\n", t[i].counter_mhz);
 		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
 		fprintf(f, "      \"avg\": %3lf,\n", t[i].average);
 		fprintf(f, "      \"max\": %" PRIu64 ",\n", t[i].maxlat);
-- 
2.31.1

