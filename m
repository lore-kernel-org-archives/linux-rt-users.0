Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3AC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636B464EAA
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhBLRaQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhBLRaD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Feb 2021 12:30:03 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28AC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Feb 2021 09:29:23 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c5so166157qth.2
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Feb 2021 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSxGEZeNNcHz1m+Eii3sxLwgP4B+rh0OCkChvsFi5oE=;
        b=UFJasSuNDbakMQLh6d2HLnfd2PNc633XLLgJAG0GrLDrdE8suMGfJGry9L/3f+75pb
         ARnzZbPz9K1+YbhzVOUNHBJG42vRJQiGemtisHJ5MYCjVrT/UKZAe+mbUAZaxuYbtnjj
         iNzzTcUKZ/nG+RenThXkKsPYUbrXj8Z2rcBrfP3zQJklSbWESBgMWHhnO1E9hT6yc06N
         Trn7k4fbqbZLfbXYlbOSOkUov/0UrZTXFNHpVAl9xOH0ZgOSyvqvbfKEjLIYkx+28rqz
         62KmDYYVDTyYEvRtCSrT4PkSLGoNUl89YMXvlvyWBhBH0NbKHBjtdKKx+759KFDsU6iG
         3dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WSxGEZeNNcHz1m+Eii3sxLwgP4B+rh0OCkChvsFi5oE=;
        b=fkXFvD4ngHtBzs6I2puZexgZWxo0PwJAfsDmL/lsohzqto0Yie2yMd/TV78jCJVC6k
         iWoD5LTmGWXr0keMAyYdPl6kjD2TH4iPRlVj8Jr0vJL4EAi75tcSeByw02JDY/dtiJkv
         aGu44llYWlLonj+1k6p7C41Kr0JN4k1fmNqFvo622SwSXO7M9ip9ViSOseH3z4IbHSnU
         lQeI0Isp7dvBfA3EaJ8XRaHoBOvQJlHWoNOS+huGzKb16gF1umQQrExcfcJ0PFeqipHd
         H69MUweIMvGQLRdKqiZ1RVyhUAIYzAS/3FdHgzE3KezDM6o6doZz/di/kji4/JIMjJtZ
         82yA==
X-Gm-Message-State: AOAM531x2+gjjCvy1j3ktyj7UQhAzW/fKdcivivlCxR2IiD5heYZ8kAV
        /7+2unVecEB1H1XVZVqaI+VrEk14hWCrXw==
X-Google-Smtp-Source: ABdhPJxZ52LZpn9i3pNn1lYfQ2dZdb4bmM66yE7XZhvlbeiYzwhMfMsed2dkw3lpQ5d8cCl5xHMOgw==
X-Received: by 2002:aed:38a2:: with SMTP id k31mr3516403qte.187.1613150962784;
        Fri, 12 Feb 2021 09:29:22 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id g20sm5910833qtq.35.2021.02.12.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 09:29:22 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: oslat: Allocate memory for cpu_set
Date:   Fri, 12 Feb 2021 12:29:13 -0500
Message-Id: <20210212172913.10843-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- cpu_set is a pointer to a bitmask struct
Memory needs to be allocated for the struct, so call
numa_allocate_cpumask()

- use rt-tests fatal to exit on error conditions

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/oslat/oslat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 2fe550b3ee12..2a3be393a268 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -727,6 +727,10 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	cpu_set = numa_allocate_cpumask();
+	if (!cpu_set)
+		fatal("oslat: Could not allocate cpumask\n");
+
 	g.app_name = argv[0];
 	g.rtprio = 0;
 	g.bucket_size = BUCKET_SIZE;
@@ -742,8 +746,9 @@ int main(int argc, char *argv[])
 
 	if (!g.cpu_list)
 		g.cpu_list = strdup("all");
-	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set))
-		exit(1);
+
+	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set) != 0)
+		fatal("oslat: parse_cpumask failed.\n");
 	n_cores = numa_bitmask_weight(cpu_set);
 
 	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
-- 
2.26.2

