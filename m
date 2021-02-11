Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B41C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D43764DE2
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhBKE1I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhBKE1H (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 23:27:07 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E174C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:26:27 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c5so3351361qth.2
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WPMH9cgjWuxpbmSzfebBy7LZncLZm7qmy2suqXS63w=;
        b=Gf8kuJPjLINOnQydgDwMuB4dlTA+M6PCoNrI8HjYKhDQb6rrcXn0LhaN9FJfYUB7st
         2jSziwE4vUo62EkNytFD5AeA2nLGWirBQmde6FxnLkvGrxCVPy7q9qhlD+2xpWrOV9rm
         Z5X/Jgke2tOIG4Yp4hu+KOlXxjdNNePjB8nAT8IGmViA6MFA8y9KVeWqYmiEl8jRYN87
         luVxtw2oOYxptrjeRmpxOwX1Ru8U3SS3iSgxbnvY5i2/SnFBUOTqAjj+cNAG+oj20cnd
         sj/Cb/BYlKczbpGrp5MiXzxdcC3S9EFl3+lqHWPdXHWYcM9FJQCPnwqiuOOZjv2o7klM
         j4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+WPMH9cgjWuxpbmSzfebBy7LZncLZm7qmy2suqXS63w=;
        b=XcZg7bY2+N6dG5OMb5WjwBwUpXjNSl3Rluwf8hXdd7lTFRG4SEHdvz+fj+EqsdQqwP
         U9ZdtWKiwSWOBeEy32lgmIfkZHVGoYN48qeTCaIw0ZxEk0F8LLY2MUKHKWpZFauLNwJV
         Kd/0DgFXE8dRPjFzGNvOJ3ZPnpXrsrW1Rorgo0k8WoRFNj8LLHBKypdr6CeIBjQm0YwX
         KHhfRUtHdX7mmLvhiQWRZ4iW7Mg5zW1OuJKPHtis9nYvWSliMRChSp41qPF5P9y/Bgyy
         s9Z1iAvTiTKtKh+I/iJRccQ5bUEDm52DHebxBDc3lrlu8CmjcqarSGdK3EhK22hSixBs
         7Osg==
X-Gm-Message-State: AOAM5318Xzn1nurG2bF0KzsCEFRIkwt8RrPJQGrsOc16846DKMcZrlbA
        qz3HyMmSc84jNbaJzUKovp2tpRtMWItZsA==
X-Google-Smtp-Source: ABdhPJxeAaBe2kpwuJC6hO/Rn+GXel0qiz0+2gK7IpsHiw/xTNOxgT5TvCCHcOM04ok0kqMEtyeomw==
X-Received: by 2002:aed:3103:: with SMTP id 3mr5990542qtg.120.1613017585906;
        Wed, 10 Feb 2021 20:26:25 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s136sm2954114qka.106.2021.02.10.20.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:26:25 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        "Reported-by : Peter Xu" <peterx@redhat.com>
Subject: [PATCH 1/2] rt-tests: oslat: print version string
Date:   Wed, 10 Feb 2021 23:26:15 -0500
Message-Id: <20210211042615.27231-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

During the streamlining of the command line options something went awry
with the version. The author of oslat wishes to always print the version
string. This allows us to just exit in the case of -v

Fixes e411219d27b1

Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>
Reported-by: Reported-by: Peter Xu <peterx@redhat.com>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/oslat/oslat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 5b7e0d5b5d5c..639381e75bc6 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -657,8 +657,8 @@ static void parse_options(int argc, char *argv[])
 			break;
 		case 'v':
 			/*
-			 * Because we always dump the version even before parsing options,
-			 * what we need to do is to quit..
+			 * We always print the version before parsing options
+			 * so just exit
 			 */
 			exit(0);
 			break;
@@ -736,7 +736,7 @@ int main(int argc, char *argv[])
 	g.workload_mem_size = WORKLOAD_MEM_SIZE;
 	/* Run the main thread on cpu0 by default */
 	g.cpu_main_thread = 0;
-
+	printf("oslat V %1.2f\n", VERSION);
 	parse_options(argc, argv);
 
 	TEST(mlockall(MCL_CURRENT | MCL_FUTURE) == 0);
-- 
2.26.2

