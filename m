Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA558C282E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EE218DA
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDWWsI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWWsI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 18:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 078103145714;
        Tue, 23 Apr 2019 22:48:08 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-112.phx2.redhat.com [10.3.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 787AD60C64;
        Tue, 23 Apr 2019 22:48:07 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH] x86/ima: Check EFI_RUNTIME_SERVICES before using
Date:   Tue, 23 Apr 2019 17:48:07 -0500
Message-Id: <20190423224807.4008-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 23 Apr 2019 22:48:08 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Checking efi_enabled(EFI_BOOT) is not sufficient to ensure that
EFI runtime services are available, e.g. if efi=noruntime is used.

Without this, I get an oops on a PREEMPT_RT kernel where efi=noruntime is
the default.

Fixes: 399574c64eaf94e8 ("x86/ima: retry detecting secure boot mode")
Signed-off-by: Scott Wood <swood@redhat.com>
---
 arch/x86/kernel/ima_arch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index e47cd9390ab4..2a2e87717bad 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -17,6 +17,11 @@ static enum efi_secureboot_mode get_sb_mode(void)
 
 	size = sizeof(secboot);
 
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("ima: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
 	/* Get variable contents into buffer */
 	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
 				  NULL, &size, &secboot);
-- 
1.8.3.1

