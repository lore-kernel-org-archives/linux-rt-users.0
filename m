Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457AC55179
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0722E2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erF07UGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgJ2RlY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgJ2RlX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C270C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q199so2629234qke.10
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3SF53m8V8qlEwJCfHBnJloWqF/+m7kpLihcx1RckBM=;
        b=erF07UGD5PYT396uslQ/DVWrm//K98nOQ2a3E/8so0Nb45Rcs/LAIcLpY6YfHxjHxt
         6jLN2bA+0bM14b6WyVOfBFug6ZeQrrPgBb6TfVAD43ugmBgrVkYaX3FKTqdwbroxRYQM
         HYRIB2KwavcdF9wKthQ863AcBrNltLnOqtB2nBW6W+EEy+jDO4xqEKcWmwU9XrIMckG2
         uNSJ/lV2lgKO+rxNn1tae/gBea+NKEWi+YFaar3IuOM/l9eKDuGfEG4HgPjIKhgX/st5
         XlFdVlV16rRKBmv9XFKZy/FTp6FhjprEKYT5jLjA8S1HP5hPv/oFyncGnfHxTgxlG+fa
         E0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z3SF53m8V8qlEwJCfHBnJloWqF/+m7kpLihcx1RckBM=;
        b=fFTNS9yUHKEMmUh9vZacFs9Y931dMGvKnZkX42yxWz3IGQ8wInu/3MZxqvhB68/dn5
         f5d/N6HX63vMol01SahDVM+Zx5UdL+Kbqw/FztKkNzDzA2fJzYdMvcWsJIZ7kh1MXnUQ
         tE2KcM4jddtbibAQjZyABPIQX97tLz1yCv+QzRWUp7YaJsbqLzsaR+ei9UlTwnMoFQU0
         9kZ2JgCyzrZ6bnLFamGW/0jyDG00lDemXsEjlUDluI6jNlO4DYy9JcXTvEnUHEHV1eb9
         RDOD2UjTT/JimrWIS2LDTdN9NY7Cw+dZFJ66kgJey4srDNymCP3ynGl41AfjE1B9k6JU
         52mA==
X-Gm-Message-State: AOAM530bPsMmF1miQd37pUeMFWBMlcdgiu5Uk7jYyKTjxHt5+vmQ0KKN
        kuarjQRgbbjqeyHfNsZl56B1bn5/3aEDbQ==
X-Google-Smtp-Source: ABdhPJxv1tL83UbdVZme92FGQpW2RmOmh3r8mODHJN6DAr+2qHy7pETxqS4qQWU0QCYpJqIf1ixV1A==
X-Received: by 2002:ae9:e708:: with SMTP id m8mr5011812qka.296.1603993282413;
        Thu, 29 Oct 2020 10:41:22 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 10/16] rt-tests: rt-migrate-test.c: Fix spacing around parentheses
Date:   Thu, 29 Oct 2020 13:40:51 -0400
Message-Id: <20201029174057.20033-11-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix improper spacing around parentheses

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 68824606faf1..f1b7e5e4fe8c 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -552,7 +552,7 @@ int main (int argc, char **argv)
 
 		nanosleep(&intv, NULL);
 
-		print_progress_bar((loop * 100)/ nr_runs);
+		print_progress_bar((loop * 100)/nr_runs);
 
 		end = get_time();
 		ftrace_write("Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
-- 
2.26.2

