Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D50C3F2D7
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0484F20732
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkpdyn/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBVon (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38385 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVon (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id e20so1254929qto.5
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FTLmmKiUa/YorZrMkLoeMd4DY4sR5pkMQQJFi1GIkQ=;
        b=tkpdyn/dmyEqBFr+jLtu3HBQ8eGZ79Q1PmILW9nyqo9QLCoZ8CuJXxLOKE1oYq56Jz
         7ueBQZBPVPZp0u1uT+HqVT8PRr+McorSDDsv6fFyxbXBDoIAqRRqKi9U1fr4EBgSJGhg
         Bx9l0O9LnxV+rBj0zOxy87Azp7jd/ykepahdtmJtp1tXM5X3t7Odtnc5T119PeXmr8j+
         cUAqBCFmeFHwV5x3KyEE7fXpPunsn9CUSFQzEdYzaFwavkwRZ1RxwksO8IqxO1ITfL6C
         HxqxfYI8uhwcu9Q8SX4pzl7vFpxD5fiQM9Upul4NK/iXc2F+L2M08TybQvQAW6OTHCIW
         xTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0FTLmmKiUa/YorZrMkLoeMd4DY4sR5pkMQQJFi1GIkQ=;
        b=WeGZTHwlNVAfigJlN8P6Gb/pYI5dY14THVLIfd+C3u8PtvEpPILw84/m2i3wDtZu2O
         m4cpQRQ8zq0oA3/LLvMourwbFeyj6X6StPuu02dyPn6UFlvTfQBXbtsEgqgCB0YMWU65
         G64MvDe7nYta7vLcg2Nbtz9vDSl9uH9C4uHHMslJ5Fj3vgRmYunylLhTHS80g0WOSSU2
         BFmRfpkLhQhmQRZZyNJlL8E5w5bmNBPSvWnoFYDURe/IpwLAHyBAeakDfGCpk+8S1HIQ
         VPUWnMziklMIZhp2cUpQqTdKzmBAmybV1wksXqiP4XtsnSHN8qmQycC6gITb2WdcwdMF
         AsTg==
X-Gm-Message-State: ANhLgQ1ClWE+UqUpj6VuqFe4XMQ5zQYiOq7txmailD+4uYetB1UjZWMu
        U5HqOCVc3UGgCMdP01g5Ty0eOGXMggU=
X-Google-Smtp-Source: ADFU+vuL4oRK3Ar3Y39tTDjTWiOpIJKMz3L68FW9OD/VvxQx/qI+Xqp2R5bPQfrm5M1B/XL4az9Kxw==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr1675961qtr.198.1583185482313;
        Mon, 02 Mar 2020 13:44:42 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:41 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] rt-tests: cyclictest: Set errno to 0 before call to mlock
Date:   Mon,  2 Mar 2020 16:44:25 -0500
Message-Id: <20200302214430.15825-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Set errno to 0 before the call to mlock in rstat_mlock()

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 01ae72f8cdf1..c66755dd4d87 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1868,9 +1868,8 @@ static int rstat_mlock(void *mptr)
 {
 	int err;
 
-	err = mlock(mptr, _SC_PAGE_SIZE);
-
 	errno = 0;
+	err = mlock(mptr, _SC_PAGE_SIZE);
 	if (err == -1) {
 		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
 	}
-- 
2.20.1

