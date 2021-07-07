Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD4DC07E9C
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721B361CC1
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGGIvj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhGGIvj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Jul 2021 04:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625647739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFENK5WQ8UlEYTg0ua2mP380GQt/Hv+MiOakB/8/2mQ=;
        b=f2WgOgFbLz+Z074h8uMbSSygu5LloPwWZ8JpQABoYqO9FV1ruK47P18/nfzWroINRNjS2o
        BSQwV9OP1E5D4vOInIZzr/+6dNs11KrLePXlK76Sa7w8EXLoGBKJ7RaIHYHSz3lXTiCthp
        sS3CmiLROlC1h/qAHlTkFQ5WmawR1j8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253--9q2R7pjMByjMBSZgtIq0w-1; Wed, 07 Jul 2021 04:48:57 -0400
X-MC-Unique: -9q2R7pjMByjMBSZgtIq0w-1
Received: by mail-wr1-f71.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so527678wrs.3
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Jul 2021 01:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFENK5WQ8UlEYTg0ua2mP380GQt/Hv+MiOakB/8/2mQ=;
        b=DQU5rYlrEnyAaJYrUpMM5ltRko1h2WcQUD19ZbxYcN5Ngb0tfNVW4RJQgbZhxvwVFh
         pP8VeGxb4yAz1X5dStdzyp5VyqPmRcWD9XBY+PDTUclQl81sYDXnEjE3W8nhHAP1weOf
         y1veQS8KV2f8BrzWv0XphP5evc88Jz1gilLCva02dxVugyhFdYEPtQpQoefTOTibaVSb
         80O5Vm6kR6ne/tyjkOQe7+wgU7eKwFDQjGkFkpKlzLdaPgZ8BMTREuCDWQXhP7tBOCsN
         oOgqBAlQWlxeONAAzKPxoETh5hOUfv49Vvl5+5/xznjs4KXBy4G4PO6V27I2RmUadpdz
         JclA==
X-Gm-Message-State: AOAM530yCn2/DmdW2gsFvlVNKpD9ici8YzRnqds0WvmGQLlGpDGN6iCd
        pWHrOUwAIL61np+3QZ9S40m0ErsJoBPyz9WKGCrwxHXr9rUKWnKEw7YGSSFohqXrjTfmYOTjjcd
        dwy8dmQeC+AidyD7Lfdz/oros7UL8CH7qDWERf8RdDixifACxSCJwEe2sym7KEOTyxQFeY7qxX5
        xL5L4=
X-Received: by 2002:a7b:c451:: with SMTP id l17mr24675371wmi.20.1625647736306;
        Wed, 07 Jul 2021 01:48:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCWVnYtQ4OBAVrxHlCZAsxunN8oXUdQdSuSWvoZQIdaZPJp/3eXEeDwIqwN0v833I5c9Wwsg==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr24675344wmi.20.1625647736053;
        Wed, 07 Jul 2021 01:48:56 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id k1sm5533390wme.34.2021.07.07.01.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 01:48:55 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 2/2] oslat: Don't take trace_threshold into account during preheat
Date:   Wed,  7 Jul 2021 10:48:49 +0200
Message-Id: <20210707084849.304329-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707084849.304329-1-nsaenzju@redhat.com>
References: <20210707084849.304329-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The point of preheat is to make sure CPUs are out of idle and running at
max frequency by the time the real test starts. So it's expected to
incur into extra latencies we don't really mean to measure. With this in
mind, it doesn't make sense to take into account the trace threshold
during that run. So don't do it.

Note that this has been observed in practice. The threshold would be hit
during preheat but not during the real test.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 1cba6fc..6ff5ba8 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -29,6 +29,7 @@
 #include <numa.h>
 #include <math.h>
 #include <limits.h>
+#include <stdbool.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
@@ -150,6 +151,7 @@ struct thread {
 struct global {
 	/* Configuration. */
 	unsigned int          runtime_secs;
+	bool		      preheat;
 	/*
 	 * Number of threads running for current test
 	 * (either pre heat or real run)
@@ -299,7 +301,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	us = index + 1;
 	assert(us > 0);
 
-	if (g.trace_threshold && us >= g.trace_threshold) {
+	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
 		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
 		    "Stopping the test.\n";
 		tracemark(line, g.app_name, g.trace_threshold, us);
@@ -515,11 +517,12 @@ static void write_summary_json(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
-static void run_expt(struct thread *threads, int runtime_secs)
+static void run_expt(struct thread *threads, int runtime_secs, bool preheat)
 {
 	int i;
 
 	g.runtime_secs = runtime_secs;
+	g.preheat = preheat;
 	g.n_threads_started = 0;
 	g.n_threads_running = 0;
 	g.n_threads_finished = 0;
@@ -846,14 +849,14 @@ int main(int argc, char *argv[])
 		g.n_threads = 1;
 	else
 		g.n_threads = g.n_threads_total;
-	run_expt(threads, 1);
+	run_expt(threads, 1, true);
 	record_bias(threads);
 
 	if (!g.quiet)
 		printf("Test starts...\n");
 	/* Reset n_threads to always run on all the cores */
 	g.n_threads = g.n_threads_total;
-	run_expt(threads, g.runtime);
+	run_expt(threads, g.runtime, false);
 
 	if (!g.quiet)
 		printf("Test completed.\n\n");
-- 
2.31.1

