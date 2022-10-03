Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFEC4321E
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Oct 2022 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJCRN2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJCRMh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2022 13:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44234998
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Oct 2022 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664817095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dzb8EgXtXtOeTruW/z4IGhhF8RMS3aAQr6k0iWpk9YQ=;
        b=TeqL8wDx24fQ+NlHRmJ19M/dZ6e1IPRcjgsnnjT16iuXohW4IOZ3pdVx5QcHzBlQptRgR9
        YOZwQ9jPU2U5/9zhOgOGy/XjcgyEMuGn8od2qiWNbZY33mn9Y25Zbq/3YabKE8iHac9GhI
        ADwwmwmry9yFxTvkFEVDvK6LEX4QJh4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-oDQriCkpOR6IHnKa6WOJkg-1; Mon, 03 Oct 2022 13:11:34 -0400
X-MC-Unique: oDQriCkpOR6IHnKa6WOJkg-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso9692798qkp.21
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2022 10:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Dzb8EgXtXtOeTruW/z4IGhhF8RMS3aAQr6k0iWpk9YQ=;
        b=i3JGTmDKgGSYqVTfdd52vc5HZB34xX9NQXrfOTCMKrfxYZeKVlmsqpOei/ZZXGMZRh
         p1eL5o1cUMzrCVD9lgeie68QCyaJf/1C9BIdojbxWe9CmXXHKhnGk85Lem7r1twUjWUn
         z4IFBEZCjIbeNcAoPI/MxQ71fN4z45Bnr9oTNXLBHPbiUQYInB7jQMdj/B4x+BNMtZ0j
         7w1pKBgmjKipl7+bFBhTzAGmP1oGsy7uarvkbExQRPF2KP3WnLBZfLRUkjQc546HQKvE
         K83S+binR8Y9HLgRB0vHTZorrCSkPtjV7LOQ7+OJYPUb9l5f8apHVmAqUtBRiGWxKuN3
         KNlA==
X-Gm-Message-State: ACrzQf0XIZrSC+tB8ZAlNcP+XhjUqT8eLwoFg7c/YUgLjrG/HK/n1iNv
        tsXoVlIfULQlduUPjLuFMIPrNpR5uZyFvzxgqHGReoCh7ZfqdGjl2av74iXvazL/bVzxwnEJGaC
        VfVHDIym6xbedOCAM5GA6e9LfS+0=
X-Received: by 2002:a05:622a:180d:b0:35b:d283:7e65 with SMTP id t13-20020a05622a180d00b0035bd2837e65mr16743092qtc.106.1664817093067;
        Mon, 03 Oct 2022 10:11:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Px9ykH7I6R3BOvdcWrkGhEmxNlAdURjOCoJnDBPlrIXe9R9dzuva7XqDYcpbqzTxfd+yV3w==
X-Received: by 2002:a05:622a:180d:b0:35b:d283:7e65 with SMTP id t13-20020a05622a180d00b0035bd2837e65mr16743073qtc.106.1664817092858;
        Mon, 03 Oct 2022 10:11:32 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a449600b006cf3592cc20sm12155356qkp.55.2022.10.03.10.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:11:32 -0700 (PDT)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Chanudet <echanude@redhat.com>
Subject: [PATCH] mailbox: qcom-ipcc: flag IRQ NO_THREAD
Date:   Mon,  3 Oct 2022 13:08:49 -0400
Message-Id: <20221003170849.383005-1-echanude@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
enabled, which triggers a warning in __handle_irq_event_percpu():
    irq 173 handler irq_default_primary_handler+0x0/0x10 enabled interrupts
    WARNING: CPU: 0 PID: 77 at kernel/irq/handle.c:161 __handle_irq_event_percpu+0x4c4/0x4d0

Mark it IRQF_NO_THREAD to avoid running the handler in a threaded
context with threadirqs or PREEMPT_RT enabled.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 drivers/mailbox/qcom-ipcc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 31d58b7d55fe..7e27acf6c0cc 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -308,7 +308,8 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 		goto err_mbox;
 
 	ret = devm_request_irq(&pdev->dev, ipcc->irq, qcom_ipcc_irq_fn,
-			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, name, ipcc);
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND |
+			       IRQF_NO_THREAD, name, ipcc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
 		goto err_req_irq;
-- 
2.37.3

