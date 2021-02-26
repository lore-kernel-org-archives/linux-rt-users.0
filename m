Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F559C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Feb 2021 08:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1CA64E28
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Feb 2021 08:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBZINN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:13:13 -0500
Received: from mailout10.rmx.de ([94.199.88.75]:58144 "EHLO mailout10.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZINM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Feb 2021 03:13:12 -0500
X-Greylist: delayed 2045 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 03:13:11 EST
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout10.rmx.de (Postfix) with ESMTPS id 4Dn1jT14D5z31Xg
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2021 08:38:21 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4Dn1jS5Bggz2TRlK
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2021 08:38:20 +0100 (CET)
Received: from N95HX1G2.arri.de (192.168.54.138) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 26 Feb
 2021 08:38:20 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-rt-users@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH] all: Fix printf format errors
Date:   Fri, 26 Feb 2021 08:38:02 +0100
Message-ID: <20210226073802.9406-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.138]
X-RMX-ID: 20210226-083820-NfcGSbRpJWgK-0@out02.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

time_t is "long" or "long long" (depending on the system).  So it should
be safe to convert it to "long long", in order to get a consistent data
type on all systems.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 src/cyclictest/cyclictest.c         | 8 ++++----
 src/hackbench/hackbench.c           | 2 +-
 src/sched_deadline/cyclicdeadline.c | 6 +++---
 src/signaltest/signaltest.c         | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 157047837259..8a7784e645da 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1751,15 +1751,15 @@ static void write_stats(FILE *f, void *data)
 			if (s->hist_array[j] == 0)
 				continue;
 			fprintf(f, "%s", comma ? ",\n" : "\n");
-			fprintf(f, "        \"%u\": %" PRIu64, j, s->hist_array[j]);
+			fprintf(f, "        \"%u\": %ld", j, s->hist_array[j]);
 			comma = 1;
 		}
 		if (comma)
 			fprintf(f, "\n");
 		fprintf(f, "      },\n");
-		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"cycles\": %lu,\n", s->cycles);
+		fprintf(f, "      \"min\": %ld,\n", s->min);
+		fprintf(f, "      \"max\": %ld,\n", s->max);
 		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
 		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
 		fprintf(f, "      \"node\": %d\n", par[i]->node);
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 268c23233004..785b9c076256 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -505,7 +505,7 @@ int main(int argc, char *argv[])
 	/* Print time... */
 	if (timer_started) {
 		timersub(&stop, &start, &diff);
-		printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
+		printf("Time: %lld.%03lld\n", (long long)diff.tv_sec, (long long)diff.tv_usec/1000);
 	}
 	else
 		fprintf(stderr, "No measurements available\n");
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ed3c960d9916..1c66a227f156 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -978,9 +978,9 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < nr_threads; i++) {
 		s = &sd[i].stat;
 		fprintf(f, "    \"%u\": {\n", i);
-		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "	 \"cycles\": %lu,\n", s->cycles);
+		fprintf(f, "	 \"min\": %ld,\n", s->min);
+		fprintf(f, "	 \"max\": %ld,\n", s->max);
 		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
 		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
 	}
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b1a7e1db8302..b39e9d2a96d6 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -392,9 +392,9 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < num_threads; i++) {
 		fprintf(f, "    \"%u\": {\n", i);
 		s = &par->stats[i];
-		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
-		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
-		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
+		fprintf(f, "      \"cycles\": %lu,\n", s->cycles);
+		fprintf(f, "      \"min\": %ld,\n", s->min);
+		fprintf(f, "      \"max\": %ld,\n", s->max);
 		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
 		fprintf(f, "      \"cpu\": %d\n", par->cpu);
 		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

