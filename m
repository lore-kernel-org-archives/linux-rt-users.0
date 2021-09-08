Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50897C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46B60724
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbhIHKDZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231723AbhIHKDZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631095337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7np63vMuWkV60dGYkoyZGooYdzdN27SafRW+cIGzbFA=;
        b=bNIhMGinaPwliNv3eUWki3M7qhI3f+QvgbRfMJVk5H5WF66fbJBXESJ3a0EVLlix3lqAFn
        il7LKC07+kRi2/TUOfPbf5oRh8WYBGvNBBPRMDzcrNb8KM0+xq/fnO9m3uJwGPVG4sxkVI
        Xsjoy0+BCYO+RfnV9ZtpT7GDPXEM+hQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-UU7_5TA5OnyEUUpt-d-bew-1; Wed, 08 Sep 2021 06:02:16 -0400
X-MC-Unique: UU7_5TA5OnyEUUpt-d-bew-1
Received: by mail-wm1-f70.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so836347wmg.3
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 03:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7np63vMuWkV60dGYkoyZGooYdzdN27SafRW+cIGzbFA=;
        b=Yo2gfKyVUU8xopeT2J4fNe/QTKrtgzOI4oTKnm6wbOd9Lix6JaKpgFXuhI3bYchi2V
         ONaxyU/auZpmtEhvIWQ1BCx0sA4yM/nZSg1k0v6MFx/BwnwpO55VoGNIBO7JrdSjSWsO
         NoEgmkxpsJTqSWZo9f6MTujCEtlEmJjBYmIizS0YAcC4COdLLC+4LdwHU7dHrjTu3jg+
         eDfaUw/FbvU4BB/ns9oixVtA5Ber5iBqbyzNC1KOim00gocQViZ/L4Ja0c3hs12wLhmp
         lSQ7nLh5+28NE2rKKbeg6ZQjAOkCTm0HfqqB/g3dO/eXn1VNUYYONZBBu3H+W7gHX52U
         1sDQ==
X-Gm-Message-State: AOAM5303C1G2kKgfLlNCgUBfD6lF3ztBhkfCoxtqJIK+zaOeTCPCVXpa
        BKFeawN9BLTzeWFGxIo+VelL6nuxpytRUEzbteTxSAs7wZbfn2o2EGu11jO6z/vJ9Sg4nB+Rxo2
        IfJW7ijCQhOFs5NdZgzSqTuFDDN0dJ7z//zWcIRvn0u8T4YEMAFvIxT5XKZJFQiThbJZXIpsFgf
        NnTKg=
X-Received: by 2002:a5d:424c:: with SMTP id s12mr3086040wrr.8.1631095334803;
        Wed, 08 Sep 2021 03:02:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD/OynwPP2uVeO/SFdGI1Oc92DXRzE54Gxs8tXramtnZv8IiYznyKC9MS+ckbZCxNdol5v8g==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr3086009wrr.8.1631095334547;
        Wed, 08 Sep 2021 03:02:14 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id k16sm1679963wrx.87.2021.09.08.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:02:14 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
Date:   Wed,  8 Sep 2021 12:02:07 +0200
Message-Id: <20210908100209.118609-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

'cpu_mhz' in oslat actually represents the frequency at which the high
frequency timer we measure with ticks. There is no need for it to match
the CPU frequency, nor will do on all supported architectures. So rename
it to 'timer_mhz' in order to better match reality.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 6ff5ba8..a4aa5f1 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -123,7 +123,7 @@ struct thread {
 	pthread_t            thread_id;
 
 	/* NOTE! this is also how many ticks per us */
-	unsigned int         cpu_mhz;
+	unsigned int         timer_mhz;
 	cycles_t             int_total;
 	stamp_t              frc_start;
 	stamp_t              frc_stop;
@@ -228,7 +228,7 @@ static int move_to_core(int core_i)
 	return sched_setaffinity(0, sizeof(cpus), &cpus);
 }
 
-static cycles_t __measure_cpu_hz(void)
+static cycles_t __measure_timer_hz(void)
 {
 	struct timeval tvs, tve;
 	stamp_t s, e;
@@ -244,13 +244,13 @@ static cycles_t __measure_cpu_hz(void)
 	return (cycles_t) ((e - s) / sec);
 }
 
-static unsigned int measure_cpu_mhz(void)
+static unsigned int measure_timer_mhz(void)
 {
 	cycles_t m, mprev, d;
 
-	mprev = __measure_cpu_hz();
+	mprev = __measure_timer_hz();
 	do {
-		m = __measure_cpu_hz();
+		m = __measure_timer_hz();
 		if (m > mprev)
 			d = m - mprev;
 		else
@@ -263,7 +263,7 @@ static unsigned int measure_cpu_mhz(void)
 
 static void thread_init(struct thread *t)
 {
-	t->cpu_mhz = measure_cpu_mhz();
+	t->timer_mhz = measure_timer_mhz();
 	t->maxlat = 0;
 	t->overflow_sum = 0;
 	t->minlat = (uint64_t)-1;
@@ -288,7 +288,7 @@ static void thread_init(struct thread *t)
 
 static float cycles_to_sec(const struct thread *t, uint64_t cycles)
 {
-	return cycles / (t->cpu_mhz * 1e6);
+	return cycles / (t->timer_mhz * 1e6);
 }
 
 static void insert_bucket(struct thread *t, stamp_t value)
@@ -296,7 +296,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	int index, us;
 	uint64_t extra;
 
-	index = value / t->cpu_mhz;
+	index = value / t->timer_mhz;
 	assert(index >= 0);
 	us = index + 1;
 	assert(us > 0);
@@ -450,7 +450,7 @@ static void write_summary(struct thread *t)
 	calculate(t);
 
 	putfield("Core", t[i].core_i, "d", "");
-	putfield("CPU Freq", t[i].cpu_mhz, "u", " (Mhz)");
+	putfield("Timer Freq", t[i].timer_mhz, "u", " (Mhz)");
 
 	for (j = 0; j < g.bucket_size; j++) {
 		if (j < g.bucket_size-1 && g.output_omit_zero_buckets) {
@@ -494,7 +494,7 @@ static void write_summary_json(FILE *f, void *data)
 	for (i = 0; i < g.n_threads; ++i) {
 		fprintf(f, "    \"%u\": {\n", i);
 		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
-		fprintf(f, "      \"freq\": %d,\n", t[i].cpu_mhz);
+		fprintf(f, "      \"freq\": %d,\n", t[i].timer_mhz);
 		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
 		fprintf(f, "      \"avg\": %3lf,\n", t[i].average);
 		fprintf(f, "      \"max\": %" PRIu64 ",\n", t[i].maxlat);
-- 
2.31.1

