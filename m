Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DBC3F2CD
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D997522B48
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO6v6VaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCBVop (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38272 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCBVop (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id h22so1345157qke.5
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOXWbjewEO+rKGzZvC3BmBn3eLH2C0clMBsSZRxkgk4=;
        b=NO6v6VaXKbz5jcYWqZOGBWVs7Uv38WvRERWNmptaCSuXGFKdd9qPo4Kj/+GYD/gYlY
         l87bE678lwYxuBdUSqbj5njTir7Z4F9XB3MYSW2ORPTIUQLmhlZhayyFBFOp+bRhha8p
         ZpvGDHm24QoNNp+X2cSoKmNzS92O+Pw8SlVCwbFY8ZccnN53kJPrhGGePEJh0vDjGxZc
         eszvbYlPoB4ABrrGhYVM9Pjct0PUGpz0flAH7mOqH8KR4UXaJ8gReij+BzdjN6BKVVz3
         /3cykx5wztJljU1Rphjl0Hy5hZxAv3yawmES6w3ZmATtwKmSxHDDay5I7maP0eFbgUsw
         VD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yOXWbjewEO+rKGzZvC3BmBn3eLH2C0clMBsSZRxkgk4=;
        b=CQX5blEttUP+YYfw65HiJW8lFy64WZ0YgiteM7MtXzYLDDytNv0mkph15cFDUVVDWq
         O9/hlFFxgN0pabAbrZYEM1YgGVnyoy5EqmbyBW9rumpVj8n+ahvABbNSrHacEn/1DGfQ
         6ATJQN28FXyyCOGAcWXJE19CZPS8f/N8p7dKmfSlaA6YBi7pEKUI+6L3gzOcTKSxmNrd
         N9qqZ8DLFLKkRVV0PPdwj2zbYTiAIcK2+GcINlUjMt1SnUW8f0TJ1ndduCC/I+sNoFrO
         pgzcJ1CF3ZtKrKqr31PyJHZzafUKYKiar/QdWsdRt89fSAPq1Q0L8zBj+LwP0SzUQgXy
         Rl+w==
X-Gm-Message-State: ANhLgQ0SDndR/7ZZvOSR3Y0pDpAsAqzCnSmKaj6BWH9smhrG66dQ+qjR
        pfnIu3QFG6pTbU2AzVGegKnnTF3StLY=
X-Google-Smtp-Source: ADFU+vvZZfhs1egQAsH76tmE80/Il9CpkVfeVPbxlrUxQTC+4N1e6L9DkgerCeX+SqICkJa9orRVpA==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr1261622qks.235.1583185484112;
        Mon, 02 Mar 2020 13:44:44 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:43 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/6] rt-tests: cyclictest: Fix parsing affinity with a space and a leading zero
Date:   Mon,  2 Mar 2020 16:44:27 -0500
Message-Id: <20200302214430.15825-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

-/cyclictest -t -a1-4
./cyclictest -t -a 1-4
./cyclictest -t -a0-4
all work as expected, but
./cyclictest -t -a 0-4
did not work, and instead AFFINITY_USEALL was set.

This is because atoi(argv[optind]) returns 0 for parsing non-numbers,
and this was treated as an error.

This missed the case where the user intentionally passes a 0 which
should not be treated as an error.

Fix this by testing for this case.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index bd1fcd1092aa..1d2962fda777 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1199,7 +1199,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (optarg != NULL) {
 				parse_cpumask(optarg, max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && atoi(argv[optind])) {
+			} else if (optind<argc && (atoi(argv[optind]) || argv[optind][0] == '0')) {
 				parse_cpumask(argv[optind], max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
-- 
2.20.1

