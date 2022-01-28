Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC20C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiA1SAe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbiA1SAe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 13:00:34 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF23C061714
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2022 10:00:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o3so5812271qtm.12
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2022 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoXkeZT3F5+6s5FBvtXdSYvKvr1RrsIYj66U4cRFxxg=;
        b=bbg68uv9se1+yg6DFbK9Tleh7iUG5Zv9dwFql/6MSv5LYw29vXb2b6CUclvk+wn36s
         AvdzAwbV6FFvKAJC+snXfkuaWWnVmQYT11SLtaKcVkztfaO+eYN1Us4uwTyiww6xYqR6
         Qf7rj11Oote0ZRwAmiQ8IBkWg4IEA/G4jOsJJZKSIXIGifobe6l44tyQOYwDx8TN9GHS
         MCos4Z2SzoxtadDMBU2x6achSP+CLs9umg9N6S9wZFEaJGnIAsbwXeBm+J5C8WTfj4aq
         eneOhQMgfpdrLwhzzTU/5B2dddezzpaIl13HsVpbTpwd+yCwm/C+Mzb1Nzg+ovwSGsxA
         PVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QoXkeZT3F5+6s5FBvtXdSYvKvr1RrsIYj66U4cRFxxg=;
        b=WArgCFhWwuTenzoxvKSNdB6UOHHfsSMKKmvDONw+gC0/WH9avWypw2MPaL59hfuf2A
         L5eJgvk6Ga6HJcuUzPSJI+7nXK3eTGEkuPjhRkk4dzT5e/i0BNHtDfGCFP1xJrsRzFvw
         HrIyobWdbn6gYEowvg8ZRUhCfhH8QZwprsHaf5Gai7QRbkfNgwHFBGvxW8zP8G6070nr
         ASvRDdGMIrJJ0xe6FBTje+wwNnORlnZyLzbYHDeDCxjT8Qb0aFXciE1fBy4jz4qru8jS
         TVRxGSGisa+AY4ZDOxDULvhxPYay7OwpuK4A81OmfQnKJmrzKLYeYaH5oNPggvOOQPZo
         M/Nw==
X-Gm-Message-State: AOAM532xJYQg8bLmcfEYEdfS6KruFNoaeM/L/At31F5kw86+27XnCm7d
        kApB2mEMAQKugGVOm8qZ77Jv5TPDoTk=
X-Google-Smtp-Source: ABdhPJzlw0vHxlyA6U29kzFQQk0efnaebdw2eEKutqtjdo9wW/24N9Jjhz+I1mLDkgMcT1sfnhX9Mw==
X-Received: by 2002:a05:622a:1347:: with SMTP id w7mr4677356qtk.608.1643392832702;
        Fri, 28 Jan 2022 10:00:32 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id bl42sm1435656qkb.15.2022.01.28.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 10:00:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Fix parsing of affinity when there is a space.
Date:   Fri, 28 Jan 2022 13:00:21 -0500
Message-Id: <20220128180021.15239-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make sure that -a all and -a '+' are passed to parse_cpumask().
Currently this doesn't work correctly if there is a space after -a and the
string.

While we are at it, fix the message in oslat which calls
numa_parse_cpustring_all directly to say that.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 +++-
 src/oslat/oslat.c           | 2 +-
 src/signaltest/signaltest.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 490aedb54c03..c9ed9e08f6e1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1035,7 +1035,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
-				    argv[optind][0] == '!')) {
+				    argv[optind][0] == '!' ||
+				    argv[optind][0] == '+' ||
+				    argv[optind][0] == 'a')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 50ddc81463ea..aa0e9a79e3b4 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -850,7 +850,7 @@ int main(int argc, char *argv[])
 
 	cpu_set = numa_parse_cpustring_all(g.cpu_list);
 	if (!cpu_set)
-		fatal("oslat: parse_cpumask failed.\n");
+		fatal("oslat: numa_parse_cpustring_all failed.\n");
 	n_cores = numa_bitmask_weight(cpu_set);
 
 	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 4d89a1aba9d9..1cf03931b5bf 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -261,7 +261,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
-				    argv[optind][0] == '!')) {
+				    argv[optind][0] == '!' ||
+				    argv[optind][0] == '+' ||
+				    argv[optind][0] == 'a')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
-- 
2.34.1

