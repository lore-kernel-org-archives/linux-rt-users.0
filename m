Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD60C433E6
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6203C64E6C
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355259AbhCDAVt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388496AbhCCVKd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 16:10:33 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46608C061760
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 13:09:53 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z190so25606720qka.9
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2021 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ni9qriLzvOFY0ANaSXU6ay3PdyJQReUEQyenzpISPE=;
        b=I4+xV/RWtrLLd3rC9QgNDJeZi0ih6DWMM5FaSwFcn4xPvChn0F6tdUPSUwKo9nctc6
         4w0a0aOl9IA07XYQfLKPdmC+DX/MqbOZqQTLZGHriiPmhpypEsEj0IPTkpxHnZYBnhiu
         zxMg4xU37yqXnazMa4yEz1apnYoX5GRgXVApAn1Ptsu5iraAv6st0fQO3uKRrdyE+9Y7
         o3sUgnrd+2K380D4GdX+aqxIgMX0OQEPEWf90FwXiz5CGQMiSSkM3OYmwIlLw72wen7p
         5PN6AxMiJi2dFa0ZKoF4fYat5LHo/R4njFRU4TNywEQmXrEH5bwH/dHRpgpEkbeDJNVt
         tPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/ni9qriLzvOFY0ANaSXU6ay3PdyJQReUEQyenzpISPE=;
        b=RqgOVdet0dzR/NQ0+jwvOmSzJhqNMvauZ2ALj0rP+kOdCq8U748aik5XjizIYE50uK
         MLNS53v229UNIHlZGM1YYQoOVlMq0nLD1PAkshx8KnYjIEQLajq5ecg7LPQl82XNUa+p
         lCZN4j7xSXvRcB1j9ERCdK9swRVp136CbB8UlJVIskKGfRf/5sE8Kdm4631R5conQoHK
         qO7jM7ufaj1RfyvXcd+RL1pkeilKze9NkVbyl5nSyv3DHoGYqti8H/bPYV3EL33XkETp
         S7ooQPzgTn0WD2rMOALIw1Tt0caDtj9sGlCqJqGeb8MKbzCDvPYMPx8F6WyjdhDSLd0C
         5S4A==
X-Gm-Message-State: AOAM530xYOVtmUS/aCNl+3mTiQjH8JpS9s1vFvKEkYhcx09ZQ0IUmPMb
        LPxW54nrjr/Sta+pk9qdUaFfKMh1TCu6wg==
X-Google-Smtp-Source: ABdhPJy4JKR2x/E51AHmVG3eXzEI6leEksSIROVvCS9XoT2JYtMe7YEgBuTZHNasl5Qi+IofoMgF4w==
X-Received: by 2002:a05:620a:2216:: with SMTP id m22mr1026262qkh.73.1614805792308;
        Wed, 03 Mar 2021 13:09:52 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id r199sm11818764qka.91.2021.03.03.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 13:09:51 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: cyclicdeadline.c: Remove dead code
Date:   Wed,  3 Mar 2021 16:09:42 -0500
Message-Id: <20210303210942.15847-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In cyclicdeadline there is some unreachable code that was there from the
beginning. By inspection it looks like this change was the original
intention.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ed3c960d9916..33bac8cda898 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -560,13 +560,11 @@ static void destroy_cpuset(const char *name, int print)
 	sleep(1);
 	ret = rmdir(path);
 	if (ret < 0) {
-		if (retry++ < 5)
-			goto again;
-		err_msg_n(errno, "Failed to remove %s\n", path);
 		if (retry++ < 5) {
 			err_msg("Trying again\n");
 			goto again;
 		}
+		err_msg_n(errno, "Failed to remove %s\n", path);
 	}
 }
 
-- 
2.26.2

