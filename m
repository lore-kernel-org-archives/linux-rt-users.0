Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25674C33CAF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2D20704
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoMZchKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAWUuv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35605 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAWUuv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so3649099qto.2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vLYBYLeMfkKiZ4YnCaIIeIV6z0k5npsSK4dn5STCnE=;
        b=IoMZchKYAk+lLw0G+W87VvoAsv0znnZuT9zMQLDmU6ZlvhzoTLXrkavk9+RScozErE
         vl+LRhUrtwHOhrlmJS9tf3GcvMqKqNZyjKUl0qZGUbYVermhSApY3rAbeybUtE7zTVK4
         2bk+bFbqH5m28M2tO5xJEN2vs8XQTAS3d3KlRYc+D5HGyL8ULzV/RvxiCtVtju/WsCL1
         d1wU3Ov+/sg/9kGaGEdezQ9l+OVy3MyIpQijbskpvRkAdWHAFHWhi+jZuNKUMf9z9jBO
         s8yOUfNyDx+BWzXrbTyR0HaMoonDu2b0KJTPS8CrgGogLvTsdmn0eDSpzbg2aWDPE9Ew
         p5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/vLYBYLeMfkKiZ4YnCaIIeIV6z0k5npsSK4dn5STCnE=;
        b=rUch0tysULkvh0mrOzKZzDmB4bLZCua6jsVGfSinQzIIUpyPhtI1NT7hAeqwtq+tyh
         KvKDw/RW9z9DQXgKHPsJalZXv09tgU/QIhXuY2leZVVupyv2tQgzOsWeldTl7OTeaTkI
         /ECpOB5ecbnSNJeM6N/53ogUmahRE1b0xCwB++C0umxbhhMUCSWJl3k6fcWkbSGx810k
         HMfZHBsxkDHelbAhlHh4RqN6+EpfuZsqZOkRKgAoHFFa7xDETonmoSnNFm6VeNrqr8Xe
         Zmsj4Q2QZApNg4bvkIS8MfX2xYEwC4xrVIq23igkIHaVjZNOXCNmUJesIY9PBvHhXzZ/
         DE0g==
X-Gm-Message-State: APjAAAWVxtPAB8UcBXEMD0pkRLc8Fbu/vQCuxrO+LmdBOEPzrJuRyL5T
        n/RGD5io85F3rJs67r4AB59PC7jJYBE=
X-Google-Smtp-Source: APXvYqzKCJB5+BsryCMbwqFYRWI1fnw3bIJpCr2Kpo1/jpXazx18lCGBL6bOD3x3Rdk3YnAQeU8WwA==
X-Received: by 2002:ac8:604b:: with SMTP id k11mr30484qtm.372.1579812649760;
        Thu, 23 Jan 2020 12:50:49 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:49 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 8/9] rt-tests: queuelat: Fixes to man page and display_help
Date:   Thu, 23 Jan 2020 21:50:28 +0100
Message-Id: <20200123205029.20176-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Make sure that help is displayed and not just the message
"Unknown option" when the options are incorrect.
- Add -q to the man page and to the print_help()

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/queuelat.8 |  4 +++-
 src/queuelat/queuelat.c | 22 +++++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/queuelat/queuelat.8 b/src/queuelat/queuelat.8
index d68beb98bff7..f67a0bb7556e 100644
--- a/src/queuelat/queuelat.8
+++ b/src/queuelat/queuelat.8
@@ -52,7 +52,9 @@ TSC frequency in MHz.
 .TP
 .B \-t timeout
 Timeout in seconds to quit the program.
-
+.TP
+.B \-q min_queue_len_to_print_trace
+Minimum queue length to print in the trace
 
 .SH AUTHOR
 queuelat was written by Marcelo Tosatti <mtosatti@redhat.com>
diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 98346f346f82..7e5e35768a8b 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -571,6 +571,7 @@ void print_help(void)
 	printf("-p million-packet-per-sec (million packets per second) (float)\n");
 	printf("-f tsc-freq-mhz (TSC frequency in MHz) (float)\n");
 	printf("-t timeout (timeout, in seconds) (int)\n");
+	printf("-q min_queue_len_to_print_trace (int)\n");
 }
 
 int main(int argc, char **argv)
@@ -616,22 +617,25 @@ int main(int argc, char **argv)
 			return 0;
 		case '?':
 			if (optopt == 'm' || optopt == 'c' || optopt == 'p' ||
-			    optopt == 'f' || optopt == 't' || optopt == 'q')
+			    optopt == 'f' || optopt == 't' || optopt == 'q') {
 				printf ("Option -%c requires an argument.\n", optopt);
-			else if (isprint (optopt))
+			} else if (isprint (optopt)) {
 				printf ("Unknown option `-%c'.\n", optopt);
-			else
-				printf ( "Unknown option character `\\x%x'.\n",
-
-optopt);
+				print_help();
+				return 1;
+			} else {
+				printf ( "Unknown option character `\\x%x'.\n", optopt);
+				print_help();
 				return 1;
-			default:
-				abort ();
+			}
+			break;
+		default:
+			abort ();
 		}
 
 	if (mvalue == NULL || cvalue == NULL || pvalue == NULL ||
 	    fvalue == NULL) {
-		printf("options -m, -c, -p and -f required.\n");
+		printf("options -m, -c, -p and -f are required.\n");
 		printf("usage: %s -m maxlatency -c cycles_per_packet -p mpps(million-packet-per-sec) -f tsc_freq_mhz [-t timeout (in secs)] [-q min_queue_len_to_print_trace]\n", argv[0]);
 		return 1;
 	}
-- 
2.20.1

