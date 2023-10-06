Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8038F85
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9JeawYI"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA7C2
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65cff6a6878so13047436d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617697; x=1697222497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCo+VAC9PwDLYkyqKPIGVCxN4gBvz03tRiGbiNIndZQ=;
        b=N9JeawYIUD6+UKSpzgKpscXao81kNsSKxjo/OAQB5GtvQPlXjALBrcHqjK+1WtH6NZ
         Tk/qyWmXjXUq7dmN2Kc4m5klwde0Ak+hWd0Q88AZC/0I8WxXkZZmxwFz3eLIXce0+9eb
         U7qdpjX/mvVScoqF065Ih1fRbUa9UK+YBzCCd6C5folphIW+a36V62v1Tb5Ud2hGfvHd
         vexxNQ+CYSypV4drDCj6jnMJa9rtlAwcVS8c9/c5LBRVn7shAL72yRF0xVQht9EYt8H4
         umkq8IoyFcTrQvmmexAOlmGBTiIjZ9IrL8rynZkMiUPyvPf1WJQpsGvqwU1Bl3Cqodl2
         nmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617697; x=1697222497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCo+VAC9PwDLYkyqKPIGVCxN4gBvz03tRiGbiNIndZQ=;
        b=rC4sbuCOlPEeRYR+fy9E3cmO36rFNPrC+74u0K7OtIvwAltom+BpM/OfT22xaUu1La
         +2LT8K/ilRzBPWrnfm128qphPAiOX50Ex2SjYYyjJKaTRFg0R0qzQ0T39xAJkpB1iYRj
         2O7mMAk+JurB6cIvcqGzFuEEmiVa85dhd25motfB0Bc0GNcLjjC4v+6QGIRSEQXWPpm0
         J2CztSJYeLXtzU4aDEuVnqwJ/a2u+77g8WgCUs8edmoPnjkHjxqPybyvAwwF2JvNFEH6
         kUQxDgebhmF5IUpvJkkYVHyJn7cl079Aov4HLOAZCTLn/7VaGZ/XX8BcVx0MHVGvNcj2
         5LLg==
X-Gm-Message-State: AOJu0Yw9RQnJKJVgHT5zqHlnuwn4JZF2z2jybR9tFAJt+Z+IOuGFRLAx
	CVJAksvsaRTVOqKwJlMmwdFrR5G0yiQ=
X-Google-Smtp-Source: AGHT+IFhz/DoCrJq29v2KkzAtKNRBDiIxCW+OGhlfHqUSL5IWIgpj7AJ5Pc2lqnrIlg8RQacbR9HhA==
X-Received: by 2002:a0c:e20a:0:b0:65b:8ce:1bd4 with SMTP id q10-20020a0ce20a000000b0065b08ce1bd4mr9420552qvl.51.1696617697236;
        Fri, 06 Oct 2023 11:41:37 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 15/17] rt-tests: pi_stress: Fix various warnings
Date: Fri,  6 Oct 2023 14:40:09 -0400
Message-Id: <20231006184011.26699-15-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184011.26699-1-jkacur@redhat.com>
References: <20231006184011.26699-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix unused parameter
Fix comparison of integer expressions of different signedness
with casts that are safe because the parameters are first tested
to see if they are less than zero

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 9ce7d66751da..673a7bb472d8 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -505,7 +505,7 @@ int pending_interrupt(void)
  *   1. report progress
  *   2. check for deadlocks
  */
-void *reporter(void *arg)
+void *reporter(void *arg __attribute__ ((unused)))
 {
 	int status;
 	int end = 0;
@@ -637,7 +637,7 @@ void *low_priority(void *arg)
 		   We can't set the 'loop' boolean here, because some flags
 		   may have already reached the loop_barr
 		 */
-		if (!unbounded && (p->total >= p->inversions)) {
+		if (!unbounded && (p->total >= (unsigned)p->inversions)) {
 			set_shutdown_flag();
 		}
 
@@ -766,7 +766,7 @@ void *med_priority(void *arg)
 
 	pi_debug("med_priority[%d]: starting inversion loop\n", p->id);
 	for (;;) {
-		if (!unbounded && (p->total >= p->inversions)) {
+		if (!unbounded && (p->total >= (unsigned)p->inversions)) {
 			set_shutdown_flag();
 		}
 		/* Either all threads go through the loop_barr, or none do */
@@ -891,7 +891,7 @@ void *high_priority(void *arg)
 	unbounded = (p->inversions < 0);
 	pi_debug("high_priority[%d]: starting inversion loop\n", p->id);
 	for (;;) {
-		if (!unbounded && (p->total >= p->inversions)) {
+		if (!unbounded && (p->total >= (unsigned)p->inversions)) {
 			set_shutdown_flag();
 		}
 
@@ -1449,7 +1449,7 @@ void summary(void)
 	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
 }
 
-void write_stats(FILE *f, void *data)
+void write_stats(FILE *f, void *data __attribute__ ((unused)))
 {
 	fprintf(f, "  \"inversion\": %lu\n", total_inversions());
 }
-- 
2.40.1

