Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C5C4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348E214AF
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OweUXHY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfIPVv2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:51:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40505 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbfIPVv1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:51:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id x5so1780591qtr.7
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2019 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oAinGZCFcfYSiNeoi7U5gGTdHvgHV4X/vvDrKhBzYs=;
        b=OweUXHY6NJALw0F4WpGj4GxfcktDkOsf87c4NssehFw2M2BA6Dmo1YSME82P/+OUil
         Yga/JLH8hKLeLTMmJdpBN+AzV1diizxBFfmv61/qu8OKpIpzWtbPDMG0aNCAP+mta2yv
         lUbThmiMG222UBHQEDQQJruCwqFPo4rcVCu/fvb5Yt748rhP7nVczo/v7GGRaF98KSzI
         fZZ2n5DC84kgmpnSa+sFC8SC0JrGgXMFtdkSuRQzrmIifIq7M0bhLv46Sc/XsH8TCmBU
         M5I3B93rZ6zCZHQEjvweokL7f9kVvhfnZLgoDhP9CJZ39ZgfPxlWQZcvcdjPk9+11u8z
         WWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/oAinGZCFcfYSiNeoi7U5gGTdHvgHV4X/vvDrKhBzYs=;
        b=QHqHW9cKtOz8/0FBWFsBmn3S6/z+N+nKGKU9BKCfagczTa81Fr3nMsxx7GnaBPAIsz
         xrnnuYC0gXnU+WFAF05+ECPFgEPGxLrUjhLngaPP/FbhncFVdvH29HSPBnGpZXKPLlow
         0yQXu47vXTFzvrMH+ZoleqoWlLk6l7GcrbYqn1MPRR69IKXYnjSv+GWARFO4MC2ladha
         yLKsDhC+JHval19w2AUrylSKNP/vOZKv3WIhk9WN9N0tRRI6DLO2CNKNJf4VUyYO/5qs
         VVg9M9LmSFiu+SbBEVKCWkCycOtlZM3RNcjOsGTyCTlj7GnRkhGKWuhhBE5zJEvWhmh+
         6nMw==
X-Gm-Message-State: APjAAAWQJBtGMPFmbu80VUyDHXpcDI6adwDVjqCPcNJd2c5NBfq5YEf2
        yG67+lgLefFz8mdBhFwfbtQQjhV3eIc=
X-Google-Smtp-Source: APXvYqxAa+rL+L0Xriitx2SYPh06wEi1VD60i3lPPM7ORJglLLCtSW1EbXI+oFodkdAISy2Q1IOIWw==
X-Received: by 2002:ac8:fcf:: with SMTP id f15mr621988qtk.376.1568670685459;
        Mon, 16 Sep 2019 14:51:25 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id q126sm120156qkf.47.2019.09.16.14.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:51:24 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, Tom Rix <trix@redhat.com>
Subject: [PATCH 4/4] rt-tests: cyclictest: Don't allow OPT_SYSTEM with OPT_POSIX_TIMERS
Date:   Mon, 16 Sep 2019 23:51:11 +0200
Message-Id: <20190916215111.10193-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916215111.10193-1-jkacur@redhat.com>
References: <20190916215111.10193-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

OPT_SYSTEM means use sys_nanosleep and sys_setitimer
if you try to combine it with OPT_POSIX_TIMERS, it breaks.

cyclictest becomes unkillable with ctrl-C and only the first thread is
updated.

Fix this by issuing a warning if the user tries to combine the two
options and then use clock_nanosleep.

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 542e85c27a25..90449d465398 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1353,6 +1353,13 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		}
 	}
 
+	if ((use_system == MODE_SYS_OFFSET) && (use_nanosleep == MODE_CYCLIC)) {
+		warn("The system option requires clock_nanosleep\n");
+		warn("and is not compatible with posix_timers\n");
+		warn("Using clock_nanosleep\n");
+		use_nanosleep = MODE_CLOCK_NANOSLEEP;
+	}
+
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
 #ifdef NUMA
-- 
2.20.1

