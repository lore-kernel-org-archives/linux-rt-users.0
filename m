Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05651C48BE6
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B7861040
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhFPXU1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhFPXU1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 19:20:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD6C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j62so1244077qke.10
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+gBQQ/BHTtsPUVKWMCTwc1xesU1mpitQwr7D2X51uHM=;
        b=vh5ztsio/1J0A91F+jZxOuY36GKvZ39GG/7aiiqJ5b18NDCs3DjypzLs9YvokmfavE
         UXvEegXlD8Pc1E05B3MT0JiR4sLDxlpji5+nWwS4G/QVvFRsA+xkx8IXbUGD9QifcJpC
         eSNwCxyfvYf4Bi4gjWrD7kEl9gMM+qIts/S4059r7IU/R0rG6k61WZ0gHFH/VS1A2tnV
         04bDKOOGruqN7HEiHX8I88qWmQbDr9KZgNV5S9MPkYUhpvZ85U+jsHEzEkp2WBB9KH/t
         qCQ7HSw0euBZk3FzQQbkNFYczMchPJ3dLOLX0gGC/w6LqLYDErDTFdYku0LtPdxH6g2L
         nqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+gBQQ/BHTtsPUVKWMCTwc1xesU1mpitQwr7D2X51uHM=;
        b=fDiPLjQCwawT95gDDvTybP05h+OL7LsC3XwZ0G9RzpysaZZ1ot4Vsrn+fy5XO8AypH
         vrPRmebRDcRI4tsfk9iumevAyPVGuIl+7iW2gf61yzwiH2JKef3Z3wZ7QRFvmH1Tcd9o
         qSgJfDQ9dvuGSuijTVwr/++rNrFcTQ8CHFeqjbU8SRZGsmXellF5yLM0lcCMHkBpFhIu
         J27rCYvPgRWqnhmlr/FxlgKqQA3zmP0vZpkQ6iQiwCWtrp+X67oZXiYeAwz9sYYNR7Lq
         56Kbyqav9KGp1pkXSKbZKmO+iV6MBkLc3k5xx4YXFWNiUYG+B68JT7Vu6t27vdn3Ngqy
         1k3A==
X-Gm-Message-State: AOAM531c1rDlGJvdReVmLmmeJfbFx90JJRC1e95qzlyBMf/ErRpGNxDS
        n7ZdCelSog99xVsEV98IuJgcf7Y3xVdsGA==
X-Google-Smtp-Source: ABdhPJxS3fi8Q6lYdzlGJW0cVNPzDmQCOUe/08x2LJsBwGU7ZvGBn6jEG+K/ppCZ63WXFI91iPBXMg==
X-Received: by 2002:a37:8105:: with SMTP id c5mr836240qkd.448.1623885498383;
        Wed, 16 Jun 2021 16:18:18 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id bj39sm296588qkb.78.2021.06.16.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:18:18 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Jonathan Schwender <schwenderjonathan@gmail.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] cyclictest: Move main pid setaffinity handling into a function
Date:   Wed, 16 Jun 2021 19:17:58 -0400
Message-Id: <20210616231800.19228-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Jonathan Schwender <schwenderjonathan@gmail.com>

Move error handling for setting the affinity of the main thread
into a separate function.
This prevents duplicating the code in the next commit,
where the main thread pid can be restricted to one of
two bitmasks depending on the passed parameters.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a561443fa67b..edb0c707d35c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1768,6 +1768,17 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
+static void set_main_thread_affinity(struct bitmask *cpumask)
+{
+	int res;
+
+	errno = 0;
+	res = numa_sched_setaffinity(getpid(), cpumask);
+	if (res != 0)
+		warn("Couldn't setaffinity in main thread: %s\n",
+		     strerror(errno));
+}
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1792,13 +1803,7 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask != NULL) {
-		int res;
-
-		errno = 0;
-		res = numa_sched_setaffinity(getpid(), affinity_mask);
-		if (res != 0)
-			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
-
+		set_main_thread_affinity(affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
 				numa_bitmask_weight(affinity_mask));
-- 
2.31.1

