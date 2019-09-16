Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6165C4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB46214D9
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6RtWs3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfIPVvZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:51:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47085 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPVvZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:51:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so1724656qtq.13
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2019 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeUh1q60196Av/tEpV5NrhwwxIIZWdHZglCZzL3O2U0=;
        b=P6RtWs3sltlrsvNNB8bYBzycA8VUppgShcV9IMN0dW67ftrvNWipt9aQu6oioKHEt4
         rMe1lxDoGvBwKHeyX+KoWP2uqwK6X4jqFfspPAhenUHOMI92Q6OJc7ISDlu3yZ9+TFgv
         RvgMcY+2lq2V0ROAiIu/S8TEOSuEEgtnmtfruL7RuDIu2BtYel5eEOYnZLgU88V9xewh
         r1/yI25eNmM3z6RQI49QS6TlbSMBCNO1eSUPCo6JkMzSnWTIAn0j0DlpowIm5M9Hnegd
         VDwT2iOZE1SgY2hR4VBqLk1u/mGpBqEJpzwxvJiFSYPybyfDvAloVEbuEwnkkJTily36
         mwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XeUh1q60196Av/tEpV5NrhwwxIIZWdHZglCZzL3O2U0=;
        b=Po5KMUzQD0VKd2uAxMmmx6Nbgra8vVLcV3gV9DMN7YcPSGl36I/iOOFqG6dSFwQ0HM
         jAEryvGsq4hl2b0RklYuX8H4BllKpgTo2rE7s1tU1iT0vHOAV3KmO1slqRce+lI+rhsm
         FQd3kAB+W24+yw59EIuiXceQOFEChdX5Yk4xAZ7qbvXeorDAhCwIxdXB6w1AzBoUHEox
         m1IAIVxA21vp8kAuz1Fz8LcExKcUUXbwR3pVcebl33o2KjX2096Fb/hwr8B3jtrRPhAu
         cF6WGjZ691N0oI3odWHtIPoUnIXAk07ujY6QJPUzERVyiJ+cUgjk5J9QRZhZMvi1aCVF
         YrLw==
X-Gm-Message-State: APjAAAVp1jN+ifFF++8DGzMzKytu8t44OVTwibfvx0Q7LpvkNpBQ7FjI
        4RLxsgljwdlHVSWumvVgwFE1hUYjxPs=
X-Google-Smtp-Source: APXvYqyXKlWh6k9SItEDUNhGSdF73ITUS/3+Pzg+v9DuBgPzZZCnDpZK134LYywCbexJ1b0Itv3JLQ==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr571885qti.377.1568670683686;
        Mon, 16 Sep 2019 14:51:23 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id q126sm120156qkf.47.2019.09.16.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:51:23 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/4] rt-tests: cyclictest: Make tracemark work correctly again
Date:   Mon, 16 Sep 2019 23:51:09 +0200
Message-Id: <20190916215111.10193-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916215111.10193-1-jkacur@redhat.com>
References: <20190916215111.10193-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

commit f5ccfbe4d6641e48f56152be135d901dd31cba7e
was a little too aggressive removing ftrace code.

We were able to remove ftrace code because this functionality is
available using trace-cmd, in conjunction with the tracemark option in
cyclictest. Put back the parts of tracemark needed to make this work
correctly.

After this patch you can get tracing info like this as an example.

trace-cmd record -p function ./cyclictest -t -b100 --tracemark

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 52f93da7d074..45b6041ec1c9 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -184,6 +184,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
 
 static int shutdown;
 static int tracelimit = 0;
+static int trace_marker = 9;
 static int verbose = 0;
 static int oscope_reduction = 1;
 static int lockall = 0;
@@ -400,6 +401,9 @@ static void debugfs_prepare(void)
 
 static void enable_trace_mark(void)
 {
+	if (!trace_marker)
+		return;
+
 	debugfs_prepare();
 	open_tracemark_fd();
 }
@@ -1167,6 +1171,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"spike",	     required_argument, NULL, OPT_TRIGGER },
 			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
 			{"threads",          optional_argument, NULL, OPT_THREADS },
+			{"tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
 			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
 			{"verbose",          no_argument,       NULL, OPT_VERBOSE },
 			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
@@ -1343,6 +1348,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			fatal("--smi is not available on your arch\n");
 #endif
 			break;
+		case OPT_TRACEMARK:
+			trace_marker = 1; break;
 		}
 	}
 
-- 
2.20.1

