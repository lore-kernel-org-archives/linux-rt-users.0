Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E5C43215
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F2320836
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYMOQjHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKYORF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:17:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfKYORF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so18312810wro.5
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oNzV75ZoEoiiWZYsHOV3YLNpXRS8r5apimxI1+HrAk=;
        b=sYMOQjHvNr02ZM+mb0BrUCAMHvuZojKfXfmsNXhMLd3g2Aip/YlXrq7p4U4H2Tz3Cv
         38PjuJsEwzM0w2bmT/5qm4Ccf6WrttOTT+Gu3ki07ydCu34OPq+mA7kfB8hdFuQoPLq8
         iKxnM+FrkLQ88HGZruT4+TQ4iSqCWVOzJ0iCjRRN+R3jkTiGeI8y6PmLtiiL8rcCr6Xk
         YKhtUuBt29jrHlZOC2TEFXHX2LVq3WQ6QRRqsNmi3iYS86dvqjuO6sNCODBXzPx0AAiF
         ccNPVygTXA3TtCGuhlcEB38hxKNHbFaRM93DPGumOpUIZNY2LPSneLDOeqklTOAt/upH
         AssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7oNzV75ZoEoiiWZYsHOV3YLNpXRS8r5apimxI1+HrAk=;
        b=NiPPOfjEuadRWvEkjahdZolv7omOnonH1jWFVgbWs3l4YdlUMHix5J2AjO2H62QoJM
         uzIHd7Mf8kx7p6hJ12FFe3vuSmQ+ZeRGGCe/ZwyKUDJqupscGooXpDDxFEvi6pat5/iw
         /lhKTQsZ2F0LIOqdHTaxy4Ry76dR2Cib7CuQwKIVyX23qbK+ui8vYzr2O1ug6VXRSaUV
         /LhFKspoBipjEKDqVr0CmplTW5qJXtksS8lglNJ9/xLworZhrI6bm3JZIe7H9tZ5G2jE
         tKoXa+aLLQvheO5bvHRXw9rB5zUlaKtnwmDZaikd9q2V0lhNra0B/OId1q9VpN5Nlzj/
         2yEg==
X-Gm-Message-State: APjAAAUcaC90FPS/wPD8QNGzzwNAVUbKI3S89Um4b2ALwpLKbaHZmLL+
        e1xgfgUbdEx+B2tyMbcYs/hwwBVqL2E=
X-Google-Smtp-Source: APXvYqwjCAcxCOMoD8hDtldLI3aJDiu08Mnn6G+uuVVBExnvLAtMYrfPRaEhaz6tLS4Mr5BddHgH5A==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr31168962wrn.124.1574691423368;
        Mon, 25 Nov 2019 06:17:03 -0800 (PST)
Received: from planxty.redhat.com (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id q5sm8463456wmc.27.2019.11.25.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:17:02 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/8] svsematest: Add -S, --smp option to manpage
Date:   Mon, 25 Nov 2019 15:16:43 +0100
Message-Id: <20191125141644.4429-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125141644.4429-1-jkacur@redhat.com>
References: <20191125141644.4429-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The -S, or --smp option is in the help but missing from the manpage.

We should really revisit these tests as these options have changed a bit
in cyclictest and they are all modeled after cyclictest.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/svsematest/svsematest.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
index f67ab4c669d3..98322c105803 100644
--- a/src/svsematest/svsematest.8
+++ b/src/svsematest/svsematest.8
@@ -38,6 +38,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-p, \-\-prio=PRIO
 Set the priority of the process.
 .TP
+.B \-S, \-\-smp
+SMP testing: options -a -t and same priority of all threads
+.TP
 .B \-t, \-\-threads[=NUM]
 Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
-- 
2.20.1

