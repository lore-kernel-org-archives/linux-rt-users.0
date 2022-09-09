Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA25ECAAD3
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Sep 2022 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIIQW3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIIQW2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Sep 2022 12:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD90134622
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Sep 2022 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662740546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QWVzTB7DhyDS1w2QS4cDTPYpzzqRPNqjM1zAYKWvkqk=;
        b=NuHFu3G7mWCF2gUu3V6H67VvUCrW2079UEwTLn0IL7dW1oF2tpznebuiGFd6ar+Rtv1Mug
        nn/f2LxWKkzuoJPidEXDpF9Ys7HB0AiigOM9AEjWGqwe3ooV07l13ZuPW2RGyjFljSQ0gm
        vmlXHTRGyPSY697WLa3IdY3xmh/nTbI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-dJpU85x2O02Ss0Iu-dGAqQ-1; Fri, 09 Sep 2022 12:22:25 -0400
X-MC-Unique: dJpU85x2O02Ss0Iu-dGAqQ-1
Received: by mail-qt1-f199.google.com with SMTP id cf25-20020a05622a401900b0035a6ef450e9so1888672qtb.9
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Sep 2022 09:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QWVzTB7DhyDS1w2QS4cDTPYpzzqRPNqjM1zAYKWvkqk=;
        b=QPwBeMFJWHK9Syq3KAE2FhSRyjdg/2TVUNMRYnty+wPRvevRsnPwnf4jlgIAJBnZlt
         T+hv04hJ1pS4WpcnsmF1f/xawjlSNlPoW3kk6Okb9YTfehfBspG1lsWhGq8vNk2GXG0d
         Spo2dkEQCUJnk0cU+gvbfRc/t+i1w+XfnD3RSGVEeCeJ/zJAviDTUs6KrBrpGTz4h8dN
         K15M5+yZxCaDCMs4EljML0Q/36dGsPHJmXey2DmW8G2dARDhksi/OT/IeDtQ+2dCo4Zn
         98rOWJNCp2MGRKNfW1adYoKldTqo83AL21HN05zkoEWM38jDRIxDcfOzERewOn8rOYDs
         KGiQ==
X-Gm-Message-State: ACgBeo2j/Aw3tRcH+JMyKS47O8774Qbd1naoG9cDq1NggPqQgPPtBD0X
        nlG7Oy3DrSHqX5JQF3Pbgf6IAcoU7ZgKmDQcbaGN/4+jMhgtctbuCbogv8jP3LM/P7ImiJ75Poi
        pBtPx5EJiaE2igwzuJOwunbgS1vs=
X-Received: by 2002:ac8:5753:0:b0:344:7fb3:3fa4 with SMTP id 19-20020ac85753000000b003447fb33fa4mr13376490qtx.504.1662740544682;
        Fri, 09 Sep 2022 09:22:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7hAW+s8f9b2oeDvYgHufQE+ib/CEkDy6knsDMA34gr6nCl29JT4WooLEDoRT/Y5hac315yKA==
X-Received: by 2002:ac8:5753:0:b0:344:7fb3:3fa4 with SMTP id 19-20020ac85753000000b003447fb33fa4mr13376467qtx.504.1662740544446;
        Fri, 09 Sep 2022 09:22:24 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87f4f000000b00342e86b3bdasm833619qtk.12.2022.09.09.09.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:22:23 -0700 (PDT)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: [PATCH] mailbox: qcom-ipcc: Use generic_handle_irq_safe()
Date:   Fri,  9 Sep 2022 12:20:43 -0400
Message-Id: <20220909162043.2734873-1-echanude@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
enabled, which triggers a warning in __handle_irq_event_percpu().

Use generic_handle_irq_safe() that can be called with or without
interrupts enabled instead.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 drivers/mailbox/qcom-ipcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 31d58b7d55fe..be803f324a33 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -82,7 +82,7 @@ static irqreturn_t qcom_ipcc_irq_fn(int irq, void *data)
 
 		virq = irq_find_mapping(ipcc->irq_domain, hwirq);
 		writel(hwirq, ipcc->base + IPCC_REG_RECV_SIGNAL_CLEAR);
-		generic_handle_irq(virq);
+		generic_handle_irq_safe(virq);
 	}
 
 	return IRQ_HANDLED;
-- 
2.37.3

