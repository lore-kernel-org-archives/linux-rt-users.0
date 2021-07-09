Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600EC07E9C
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F39E61378
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhGIP5D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232248AbhGIP5D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 11:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625846059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BRUbN9J9L07NYfOeKSnC9Fbrzqk3LLgcvVXVMldcrY8=;
        b=Shctnz1BQzvCGBrtZF+fuM9jtAk1MBrMBQgjeI75mgSMmoLgWmWz90nUAeZclpRfCILV36
        hlX4pu4bXywXEpUMUewL++TfmTPOj0BX4iFO/LiZeTU4iuebnQqJrhu5zUjw90JWJWzvXB
        PyXh3VK9CsZQYnAmfMvqPvF21i3M6dc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-IaUJYZvRNMC6tZImuaZ5qA-1; Fri, 09 Jul 2021 11:54:18 -0400
X-MC-Unique: IaUJYZvRNMC6tZImuaZ5qA-1
Received: by mail-wm1-f69.google.com with SMTP id i3-20020a05600c3543b02902075ed92710so5344082wmq.0
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 08:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRUbN9J9L07NYfOeKSnC9Fbrzqk3LLgcvVXVMldcrY8=;
        b=udu38MeE8LLlcdncPD5Yei8tQiAtTpkEJ2nVVJ9CXAI/1kCS2+Fkm+Hf+N+VAqx1ip
         T4SzegT7lGuQ9gi1ZM+d3L9A3EWwropOe90zehhQ4kX5XKnYHSoXu2zrEeMx27ZXkTbg
         ZmoAd05eZE8f+azWXtSAvUtzvHFpEaHZWyESESB0xnRFxvutz9huA0d6ngLAh5WGLcUw
         n4eZ3vcaGchNl7WtsTfRFaPKi5giWp2plTFRkWP3ntQDL6uxWl6/dkePxycRxauVoDGz
         v0UN2xDOpeXiT/BpQIQ/pJi7xNAxw8CcRgkKKvjJqj/OOGCstXV54FL7O5Z5TX7YoMhI
         vpaQ==
X-Gm-Message-State: AOAM5312TOgY2c2V04aLTDj0fQ6cYPuY9+LqKzjxARtvRDs9sQVcT9nB
        c2tuoo0EBgvfqkcfR/lxNwJmcOS3XjKk9PuPVipMFL1Zo7DCD76dIux5GBI3KNcpWfpAATfVd5o
        rozenTKqfIw7b8P+TERp0+hNiDAY+7W9H+u+3SGVi//ROZD9R4rG37hUdgASlIb9858rodwRa4G
        BPFRU=
X-Received: by 2002:a05:600c:4841:: with SMTP id j1mr4825346wmo.88.1625846056803;
        Fri, 09 Jul 2021 08:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlbKA0g53S1WK3mhy1sO/XEmJxSlO5zAT1k7bLM+7hZNuJzg5JpDsWhmKbU5E5UCCnLHY0qg==
X-Received: by 2002:a05:600c:4841:: with SMTP id j1mr4825326wmo.88.1625846056561;
        Fri, 09 Jul 2021 08:54:16 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id n13sm5094305wms.4.2021.07.09.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:54:16 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 1/2] rt-utils: Add option to avoid stopping tracing in tracemark()
Date:   Fri,  9 Jul 2021 17:54:13 +0200
Message-Id: <20210709155414.610308-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Not all users of tracemark() might want to stop tracing after printing a
mark. For example, if leaving a mark during a test. So add an extra
argument to tracemark() which avoid the stop.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/cyclictest/cyclictest.c | 3 ++-
 src/include/rt-utils.h      | 2 +-
 src/lib/rt-utils.c          | 6 ++++--
 src/oslat/oslat.c           | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a08c91d..1f3c5a2 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <getopt.h>
@@ -722,7 +723,7 @@ static void *timerthread(void *param)
 			pthread_mutex_lock(&break_thread_id_lock);
 			if (break_thread_id == 0) {
 				break_thread_id = stat->tid;
-				tracemark("hit latency threshold (%llu > %d)",
+				tracemark(true, "hit latency threshold (%llu > %d)",
 					  (unsigned long long) diff, tracelimit);
 				break_thread_value = diff;
 			}
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index f6b3fed..88d285b 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -31,7 +31,7 @@ int parse_time_string(char *val);
 int parse_mem_string(char *str, uint64_t *val);
 
 void enable_trace_mark(void);
-void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void tracemark(bool stop, char *fmt, ...) __attribute__((format(printf, 2, 3)));
 void disable_trace_mark(void);
 
 #define MSEC_PER_SEC		1000
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6c0235d..d8d1325 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -23,6 +23,7 @@
 #include <sys/utsname.h>
 #include <time.h>
 #include <sys/time.h>
+#include <stdbool.h>
 
 #include "rt-utils.h"
 #include "rt-sched.h"
@@ -458,7 +459,7 @@ static void debugfs_prepare(void)
 		     "debug fs not mounted");
 }
 
-void tracemark(char *fmt, ...)
+void tracemark(bool stop, char *fmt, ...)
 {
 	va_list ap;
 	int len;
@@ -476,7 +477,8 @@ void tracemark(char *fmt, ...)
 	write(tracemark_fd, tracebuf, len);
 
 	/* now stop any trace */
-	write(trace_fd, "0\n", 2);
+	if (stop)
+		write(trace_fd, "0\n", 2);
 }
 
 void enable_trace_mark(void)
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 6ff5ba8..d35be57 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -304,7 +304,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
 		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
 		    "Stopping the test.\n";
-		tracemark(line, g.app_name, g.trace_threshold, us);
+		tracemark(true, line, g.app_name, g.trace_threshold, us);
 		err_quit(line, g.app_name, g.trace_threshold, us);
 	}
 
-- 
2.31.1

