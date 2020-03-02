Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38019C3F2D7
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991020732
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUBSu8Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCBVoq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37081 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBVoq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so1351962qke.4
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ter0RuiKxIJWmkmNVK7sC0QBAqg66x2Dni6EBTpo6Y4=;
        b=IUBSu8BqLe2LcFFt7D6k6C+S8Jt6mS2utcsSUMLgfzTfXpvhmkwI85Ls33enWFSOFj
         42OsOKYh+V8L0dNg002yl34F5GgP49/J+Ow9gvCGeoSPHdA2+Jvl2/IF3AzIdsVDkuSy
         kI5tGW/M4ADWbIsbOF1nfVZ6v8VAuhq44BDQpcJfBWqGFdMQd7EH1f3RYuOOHceZxi7A
         WMkFr617HPzAFaVZr5dL4bz967h+1FIlF4kTtKOcvxeaoT+2Pox6uIRvg2iQXWPpg/5s
         4xUEYHMYJCrIbYcVXRID1axtQNlG/zFUXwBHbEm2U0SSu2gcPE4V/R8AohLsPNwiJpcs
         0lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ter0RuiKxIJWmkmNVK7sC0QBAqg66x2Dni6EBTpo6Y4=;
        b=QOJZie09LQEu8BJfbFUcQ73PUUkC+dSDGQuJTAcPoDjAwFWw6NDHAqeb0ZNmEMNdOq
         ZFWg+hvvUZq2PIRRwjedIxVXEqgW4CjrTlD8EzRMwiR90cQejCyIt2T/ZoMlEpNhncq2
         w096bGiKwIAddZKuyuGOyn99+UUAMuXJ0WgSq10azqQzy8dEj7hE27Q81lRFocjtZ8Zc
         AVKkjYq0/KElqH35XaQjixa9FItSCsnTYYdzJdWXcezwElysQLL8lAdDezqXeYsDvZNk
         y26S4dh8pskY/UcwAZVt+uFXN2MBJz2BAcVr8fKjfKQSQZXLo8+nXCXYx39oZs4fpe/G
         M5uQ==
X-Gm-Message-State: ANhLgQ3CdcQAT8vW6oXUXoUjvQt5Bbux14nh32ZRjqhA0fEzTu1fKlep
        QriP8JHu7bTfTTmzdnw0rz/5Iay5+OY=
X-Google-Smtp-Source: ADFU+vs4EaqRmZD4mw8pV2G7AkZnBYcFQpq0WT6QymTYWjPBEfSUOi0cJgHn3A/mgqERrKCTfHrIIg==
X-Received: by 2002:a37:4bd3:: with SMTP id y202mr1311246qka.32.1583185485246;
        Mon, 02 Mar 2020 13:44:45 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:44 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/6] rt-tests: cyclictest: Fix parsing affinity with leading exclamation mark
Date:   Mon,  2 Mar 2020 16:44:28 -0500
Message-Id: <20200302214430.15825-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The case in which the user specifies the affinity with a space and a
leading exclamation mark was not working. For example

./cyclictest -t -a'!4-5'
was working correctly, but the following was not.
./cyclictest -t -a '!4-5'

Fix this by recognizing this input as a non-error case.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 1d2962fda777..18c383689dc2 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1199,7 +1199,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (optarg != NULL) {
 				parse_cpumask(optarg, max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && (atoi(argv[optind]) || argv[optind][0] == '0')) {
+			} else if (optind<argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
-- 
2.20.1

