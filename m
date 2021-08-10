Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8689C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74CB61019
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 06:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhHJG7T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbhHJG7S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 02:59:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD4C0613D3
        for <linux-rt-users@vger.kernel.org>; Mon,  9 Aug 2021 23:58:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c16so19698865plh.7
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Aug 2021 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=gNSA/QqvaxKCqHSWnVz2swgpIR5+WkaDSkJI1ULT9rA=;
        b=r508PbpzXTgNylbOlVZbqjUd07yDX5LqIR1CSyntr0H21Vg4qfnI9ii/qYoemnju4j
         WfNofvH1OcGjzO570V6Y2xLkY+xswcaO14fwCbzf0rdmLlvPf8wp7G0n896r+tzFn0E4
         l8/5pAFmpEqpU6yHZNUy51sG5BqysTKBw64Fz6JfwF2kkt9PUCZxYTd4Vlytzd+XqzPC
         7XYJpM+yDpYLHKpBWlxYUUL3nfBEisYPG7As51yFS+sIz8sqJHPLL4j5BENAb4irU+tQ
         WOqgx5uUNXnVb629AnqalPcJ3KpiO9QU2X1ilU8/lqFORT090pLuUqttkdzcqkN5kAFF
         txSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=gNSA/QqvaxKCqHSWnVz2swgpIR5+WkaDSkJI1ULT9rA=;
        b=NzHRdDM4AJqVV2URZtvC1VMudTVAJOP3yFBtJvtHL8an0FLhecOJqyqSms/EDN+3zE
         +nvz2GPJN98rvlp0QtxPdDR25eELpHCrw+YQX4afJ2ivCVD2U/fP47SMIM4z8CyWf2R7
         JFuveJb2wWiUKNUWTrKYEQj1Yypc8a3I3PTAxFg//yD3yve7gOGnxZzTP+ToaXq+xKfU
         mHZ2IsKr+DNQYABtbqkDDS7PzhRSUJq8ZldJNZAm+ZG7bV/LWXnUhWQqVmNyD2RHMbPf
         yOP17H2AdFZAA3J8eMBauYkV8hw+xFjkVe/1gxuuO9wuUsNlHTrHQZ0Oicpfpiqhy1xO
         WERw==
X-Gm-Message-State: AOAM532Ryp8A/3YEtE0sAuqb8FgE92DduXy+ZMGzl1Gq/aFmVFtwPPFO
        7kSJW2Xq3H5NfuHKlMSq7ROBN54j0Hb37A==
X-Google-Smtp-Source: ABdhPJwqqrTiGxpoE0PN78Uq9/2hQFTZzTFHHzwvL/IkUiSiqZIpIK2BGvEdTNGaq3PUCDfqDmhavA==
X-Received: by 2002:a63:5925:: with SMTP id n37mr99572pgb.251.1628578735938;
        Mon, 09 Aug 2021 23:58:55 -0700 (PDT)
Received: from ubuntu ([106.245.77.4])
        by smtp.gmail.com with ESMTPSA id 2sm15095407pfe.37.2021.08.09.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:58:55 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:57:49 +0900
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
To:     linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] usb: chipidea: fix RT issue for udc
Message-ID: <20210810065749.GA3369716@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.
to prevent local_irq_save should keep the function from irqs.

I am not sure where is the best to submit this patch, between RT and USB
community so sending to both. thanks.

Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
---
 drivers/usb/chipidea/udc.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 5f35cdd2cf1d..a90498f17cc4 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -102,6 +102,9 @@ static int hw_ep_flush(struct ci_hdrc *ci, int num, int dir)
 {
 	int n = hw_ep_bit(num, dir);
 
+    /* From zynq-7000 TRM, It can take a long time
+     * so irq disable is not a good option for RT
+     */
 	do {
 		/* flush any pending transfer */
 		hw_write(ci, OP_ENDPTFLUSH, ~0, BIT(n));
@@ -190,22 +193,32 @@ static int hw_ep_get_halt(struct ci_hdrc *ci, int num, int dir)
 static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
 {
 	int n = hw_ep_bit(num, dir);
+	unsigned long flags;
+	int ret = 0;
 
 	/* Synchronize before ep prime */
 	wmb();
 
-	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
-		return -EAGAIN;
+	/* irq affects this routine so irq should be disabled on RT.
+	 * on standard kernel, irq is already disabled by callers.
+	 */
+	local_irq_save(flags);
+	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num))) {
+		ret = -EAGAIN;
+	goto out;
+	}
 
 	hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
 
 	while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 		cpu_relax();
 	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
-		return -EAGAIN;
+		ret = -EAGAIN;
 
+out:
+	local_irq_restore(flags);
 	/* status shoult be tested according with manual but it doesn't work */
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.25.1

