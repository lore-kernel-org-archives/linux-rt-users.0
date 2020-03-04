Return-Path: <SRS0=qI7K=4V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0ECC3F2D1
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4041020716
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suPeeE2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbgCDV4C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:56:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35113 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgCDV4C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Mar 2020 16:56:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id v15so2638827qto.2
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Mar 2020 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpLuUTKc4TP6nY//YUbfVoWA6bRSK6LgzEy43XpZZR0=;
        b=suPeeE2LjgE/zJ2srks9sANQUeQy4PLurUc1MFlsoT4Pd0Bz+ZtTuv00sX7k5mlFza
         2HcXGg+W6V0zwuFVddGbErWpXCFb/Rg1uE0vM+sgt46aRWgVj54dU2ZAPlvhF5u1+dus
         nX/KA3U/xSetNY7HlrguNHCNByJlBTUn8Dfon3+0v6bfrjXk1D9Fm5RPDSB+7l8QDlyT
         tFSne6aMyZiYEzM/5rsUC/94w5Asn4OTSi8B5PsLh9Z8qs3tfzxBsyttmOXb8wXRRQ//
         U9V3q1ul7YEJ8ZooBQdyGHVGa1PMC59V+hJAjq6AHucOauOvuSPAJBFuAn2lM5PoMXKb
         HFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zpLuUTKc4TP6nY//YUbfVoWA6bRSK6LgzEy43XpZZR0=;
        b=CQWAqAXV0Iw10Ak5oN61g/20SYZYm5QOWAAhDo0o2pSAChYANOzxCp5wD3sdzTIWMt
         URYfmVWi+ONOW9SKKW8/RVtnWQLsaubP6/3T6QsUgXBt4Y+QNazMPeRXaJ75Xd11zEVz
         otIIQr+dSA+IzzNdRiKXJoWHmFDyJ6OuEoBs9apmZdJY3dDNzEF+uPqMPM0rE1yf0ffM
         mAxUevt+GW1MdYiN8yeEIbGLUT3L5ZVOMLBgYcgLyC/lxQREx20VCH1MF20l0/sZGvCC
         qjAwn9AqaMrMp9pgxYZUM6SzWrW8UFHAHfH9DQQGAjFrlUuYB9aE2g9aysobJug9ozve
         /neQ==
X-Gm-Message-State: ANhLgQ2r+enm0NlXvkRmFx+a+ffVPt7lOchtk2jpmIgg07uS5Wnl18X4
        VCkmM5aLG3ctC8sIG+yyvxDitB/G93w=
X-Google-Smtp-Source: ADFU+vvg9Gr2gbLEEhSqUlr0o5TaI8oO/e3mRIJWvwiGeBQjNeOm5Ly8C1b7a8004Z1YXIhKz05tlw==
X-Received: by 2002:ac8:377a:: with SMTP id p55mr4368574qtb.87.1583358960235;
        Wed, 04 Mar 2020 13:56:00 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id f5sm4899164qtq.72.2020.03.04.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:55:59 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/4] rt-tests: cyclictest: Make the affinity mask apply to the main thread too
Date:   Wed,  4 Mar 2020 16:55:47 -0500
Message-Id: <20200304215548.13079-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304215548.13079-1-jkacur@redhat.com>
References: <20200304215548.13079-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no reason that the main thread should be treated differently,
so apply the affinity setting there too.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 13d2b1722890..f8df4c6954ad 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1992,6 +1992,17 @@ int main(int argc, char **argv)
 	if (verbose)
 		printf("Max CPUs = %d\n", max_cpus);
 
+	/* Restrict the main pid to the affinity specified by the user */
+	if (affinity_mask != NULL) {
+		int res;
+
+		errno = 0;
+		res = numa_sched_setaffinity(getpid(), affinity_mask);
+		if (res != 0) {
+			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
+		}
+	}
+
 	if (trigger) {
 		int retval;
 		retval = trigger_init();
-- 
2.20.1

