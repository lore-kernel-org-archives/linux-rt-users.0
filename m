Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E1C3F68F
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7A20684
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isjHGhtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAWUuv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:51 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:39325 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAWUut (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:49 -0500
Received: by mail-qv1-f49.google.com with SMTP id y8so2180605qvk.6
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjkWpJ9zCX9zWl/sGpAeKpZFP4O8jYudp8U4OY8rjAI=;
        b=isjHGhtcnD/A7a3kd5jeCkJkk9V4YVrjx6qcfQvnl4TLcW1bG5HKBdB8XhtHk78wOu
         kejf1ypJWzBqBKztCZiVfv/lgOWPTk/t9SWPojxTrQpdthqmnVL4AFazA1ot9k6+pAjw
         HscGGWg3mwQ7pDHapjdUmLXrQ0mqMb72JhGp6UA6ttRLI5iTRsMIB9VngmEkggHcln08
         C7xV7A27QZMBHzfcNWwa/og10q7+b78F4roIcW9ZShoVyvYSpdmgKVvMR4lsoTLiMBpL
         kIADtUOvbhvp3/HwF9mkl+jI4AoQtfVkMSPth/xhHa9MBV2wi62L+FE0iYI2wWfRDqjg
         9Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LjkWpJ9zCX9zWl/sGpAeKpZFP4O8jYudp8U4OY8rjAI=;
        b=LDxyc4JRx5E9sNyNuixRVn0wD1KdbKR5qMZRF59GVmJ1x2BkHCrKz3/yiyxEIyfK+1
         VSErsHfLFpw44oyb18nOemxTD1gqjGO09HiPoHZGSAatuOKyxhfUU/xcj1vF76OobDLE
         U/wMIBTXXTX383cdX53vron1Qd76V/INU8RFhVl9rQXBX9uktwSDweMqbzC9aoxbUdTF
         ug8ulmYkjbURDQ0Ug91fSXS/+mvcksXadFrCfWlQHyyhU7GdHwNuMrkReAQ+U1uLEicO
         ZDtb52tY1XOjcKfuGFR07kUBXGBchxrllyqTa518qC+WVKjY16eCjC/sBzHTeiiN4aVC
         DXbw==
X-Gm-Message-State: APjAAAXO7rcrJQnADl+3iCPdzGD1x2EXnunfWkENCYp6uZtv2per2Pz7
        c2LaFv2ECxJGs3RHdvoEV9BhX9QgTCA=
X-Google-Smtp-Source: APXvYqzMvaqLFPqKCRXlOfRkoKQ0I3m4CD5vCPIzuz0KK7QAojgKPbXrRCbAj40OID8tDICKv0U5XA==
X-Received: by 2002:a05:6214:6f0:: with SMTP id bk16mr18520267qvb.23.1579812648455;
        Thu, 23 Jan 2020 12:50:48 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:48 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/9] rt-tests: ptsematest: Update man page and add -h option
Date:   Thu, 23 Jan 2020 21:50:27 +0100
Message-Id: <20200123205029.20176-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Update the man page with the -s or --smp option
- Reorder the program help to match the man page
- Make the -h option work correctly

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.8 |  3 +++
 src/ptsematest/ptsematest.c | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 4bb1434babf4..8f76bca4b6a8 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -35,6 +35,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-p, \-\-prio=PRIO
 Set the priority of the process.
 .TP
+.B \-s, \-\-smp
+SMP testing: options -a -t and same priority
+.TP
 .B \-t, \-\-threads[=NUM]
 Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 78fa444c5578..485c991ec173 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -154,10 +154,10 @@ static void display_help(void)
 	"                           with NUM pin all threads to the processor NUM\n"
 	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
-	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
-	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	"-D       --duration=TIME   specify a length for the test run.\n"
 	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
+	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	"-p PRIO  --prio=PRIO       priority\n"
 	"-S       --smp             SMP testing: options -a -t and same priority\n"
         "                           of all threads\n"
@@ -202,7 +202,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::",
+		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::h",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -245,6 +245,8 @@ static void process_options (int argc, char *argv[])
 			else
 				num_threads = max_cpus;
 			break;
+		case 'h':
+			display_help();
 		case '?': error = 1; break;
 		}
 	}
@@ -275,7 +277,7 @@ static void process_options (int argc, char *argv[])
 		sameprio = 1;
 
 	if (error)
-		display_help ();
+		display_help();
 }
 
 
-- 
2.20.1

