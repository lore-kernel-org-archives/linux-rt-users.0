Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA72C32759
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F672084F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIR9wOPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHNNuZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:50:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfHNNuZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 09:50:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so9236550wrt.4
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vR4FqerVa4Ap7yDwY65szGk6AzxD7bJUBFE9ZI89pSY=;
        b=iIR9wOPeViDyrKc/bZi0Te22Gzye06t6yTLENaOnWqoxRuSboyGSxq8th7WPD7f4Mp
         qbMG+mbUGWAOq4fP+eiYParSXpGjtv6bjzKAy45EvZzwHaG/Od1p16RqMTsifEL5rLgu
         QvyO89oFGaKrO17yaazGtcLrZ8tjVl6PN8am0EkOngFCab5vv2R1iYCYGlnpPY096Z+h
         fpSGun9YS7wCx1OlSQggtGGrKOhErsg09vUxl3mTzrrbrWwtj7Z3UTFi4rgX9xBhJa2+
         2zr0t2vp8H0et20Re7N5DQ1mK/XguDW8yvqxorqpT6gNBAOE3yk88jYfoKQLbWmYpvGt
         Wozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vR4FqerVa4Ap7yDwY65szGk6AzxD7bJUBFE9ZI89pSY=;
        b=gBNmIrdshd9e4PKNZKI49Zdq/jdahnXjdWHepsxeTsgtL3m0k1bhrpCO07JqGDiL+H
         iGkMIJ+MCgaNQQcih5W459FTXeU5RIVSXz+dlWV6f8EEj70sHTkAHWLxLlD0xlKFNLzQ
         kXtawsWJ1DQ1dBIFH5XEZGflmYCT/GHCNNtUJq/bLnDbIVoi4Ica8gQTXDc8gxEvIQP5
         ZFXTzhDSvn7NpJiSeJpqLR1lSSDjFenREv8qA+fZdIaZbMK1tAXVQz8v99H6eIuXSowR
         iwFmGJ627ib+YJ+4ebD1EsmPfPl5VOiox1/ynGuwCAXy9Mg0N4LtkS0Hx5hiLv+LLSy0
         uyYg==
X-Gm-Message-State: APjAAAVahX4u7qcynaIKRtFfxi9tj59wAyzOh+uEb4xkuvh2H8Gvhv8O
        ZUYo8VG02qUJbwvWbtxBtTMvuNKv6Cs=
X-Google-Smtp-Source: APXvYqwTsxncX790+Es12JZZ4SJkWv5t8qGDRdCxfp4mO6aIWByjX1kRJVqgh+npx/TGjxhxMm5ylA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr28962292wrq.236.1565790622916;
        Wed, 14 Aug 2019 06:50:22 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id i66sm7837220wmi.11.2019.08.14.06.50.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:50:22 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclictest: Without -t default to 1 thread in numa case
Date:   Wed, 14 Aug 2019 15:50:09 +0200
Message-Id: <20190814135009.5954-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135009.5954-1-jkacur@redhat.com>
References: <20190814135009.5954-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Don't ignore -t num when detecting if numa support is available.

Also, don't be too smart about details in the case of numa support
This means, if -t is not specified then the default is 1.

affinity must also be explicily set.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 83f169d381b7..d101e3d14854 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1183,6 +1183,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'a':
 		case OPT_AFFINITY:
 			option_affinity = 1;
+			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
 			if (optarg != NULL) {
@@ -1345,15 +1346,11 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		}
 	}
 
-	if (!smp) {	/* if smp wasn't requested, test for numa automatically */
+	/* if smp wasn't requested, test for numa automatically */
+	if (!smp) {
 #ifdef NUMA
-		if (numa_available() != -1) {
+		if (numa_available() != -1)
 			numa = 1;
-			if (setaffinity == AFFINITY_UNSPECIFIED) {
-				num_threads = max_cpus;
-				setaffinity = AFFINITY_USEALL;
-			}
-		}
 #else
 		warn("cyclictest was not built with the numa option\n");
 		numa = 0;
-- 
2.20.1

