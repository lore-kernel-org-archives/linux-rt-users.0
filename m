Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1348C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846ED20678
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEZ7t9Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfIQOYR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:24:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41531 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQOYQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:24:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so4174620qkg.8
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Sep 2019 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ve21N984p7LxgDJe4YyT8Y22JjZsnDiv9gIOiVokrJ4=;
        b=eEZ7t9AqJqZMU5SDhc/7B3bWMb/g2tjbX61fUE+wm1fuT/9QRqPMJa2PyqYknJLQ6q
         YS1SnKFR262iHhUkySgwRBddJDItCRXcGTelZHcHTf6NlD3JCb6UobMcy7knfSQgJag/
         CWcybo3No6qI4vfHMLdoFEH95n2MhxLCWfPltRo3Ek0ODwYBf5YsBbe9JEpW7LaBqOhe
         EQLusMq41txx1wQ/9uBfNCL6En7JAmUGsS2vehiF1mbtd+GH7Nx1XAJSZKduq3Hgs3/V
         q+idzYFWzpvHdO+uW6MPt1pj362X5bwue09zk/jPjy/5XtKsEi//2YNzakEyjUoDVAlD
         0BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Ve21N984p7LxgDJe4YyT8Y22JjZsnDiv9gIOiVokrJ4=;
        b=dciBStmR7EzBMC7A+IdUrI0nGw9uzLG0WxF+mlgO1lq734KHamPS5E/9/ZRdf/zVV6
         nZvwGH+u1LU5dash7lY7fBHmsU7Omm38rFBq8f5yZ05MkdnY0dYdUVESeLw8bdyetRzp
         bzd3AficbmSxTq6V9oMA7HDmL2dc7GnmzcsJ1jgwpShKBHcRrwiwQ9Xq1Qjj+ExzhFVZ
         uSu4rzJoqxd0pJBVHo5Chd4kUX+eEQ9rzYPvst36h2xeKXH1sPbjSt3aE5+HhCUGmueU
         MQ9UTZy03gDmYGxjmrZ4uEHUq+xT73xV1HNIE65H3n1F8pbUhWSMgnKYrDXy+rwe/Mjw
         AbrQ==
X-Gm-Message-State: APjAAAX61GBcMBXq2yntrygCWW9Cu8Nk3keFwNGRyVGEuWR5XiXWGEi3
        NKuDdjK9cedh0H1zMSISzqyEf/UIzGE=
X-Google-Smtp-Source: APXvYqyuiAFf7OIzEX8qPCFvO7nXM0tzd6yV7mPRLRBSuXwbbklLk5aPLrniGcMqevu228yEPybawg==
X-Received: by 2002:ae9:ee11:: with SMTP id i17mr1625267qkg.312.1568730254667;
        Tue, 17 Sep 2019 07:24:14 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id d16sm555040qkl.7.2019.09.17.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:24:14 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Subject: [PATCH 2/5] rt-tests: cyclictest: Make tracemark work correctly again
Date:   Tue, 17 Sep 2019 16:24:03 +0200
Message-Id: <20190917142403.4328-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
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

Corrected a typo
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 52f93da7d074..72fb35da3238 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -184,6 +184,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
 
 static int shutdown;
 static int tracelimit = 0;
+static int trace_marker = 0;
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

