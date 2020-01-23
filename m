Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5ABC3F68F
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6D121D7D
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfUBT5tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAWUuw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45157 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgAWUuv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so3574934qte.12
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JW2tq+oy3DNsYVvIeb9Ni30zdXqPfmlzF6cBXJkGB+0=;
        b=qfUBT5tSPGbtcFIUDmk7THmBBcDqNTKjOjdPBAgkMd9VhcvE5UcLaN9rUPDgny4eyv
         1SveG7r/U3u/ZPxXIJ/BfKgvxY0JlWAsnZUfVTfEJfrgJ1IqdpFavqZth83TAgz6zdZE
         Bm4W1klodQi3eq1eJvYLtp3EG3T+aSNVBQnDxfohfZ9vn6l4HBDvVKeFU3l/Q3dDu9kw
         M0zH+nJuYRWrm1Bp+xck/l1vIBgZPQtyty72Me/oG19Yc8V/ie2pzYmN+9LgyVPdyC5Y
         YtqJoSTSQk9UhpH4XAB0u8rhc+Z/Hj4C6/LYdhCyNAFG3rVrByJTgopHZYSwFUhWXj+Z
         ACmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JW2tq+oy3DNsYVvIeb9Ni30zdXqPfmlzF6cBXJkGB+0=;
        b=PxQeXvgQ5juRY4scFMe/ScPPinqQ9ds+pvkx8lXoM5XlnA9dRmrd2OTLJfrGNQQSN3
         3TKpZpKwuzKEC/myrB3lmq/aLhrrCF3jiwwYu4CRWvgO/5nYzZ4Hm/5GGhZ6BXVktUoN
         4K1673v0lfLyI4H8o5T31LD4TYu7zLlglmGa+1azHtLa3TLWTWYnqHWzsxc7DFchqwVb
         i9nWB34GtlHSAV+hf2NhrkY0CK9XWWZAStM513t0Ysaz/ePGMcb49GuZotNqdmmcGEsm
         LEokna6XlWMJLQNDyL1T6SMyCt6xmIVglLUMDRFqMQGlrpO/TrP8qSS5u21lTPwjPpV9
         lXUA==
X-Gm-Message-State: APjAAAWwk2nH6EBy7yNU3ots9fdlW+ON/SJkI6I9007jMdezdK5r+5J4
        6PFWMQ/jSLKvbdcdC3AxVqafXfpx3PQ=
X-Google-Smtp-Source: APXvYqzsJ8bFi9q3ksY/IppjciN0Q2a2Bly1bmKdKtXTQUcHl6DmsRdjSCWnA2uCQeWA6GxcMXth1g==
X-Received: by 2002:ac8:6b17:: with SMTP id w23mr51299qts.170.1579812650548;
        Thu, 23 Jan 2020 12:50:50 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:50 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 9/9] rt-tests: svsematest: Display help with an error message for -h
Date:   Thu, 23 Jan 2020 21:50:29 +0100
Message-Id: <20200123205029.20176-10-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Display help without an error message if the user uses the -h option

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/svsematest/svsematest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7c15393fe1be..023a303fd7df 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -281,7 +281,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:St::h",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -335,6 +335,7 @@ static void process_options (int argc, char *argv[])
 			else
 				num_threads = max_cpus;
 			break;
+		case 'h': error = 1; break;
 		case '?': error = 1; break;
 		}
 	}
-- 
2.20.1

