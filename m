Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBCAC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C435861212
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhKKUpV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhKKUpU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:20 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A5C061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:30 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bi29so7064443qkb.5
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hnw/DVMpLbd7oTQxh+AdMBwH9ATxBNLi4VOmvW2vzgc=;
        b=CH0Z72FDTNskfIbX0oeXw3+AlEk7XGYiVKfIp7J0qNxUjsPWXnuAnd88uWuWSAwtxY
         NJXjN7JEBJ+c5jD0OyLtL6kGvE/GOZb+sb4VJKE3gEZ7xGb8O9gCnyZOigrNQ36HHP07
         hDX4oU23UNlGU6eYc3uenQ9eL2VaDPlAQ/m6XBHwPx8PyoLTJMkj/ePpDQlOgEVJbdFD
         MAas/7rzrhTrYyMdtZ9mdAGE0H3M0UbAM7mzyYyUdHn7IsMMK4EY4WNM80oj0sbLOkNn
         nt56Wnpq9zU1KQ4Kj4Q8TODOurW1/LuFrKBqqZ0YWt+uYj9OzDBg0VIycGRuEqL3TbCo
         yzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hnw/DVMpLbd7oTQxh+AdMBwH9ATxBNLi4VOmvW2vzgc=;
        b=2QtEfjoIkuSpRFe3OaoiOfLv3RLBCt4tbr7uXeim7ibuSPkMXtNIouRo4eb9wutnM8
         JEU1qHaTBckcIhVA6q44TN8ckDHrfVv8xPso9dqaKhrKkxWhSk66K0TgQCRTxZlmpl4N
         0gG8orUxmyyuO7pBmwbkHr3B5DEfJ8rRwmPCNGxVM8XQP2fbKZH6TXmIOYdTRluEptHT
         ka3pAA5TuZxx+maA4hytxSrjaUT2BSIzMOsiLRKTwHIHrd9kqebyWtidxwatPVR6h/C0
         ah19oZmX3rT1NMYxG0YphBsgKPODiOF9MPXPcSXas+CS9U1tkktR3w6ngpFvv5rJIBlS
         gwIw==
X-Gm-Message-State: AOAM533yNjB7hmkR6HqQ044O2OnerruBt0m8mL6Ydh6g0VlDCx3rzZM/
        cW/9D1RF5vtr/Mx4a1zVsqG0GhfQM54=
X-Google-Smtp-Source: ABdhPJy4bfDiW8o0MN6BzEDg2DfFizwfEnxVJy/56SKIwpAvMGAOFCgX7ETtAlDMY5tiWazACMXDJQ==
X-Received: by 2002:a05:620a:b4d:: with SMTP id x13mr8531849qkg.430.1636663349872;
        Thu, 11 Nov 2021 12:42:29 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:29 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 05/17] rt-tests: cyclictest: Check user supplies an value to histogram
Date:   Thu, 11 Nov 2021 15:41:55 -0500
Message-Id: <20211111204207.10167-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

histogram and histofall take a required argument.

If the user fails to supply one, display the help and exit with an error

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2187d98de725..e4d43481de97 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1089,7 +1089,10 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			histofall = 1; /* fall through */
 		case 'h':
 		case OPT_HISTOGRAM:
-			histogram = atoi(optarg); break;
+			histogram = atoi(optarg);
+			if (!histogram)
+				display_help(1);
+			break;
 		case OPT_HISTFILE:
 			use_histfile = 1;
 			strncpy(histfile, optarg, strnlen(optarg, MAX_PATH-1));
-- 
2.31.1

