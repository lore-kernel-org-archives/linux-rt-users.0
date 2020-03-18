Return-Path: <SRS0=/O46=5D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D8C4332D
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Mar 2020 20:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D722076F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Mar 2020 20:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="AruF/0wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRUhp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:37:45 -0400
Received: from ns.omicron.at ([212.183.10.25]:53970 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCRUho (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Mar 2020 16:37:44 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 16:37:43 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 02IKSuVT027520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 21:28:57 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 02IKSuVT027520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1584563337;
        bh=TZ4EahDLI/A01zegYlJj0zs+tkxDyl9TX5N0Nk//S44=;
        h=From:To:CC:Subject:Date:From;
        b=AruF/0wjIjJmmgE05JBtlIQsakzGgN4gMj2hNO/uH8c/kQuk1LTO7p+dyikTGrDH5
         apfDBd36iiSygLaItUAI8r9cScOd15qJS4oBM/JEb0dUx766VjW/aWpd/NVLamuUdp
         JnV6giHAz2Xh5SEDBO115ZOk0AHJl+M6a+JZGa9A=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id C8614A0141;
        Wed, 18 Mar 2020 21:28:56 +0100 (CET)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id C315AA018C;
        Wed, 18 Mar 2020 21:28:56 +0100 (CET)
Received: from EXC03-ATKLA.omicron.at ([172.22.100.188])
        by MGW01-ATKLA.omicron.at  with ESMTP id 02IKSuYW014882-02IKSuYY014882
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Wed, 18 Mar 2020 21:28:56 +0100
Received: from thogra00ll01.omicron.at (172.29.5.144) by
 EXC03-ATKLA.omicron.at (172.22.100.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Mar 2020 21:28:55 +0100
From:   Thomas Graziadei <thomas.graziadei@omicronenergy.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bigeasy@linutronix.de>, <rostedt@goodmis.org>,
        <tglx@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        Thomas Graziadei <thomas.graziadei@omicronenergy.com>
Subject: [PATCH] powerpc: Fix lazy preemption for powerpc 32bit
Date:   Wed, 18 Mar 2020 21:26:40 +0100
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.5.144]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC03-ATKLA.omicron.at (172.22.100.188)
Message-ID: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Graziadei <thomas.graziadei@omicronenergy.com>

The 32bit powerpc assembler implementation of the lazy preemption
set the _TIF_PERSYSCALL_MASK on the low word. This could lead to
modprobe segfaults and a kernel panic - not syncing: Attempt to
kill init! issue.

Fixed by shifting the mask by 16 bit using andis and lis.

Signed-off-by: Thomas Graziadei <thomas.graziadei@omicronenergy.com>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 172dfb567c25..ab609d63d644 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -533,12 +533,12 @@ syscall_exit_work:
 
 1:	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
+2:	andis.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
 	beq	4f
 
 	/* Clear per-syscall TIF flags if any are set.  */
 
-	li	r11,_TIF_PERSYSCALL_MASK@h
+	lis	r11,(_TIF_PERSYSCALL_MASK)@h
 	addi	r12,r2,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
-- 
2.17.1

