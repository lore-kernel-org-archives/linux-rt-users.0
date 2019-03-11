Return-Path: <SRS0=xoO4=RO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE78C43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6802084F
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7twHwuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfCKN0H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46862 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfCKN0G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Mar 2019 09:26:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so5060751wrs.13
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Mar 2019 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiAIZ1p8+94UDSsBbGd6zrU4YDwwG/biuV4TwTr/ADk=;
        b=L7twHwuXJ2K/IlZH7KnqWelgy+QaPJu8e3P3LTveH8EBy0k6dNHUI/CZBNxQFlmDwT
         0yUOIJgd9/YRQIgAEOByI7ZXY34W5I+t7PVMLFC+8EIZP7ZLBh6gpVvtQh9WdC/KlpBh
         3EQGTcZVGW0vHr2unWLGJS+LV8PhXIDSIkckGE578TatlIgjMKQ+ClKNvufnqH2aqjA2
         HwShgQP2hj9g7s5O/TUHzKL13zJuK2TdL320mcZZZ9OYNqPZrPj/GdnYKE16DLpYJm+G
         921IAXpfMLuZaA9iqNcl9F9GRccdKFWjNZAGSkwTzHAVHyisKNAt8tU0Zfn7BEr1TR5s
         3OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BiAIZ1p8+94UDSsBbGd6zrU4YDwwG/biuV4TwTr/ADk=;
        b=hZOJ8M3hLefDYPz48H2CxWuoBa9PFSkEbscb8i/oqfI6UwikWZE7Mf0cRYlbb5Kk89
         F5cG2RsPJOHUXRq1OGEXH3GLDbSiMihN7V3lmJzQ7mkTqGqhJTmMPjJBOxvJLUQQJrQF
         cvSUQXFVhLHbiqac1SDXX79Zmy95XvDLuISIbnqibWQEOaNHbt2wWmbXezZ4S17Apa8T
         /LFQ9YhL9k76S+3t9pbWhtlwMurRzlEwrLFviYToUphxngGB8joGLVlkfP75Zpy+jfv0
         CSFHdUqz9D20Kqbg06lsXzqpNO0KyK82JfpdfvbCsaHdjhuVVqN5+71P+WVvU+WMdjX8
         V2CA==
X-Gm-Message-State: APjAAAUtbYbskunJqIL1ZS4zyQHQFPVnL0EP1eZ9ehSgqAi0zk3xQDpD
        SFdSfo5Z/07S5XaIwlo3jmkZdOnp
X-Google-Smtp-Source: APXvYqxjOYY4J74lBIVcRw6Sv07mra4KX3O4Qjpx6TDPW7r261mcrCG37t+CtMCJ03BdZiVbHcNTNw==
X-Received: by 2002:a5d:5292:: with SMTP id c18mr15735399wrv.251.1552310764291;
        Mon, 11 Mar 2019 06:26:04 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id g202sm21776222wme.26.2019.03.11.06.26.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 06:26:03 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] cyclictest: Make sure affinity is respected when numa is detected
Date:   Mon, 11 Mar 2019 14:25:49 +0100
Message-Id: <20190311132549.7219-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311132549.7219-1-jkacur@redhat.com>
References: <20190311132549.7219-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make sure affinity is respected when numa is automatically detected and
when smp is not specified. Don't break the way smp currently works.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1bd63fd93dce..ed59edefbf97 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1218,7 +1218,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'a':
 		case OPT_AFFINITY:
 			option_affinity = 1;
-			if (smp || numa)
+			if (smp)
 				break;
 			if (optarg != NULL) {
 				parse_cpumask(optarg, max_cpus);
@@ -1384,8 +1384,10 @@ static void process_options (int argc, char *argv[], int max_cpus)
 #ifdef NUMA
 		if (numa_available() != -1) {
 			numa = 1;
-			num_threads = max_cpus;
-			setaffinity = AFFINITY_USEALL;
+			if (setaffinity == AFFINITY_UNSPECIFIED) {
+				num_threads = max_cpus;
+				setaffinity = AFFINITY_USEALL;
+			}
 		}
 #else
 		warn("cyclictest was not built with the numa option\n");
@@ -1394,11 +1396,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	}
 
 	if (option_affinity) {
-		if (smp) {
+		if (smp)
 			warn("-a ignored due to smp mode\n");
-		} else if (numa) {
-			warn("-a ignored due to numa mode\n");
-		}
 	}
 
 	if (smi) {
-- 
2.20.1

