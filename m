Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D91C7618F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68EF2187F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfGSVuL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfGSVuA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:50:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDF8218BB;
        Fri, 19 Jul 2019 21:49:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalK-00086c-MH; Fri, 19 Jul 2019 17:49:58 -0400
Message-Id: <20190719214958.581048338@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 16/16] Linux 4.19.59-rt24-rc1
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 9a218ca23053..538297c53ccc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt23
+-rt24-rc1
-- 
2.20.1


