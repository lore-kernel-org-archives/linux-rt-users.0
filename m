Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E550DC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Feb 2021 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9419E64E55
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Feb 2021 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBEKZG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Feb 2021 05:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBEKWr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Feb 2021 05:22:47 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Feb 2021 02:22:05 PST
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA106C0613D6
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Feb 2021 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1612520123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MbsCXvv83YWZgP1xLVqdwWSrez17Qr4SnlaFmdZEfRc=;
        b=ZsmzJizbJb/IV4NRhPOyBU+umhgERn+TCMDkWUBIiwxOG/RisnKFVVaBeXfP/iDhsQav9E
        9suPo4mEqOWDUlUzz2dglbzv81zY3vEGrqXWmBIFonVuC2VsBYer4o4vrAr/idDIC8tCbr
        qLD7FFPopePrgi+7GYuWDmTGZ72lHq8=
Received: from [192.168.0.2] (host-82-54-239-193.retail.telecomitalia.it [82.54.239.193])
        by sysam.it (OpenSMTPD) with ESMTPSA id b7f720ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-rt-users@vger.kernel.org>;
        Fri, 5 Feb 2021 10:15:23 +0000 (UTC)
Message-ID: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
Date:   Fri, 5 Feb 2021 11:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   "angelo@kernel-space.org" <angelo@kernel-space.org>
Subject: arm64: imx8qxp: irq 464: nobody cared (try booting with the "irqpoll"
 option)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

applied patch-5.4.70-rt40 over linux-imx from nxp
(imx_5.4.70_2.3.0), this since imx8qxp-mek board seems not
totally supported in mainline stable 5.4.

The patch applies properly, but at boot, at 50% of the cases,
i get:

[    2.229242] 003: usb_phy_generic bus@5b000000:usb3-phy:
bus@5b000000:usb3-phy supply vcc not found, using dummy regulator
[    2.231782] 003: gpio-42 (scl): enforced open drain please flag it
properly in DT/ACPI DSDT/board file
[    2.231799] 003: imx-lpi2c 37230000.i2c: using scl,sda for recovery
[    2.232464] 003: pca953x 16-0020: using no AI
[    2.517161] 000: irq 464: nobody cared (try booting with the
"irqpoll" option)
[    2.517170] 000: CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.4.70-rt40-00116-gc1de1cbc567a-dirty #51
[    2.517176] 000: Hardware name: Freescale i.MX8QXP MEK (DT)
[    2.517181] 000: Call trace:
[    2.517182] 000:  dump_backtrace+0x0/0x140
[    2.517195] 000:  show_stack+0x14/0x20
[    2.517200] 000:  dump_stack+0xb0/0x10c
[    2.517208] 000:  __report_bad_irq+0x48/0xd8
[    2.517215] 000:  note_interrupt+0x2bc/0x374
[    2.517220] 000:  handle_irq_event_percpu+0xa4/0xb0
[    2.517228] 000:  handle_irq_event+0x74/0x118
[    2.517233] 000:  handle_edge_irq+0xbc/0x200
[    2.517238] 000:  generic_handle_irq+0x24/0x38
[    2.517244] 000:  imx_intmux_irq_handler+0xac/0x140
[    2.517252] 000:  generic_handle_irq+0x24/0x38
[    2.517259] 000:  __handle_domain_irq+0x90/0x100
[    2.517267] 000:  gic_handle_irq+0x5c/0x14c
[    2.517272] 000:  el1_irq+0xb8/0x180
[    2.517277] 000:  arch_cpu_idle+0x1c/0x30
[    2.517284] 000:  default_idle_call+0x20/0x48
[    2.517291] 000:  do_idle+0x248/0x288
[    2.517297] 000:  cpu_startup_entry+0x24/0x78
[    2.517303] 000:  rest_init+0xd4/0xe0
[    2.517308] 000:  arch_call_rest_init+0xc/0x14
[    2.517316] 000:  start_kernel+0x414/0x448
[    2.517322] 000: handlers:
[    2.517331] 000: [<00000000206db772>] irq_default_primary_handler
threaded [<00000000ffd05448>] lpi2c_imx_isr
[    2.517341] 000: Disabling IRQ #464

I know nxp related issues are probably now welcome here,
but if some chance/hint to have rt working, welcome.

Regards,

-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo@kernel-space.org

