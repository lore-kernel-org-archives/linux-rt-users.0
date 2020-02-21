Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB1C35666
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8899824656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320419;
	bh=ryFWFLYTdBBzMBDfnMSr9TikB4hi0/4blGO6gb7hkJY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=yk/32YDs2NRRuudcGi5PxmpIwLQAkWKgtezPoNfx9kH5pqyOlYiaIZYcyiQOUJEqC
	 AJRcM84UVB9F8T5rJsCX5lM1DHDF8dygv06SoxFcNR2wW10brpbU8txyFeB4Mdr9oi
	 wN9oNo+rGK2TqhKc9t+w6uAuTwUvIbR+gWgpFrV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBUV0x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgBUVZT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:19 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7FA2465D;
        Fri, 21 Feb 2020 21:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320318;
        bh=ryFWFLYTdBBzMBDfnMSr9TikB4hi0/4blGO6gb7hkJY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ej+Dv5eRhbUaFXPFGp24BP8PTXPjpoZ6JeGWV0dAfu49srNF/jIlcw6vxIG+vp5ll
         /p4gGIjFPfUWzQ7ucWNEMdsJ47QY8Hc5WD3Sk4yoKDiYjGsd6xge1cTI61IbJGkuLr
         LjU1gXuTktHL+T1XXzthXj7uibUdRMJKnDTti490=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 04/25] i2c: hix5hd2: Remove IRQF_ONESHOT
Date:   Fri, 21 Feb 2020 15:24:32 -0600
Message-Id: <aa2be59729d71a1d1695dd029182bce53e643385.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit e88b481f3f86f11e3243e0808a830e5ca5782a9d ]

The drivers sets IRQF_ONESHOT and passes only a primary handler. The IRQ
is masked while the primary is handler is invoked independently of
IRQF_ONESHOT.
With IRQF_ONESHOT the core code will not force-thread the interrupt and
this is probably not intended. I *assume* that the original author copied
the IRQ registration from another driver which passed a primary and
secondary handler and removed the secondary handler but keeping the
ONESHOT flag.

Remove IRQF_ONESHOT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index bb68957d3da5..76c1a207ccc1 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -464,8 +464,7 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 	hix5hd2_i2c_init(priv);
 
 	ret = devm_request_irq(&pdev->dev, irq, hix5hd2_i2c_irq,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			       dev_name(&pdev->dev), priv);
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), priv);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot request HS-I2C IRQ %d\n", irq);
 		goto err_clk;
-- 
2.14.1

