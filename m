Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A9C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5B60F41
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhHQJyy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhHQJyv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 05:54:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B07C0613C1
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2021 02:54:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l11so24281495plk.6
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2021 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2QLKXAPnoui9XVLyg743j9w1B3x7jwImrdDDd39xXc8=;
        b=ZqazUvD7i/wG28iIpHw/9CBrEusC3AzwCC2puJV+SwH2paGIvL0U8fxM3QdYgkxFHm
         zYuR23SY3nIuybWvujo0epoHumArxAhNJMffclndrvjuQTUMh17jQ8+cWWkuTlL6P7K5
         OyFmz29uRC1IQObEN94TMdkgquUIWFMbrtS0SQROQVdxsNdS2E2GFulNP9P4/fvHGFTm
         O863WUuj9lyN3n0UBb5dei+0DC16hiHQqt9BG/ClOW32TWUy/PjrY9icqTu9f9Klba+5
         eyMeT/jx6ccyfrefA+D4H4YejscvgCQ84gKD2zRW2vsROK+MV6PermeJ4IAInjPVwty1
         y8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2QLKXAPnoui9XVLyg743j9w1B3x7jwImrdDDd39xXc8=;
        b=liyaJnlfUbk8PdS4A2qcacXM1qUnrZJcvLYsMEm6WgbEc4lzuizfnYQvPCTyADcosN
         go9eOLy7SP9shD57n89zjujyERgXp3sUAYeq2Mqtuchvn3OI0qZmt8JY0nZAPuAtl290
         gGvIspevHOUsEgBqDkUkHEdzoGPvamLhhV5gLWyK9kBn/cwGCxg4iLVAh198dfNFmfbq
         wYBwWU0Lh5y03I3Nh1/SoTH9k8ahIaP3INFx2iFpYYI5Qw1FUtjKnJMN5fJujLJ9RyJQ
         gl4frI1JXsxsxMklcOYWXEPrfh6Ze0ewNI0srJheUklUCfuFLvo3JKDmL3xgrM34PUGl
         9N3Q==
X-Gm-Message-State: AOAM532vQMKo/v3De1N0t8L9u3TTR+ec1Ws86bcr5fUHO2T7R1jp0gKy
        zNy1Q5LIiQNXFhTFd9ASNrjZjQ==
X-Google-Smtp-Source: ABdhPJyXBWko95TLSSpwPc0mE2S9v5czRRdqGBF122VhKKxRGGJm0ybDufF84X3GT5rMTqBdB75Gvg==
X-Received: by 2002:a17:90b:350e:: with SMTP id ls14mr2797236pjb.28.1629194058233;
        Tue, 17 Aug 2021 02:54:18 -0700 (PDT)
Received: from ubuntu ([106.245.77.4])
        by smtp.gmail.com with ESMTPSA id m18sm1791531pjq.32.2021.08.17.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:54:17 -0700 (PDT)
Date:   Tue, 17 Aug 2021 18:53:13 +0900
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        team-linux@rtst.co.kr, mkbyeon@lselectric.co.kr,
        khchoib@lselectric.co.kr
Subject: [PATCH v2] usb: chipidea: local_irq_save/restore added for
 hw_ep_prime
Message-ID: <20210817095313.GA671484@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.
local_irq_save/restore is added inside the function to gurantee atomicity.
only effective for preempt_rt since hw_ep_prime is called inside top half
or spin_lock_irqsave. No effect is expected for standard linux.

Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8834ca613721..a624eddb3e22 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -191,22 +191,31 @@ static int hw_ep_get_halt(struct ci_hdrc *ci, int num, int dir)
 static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
 {
 	int n = hw_ep_bit(num, dir);
+	unsigned long flags;
+	int ret = 0;
 
 	/* Synchronize before ep prime */
 	wmb();
 
-	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
+	/* irq affects this routine so irq should be disabled on RT.
+	 * on standard kernel, irq is already disabled by callers.
+	 */
+	local_irq_save(flags);
+	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num))) {
+		local_irq_restore(flags);
 		return -EAGAIN;
+	}
 
 	hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
 
 	while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 		cpu_relax();
 	if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
-		return -EAGAIN;
+		ret = -EAGAIN;
 
+	local_irq_restore(flags);
 	/* status shoult be tested according with manual but it doesn't work */
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.25.1

