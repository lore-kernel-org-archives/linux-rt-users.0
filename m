Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B8C432C3
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8C820748
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnXNhiFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKYORG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:17:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfKYORG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so18315886wrr.0
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIaQlweoYmCyzjVGFuabNtZn2NxU/K8+uosryfgcmdU=;
        b=jnXNhiFLsd/ELNVJlEqaiIs4fXSjfUACcSZGXUn4R84m7l0hlpMD7rXCOwWub8HUIf
         AobIqJcUlMeswKiTBoxeuVg7l4v8oLAv2BFXlbum9N9pSjWpDmLARS5TafhlV5De+/t0
         07mbjoQoJzMUQhEM4uUMteT88Ow/0RHni9ayklUfoscGk5dN5j0c4gsxe+vScHKWvOYJ
         tVRr1h9EvB19fY4QdhYtWReDY6sHBA8Jq6DO3B1MF5w7o4YQ1TZ2dZ5dLoWO0R6omakO
         ui2ntrKhz4hUfd7SYCCGtIFxbVFLWs5p3N2HzurtNec+358bixGQFLVuCsn/vvq+ucAC
         KJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IIaQlweoYmCyzjVGFuabNtZn2NxU/K8+uosryfgcmdU=;
        b=HmY2o24WO3ngcdGEEebEsleekAWWhrOc99tIy0KkIl7ak20Usvf+W9u9wpVqg8AKLq
         6ey90bROJyxakphiThORr6wJ+Y9cdeGGtp1yVYkodhmwQYQ528Y3yWJ13ogcTxbW5Pp8
         nZXgFXRP6QsZqhWY0Yhd2OfCzqF2oTPc0f4N1a5h669QrcV1ll+iiB9oeEJHyDH5Zr9b
         TPUMs1iUnI15fnJX0J0g9XHxxsL5wc3T0NmCHtDufedHvzi4HzXOy7nSf2PJDY88uMnV
         85Bxk8d7UfSm63YvQFBAosIbMaRiQdveRf/9Ngj41CciM9bysescYtEG+V7woBOPOh+a
         pOKQ==
X-Gm-Message-State: APjAAAU52WJY7TBA06yGQPMeefmn97Hf1ZwuxfdZtiikyDmItFhI82Yg
        q97HAL7KbVLR8/Fk4nvBBGY8gkxGc8k=
X-Google-Smtp-Source: APXvYqyjiVUvxNYwfGRxMagZWd59WVFOM+t3AlLLIpeP/83npTiQ/bn2UZrlYvPbevlnYxvqmHS6pQ==
X-Received: by 2002:adf:f987:: with SMTP id f7mr31930486wrr.284.1574691422299;
        Mon, 25 Nov 2019 06:17:02 -0800 (PST)
Received: from planxty.redhat.com (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id q5sm8463456wmc.27.2019.11.25.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:17:01 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/8] cyclictest: Sync manpage with the help option
Date:   Mon, 25 Nov 2019 15:16:42 +0100
Message-Id: <20191125141644.4429-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125141644.4429-1-jkacur@redhat.com>
References: <20191125141644.4429-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sync the manpage with the help option, as the manpage has not kept-up
with changes to help

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index b64a16ae8bbb..00e2d2403996 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -67,6 +67,9 @@ Specify a length for the test run.
 .br
 Append 'm', 'h', or 'd' to specify minutes, hours or days.
 .TP
+.B \-\-latency=PM_Q0S
+write PM_Q0S to /dev/cpu_dma_latency
+.TP
 .B \-F, \-\-fifo=<path>
 Create a named pipe at path and write stats to it
 .TP
@@ -95,9 +98,6 @@ Lock current and future memory allocations to prevent being paged out
 Delay updating the screen until a new max latency is hit. (useful for
 running cyclictest on low-bandwidth connections)
 .TP
-.B \-n, \-\-nanosleep
-Use clock_nanosleep instead of posix interval timers. Setting this option runs the tests with clock_nanosleep instead of posix interval timers.
-.TP
 .B \-N, \-\-nsecs
 Show results in nanoseconds instead of microseconds, which is the default unit.
 .TP
@@ -165,6 +165,9 @@ where n=task number c=count v=latency value in us.
 .TP
 .B \-\-dbg_cyclictest
 Print info userful for debugging cyclictest
+.TP
+.B \-x, \-\-posix_timers
+Use POSIX timers instead of clock_nanosleep.
 
 .SH SEE ALSO
 .BR numa (3),
-- 
2.20.1

