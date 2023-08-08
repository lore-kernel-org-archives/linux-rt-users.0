Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC22C001B0
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 19:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHHTa7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjHHTaf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 15:30:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED06D4E7
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 11:56:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd066b0fd4so741400a34.2
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Aug 2023 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691521017; x=1692125817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oS1lxaVaW2zqCxh+qE8+HF6DMnR+OTewXJQpYFRU8zk=;
        b=GfiWcUX/Iz1C1OH0WHIK9ZZAadRlURaJcgk3cHUXcx/Xu0IyS+/b9kq0P/MN1rE8iL
         4g0bvcAP7Xh1f0Jj68vIaOwp+vgk1JvuQhoQUJUt3bVLar9OtGlxqJyzgAlRRZb0Efkf
         sKxA8c0Oi8NImQYtJ+MSUCMJO+ojW6M5y8IsuSEQ60haG+9smHC1MKgeEG7Xtvcpq8SJ
         GV6Q+DdxU5OQxUS3s4nTk6in2h1qmb77kVNhr9RJgoGD7coEAA8kZ/VkxcpNbPbCuvZV
         6WFa72dOv8tcSftR0RfumIpsE0QQJRYDQR+deUwDlOA1RROuJcCVSZYRCJiKXLrSbwU6
         uQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521017; x=1692125817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS1lxaVaW2zqCxh+qE8+HF6DMnR+OTewXJQpYFRU8zk=;
        b=BbEHy/DuDdSO6of2gdh0+R1DS25IU0eQy+fQgo+jx5dXV+reCJmH1tUfLVS/27Apvm
         EjRpg5Celr9wPc5Bj7LL/yrAMdkfjFi8LxpmEKuHC9breIxqS+1EBs3yuEEe/t2i2yV2
         9bhk2mx/dt/xiZlmoFLrHYyWOmDG/dXRuwx3BM1DzmGYOlCJAQaG4gO496cXTpljCgQ3
         mIxZJa+9mnkpgQ9wTUCm4BAjrU4PM9UpgAbjtwIoQov4xfeuFgcNpptaE9oW84XFoNxT
         8MjXUDgcZInehG+x6wBDAeK253Or3t2BpswX20IkAkQbR4q0uQ+R7WWB/i11Kv1BHJIC
         BMZw==
X-Gm-Message-State: AOJu0YwMlDQ9fvgZ98U11NIqcD7aruZ+oxd7+aPcLcsa/iDGJpruL9e4
        PMh/INx3o2hec2y0e9LXfHaDq8hEuOk=
X-Google-Smtp-Source: AGHT+IHyJ+QAJz1h2mvwQ2WSccylRvYc+4pKIW90ov3zJOM4ygMazi1XZJEemtdcOEzD8X4dYAO31w==
X-Received: by 2002:a05:6358:3407:b0:133:ac7:c84b with SMTP id h7-20020a056358340700b001330ac7c84bmr211739rwd.12.1691521017439;
        Tue, 08 Aug 2023 11:56:57 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-06-184-147-140-157.dsl.bell.ca. [184.147.140.157])
        by smtp.gmail.com with ESMTPSA id a9-20020ac86109000000b004054db6da1bsm3619276qtm.53.2023.08.08.11.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:56:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: oslat: Fix compile warnings
Date:   Tue,  8 Aug 2023 14:55:55 -0400
Message-Id: <20230808185555.53613-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix comile warnings in oslat

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/oslat/oslat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 99f86b858e33..4bdca643da72 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -220,7 +220,7 @@ struct global {
 
 static struct global g;
 
-static void workload_nop(char *dst, char *src, size_t size)
+static void workload_nop(char *dst __attribute__ ((unused)), char *src __attribute__ ((unused)), size_t size __attribute__ ((unused)))
 {
 	/* Nop */
 }
@@ -474,7 +474,8 @@ static double bucket_to_lat(int bucket)
 
 void calculate(struct thread *t)
 {
-	int i, j;
+	int j;
+	unsigned int i;
 	double sum;
 	uint64_t count;
 
@@ -493,7 +494,8 @@ void calculate(struct thread *t)
 
 static void write_summary(struct thread *t)
 {
-	int i, j, k, print_dotdotdot = 0;
+	int j, print_dotdotdot = 0;
+	unsigned long int i, k;
 	char bucket_name[64];
 
 	calculate(t);
@@ -536,12 +538,13 @@ static void write_summary(struct thread *t)
 static void write_summary_json(FILE *f, void *data)
 {
 	struct thread *t = data;
-	int i, j, comma;
+	int j, comma;
+	unsigned long int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", g.n_threads);
 	fprintf(f, "  \"thread\": {\n");
 	for (i = 0; i < g.n_threads; ++i) {
-		fprintf(f, "    \"%u\": {\n", i);
+		fprintf(f, "    \"%lu\": {\n", i);
 		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
 		fprintf(f, "      \"freq\": %d,\n", t[i].counter_mhz);
 		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
@@ -568,7 +571,7 @@ static void write_summary_json(FILE *f, void *data)
 
 static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
 {
-	int i;
+	unsigned long int i;
 
 	g.runtime_secs = runtime_secs;
 	g.preheat = preheat;
@@ -593,7 +596,7 @@ static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
 		pthread_join(threads[i].thread_id, NULL);
 }
 
-static void handle_alarm(int code)
+static void handle_alarm(int code __attribute__ ((unused)))
 {
 	g.cmd = STOP;
 }
@@ -839,7 +842,7 @@ void dump_globals(void)
 
 static void record_bias(struct thread *t)
 {
-	int i;
+	unsigned long int i;
 	uint64_t bias = (uint64_t)-1;
 
 	if (!g.enable_bias)
@@ -858,7 +861,8 @@ static void record_bias(struct thread *t)
 int main(int argc, char *argv[])
 {
 	struct thread *threads;
-	int i, n_cores;
+	int n_cores;
+	unsigned long int i;
 	struct bitmask *cpu_set = NULL;
 
 #ifdef FRC_MISSING
-- 
2.40.1

