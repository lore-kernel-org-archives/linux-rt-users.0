Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180CFC76591
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F0B24688
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814143;
	bh=B6P641rWsf/Ec7BU5n0nO9BBlh7q4N6TPmpNhTYjtx0=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=kN13fOqeNjUdkcQyPcuecJxS9TH+D4QMTVz6sgUnOUJmS9RuT7aBjIxEodfEd3qu7
	 DcUUyfCWjNmSxJWRElXOmxSvUpfM7PkyaGvBdiLO0knkpP3qRlmpN5Mem3OgsBNMt6
	 XGLFp2lHpGJs0kII3NZ7Fus/DsjlO9iOf2fHGGGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgB0Ofk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733290AbgB0Od7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:33:59 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EC1246AC;
        Thu, 27 Feb 2020 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814038;
        bh=B6P641rWsf/Ec7BU5n0nO9BBlh7q4N6TPmpNhTYjtx0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=mCiueRR8QZjKZbFuVbeTBQaGCQklLQ3ZwH5RzuGh3HVQ+HEIh8loX88F05ZDsihIk
         Pe1aIfxat6LLZCWDgXYE5HpspB4GH6YdSYZJHCp5d3gxxeX3ScpS5aYIzrVxP5EuSb
         dqDmtdF7dhfCKLoLq058o62l0al6dBh4REpLcYPM=
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
Subject: [PATCH RT 03/23] i2c: hix5hd2: Remove IRQF_ONESHOT
Date:   Thu, 27 Feb 2020 08:33:14 -0600
Message-Id: <272250d7ac609c3bb6948e6ec4f8bb122b7f9360.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
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

