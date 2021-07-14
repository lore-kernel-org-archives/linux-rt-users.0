Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76373C07E9A
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564A861374
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhGNLKY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230339AbhGNLKR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Jul 2021 07:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626260845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jw/Bw7+fhcv6ZyYBXeHA425IaCFsEAcWaW/+V/LA8xg=;
        b=diWEMhmOS3jhcld1zRhqXsBwesr8Ak+opmVbnv4VvwBg51DONLeKeF5oYLlzmR4FcK4RlE
        1KQDVQaphEqliKztGag+ob+y9+xpd0UT2eMMVOT5q75D3DIp9ViUyHXjXulv9Pu45nCrS5
        my0FGCAYWZL3M0Aa9iMUOA92TE9/93A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-gJR2-TV-MDyjwC4dXW2rxg-1; Wed, 14 Jul 2021 07:07:24 -0400
X-MC-Unique: gJR2-TV-MDyjwC4dXW2rxg-1
Received: by mail-wm1-f70.google.com with SMTP id y6-20020a7bc1860000b0290227b53c7cefso639694wmi.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Jul 2021 04:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw/Bw7+fhcv6ZyYBXeHA425IaCFsEAcWaW/+V/LA8xg=;
        b=jyVo1AnCD7YL+vbDB0EVRTg5NN96nIP0mwI1ysnYayhKiRXKsQMKusne0RJ7Vef8th
         6cZ0AX8wcSQ6Uu+zb1A++FvTDxuvcWHQJ/7eKT7Uskb40foopLSvAmsT76Jn3c9Bid7+
         eaXazzzhgicrbrwyDMHm8g1lYIiG3RX1QWwJR0iIYND9rkAXSlSA7SUaJauHO9K0FRZP
         s7d4e2ns3/PB8ZGjoDS/oU3nE834e8reInamqMRuFEa4iVgXVAaplPUmwwBW+vAJges5
         fMJa9MpUBDj5f+TpbBgeKqDMYbpm4/SHcsH9g5an/LcoeW5jtn4zFRTopo+b7S+ixJsp
         IF1g==
X-Gm-Message-State: AOAM530cOS/pA/nJ45uVHFpKY/uqhbZQAExISCaa6rsjHxL1LW3iM4ps
        El0YadLM/49zrB6so0a2VcF9kLW/axNGyDvjFvc60yljtv8SB4KSxtSrkkGRsI8GSbIgsJXfR6+
        /PoEA4ckyRTSw/QB48+16ueCuNEqAMO0tossbW7el7S5EtI91QSPGjv87irvmNchScCi+mv6Qr2
        c+tm4=
X-Received: by 2002:a1c:a7cb:: with SMTP id q194mr10815741wme.159.1626260841148;
        Wed, 14 Jul 2021 04:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAwUfegysq3L20f5Kc9TNrOsj6gFfbvUAzihVakmJDKOEnLy/RnctAtzzeBk1//mPIyUxVtg==
X-Received: by 2002:a1c:a7cb:: with SMTP id q194mr10815719wme.159.1626260840947;
        Wed, 14 Jul 2021 04:07:20 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id d18sm2343690wrw.7.2021.07.14.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:07:20 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH v2 1/2] rt-utils: Add option to avoid stopping tracing in tracemark()
Date:   Wed, 14 Jul 2021 13:07:17 +0200
Message-Id: <20210714110718.68292-1-nsaenzju@redhat.com>
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

Changes since v1:
 - Add stdbool.h include in rt-utils.h

 src/cyclictest/cyclictest.c | 3 ++-
 src/include/rt-utils.h      | 3 ++-
 src/lib/rt-utils.c          | 6 ++++--
 src/oslat/oslat.c           | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

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
index f6b3fed..5b3d34d 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -3,6 +3,7 @@
 #define __RT_UTILS_H
 
 #include <stdint.h>
+#include <stdbool.h>
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -31,7 +32,7 @@ int parse_time_string(char *val);
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

