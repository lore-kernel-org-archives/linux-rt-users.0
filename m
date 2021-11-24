Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99AC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350349AbhKXSGt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350273AbhKXSGj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DC461078;
        Wed, 24 Nov 2021 18:03:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcC-0027xj-LG;
        Wed, 24 Nov 2021 13:03:28 -0500
Message-ID: <20211124180328.497597709@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 13/13] Linux 5.10.78-rt56-rc3
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 51b05e9abe6f..dfd6a5d63829 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt55
+-rt56-rc3
-- 
2.33.0
