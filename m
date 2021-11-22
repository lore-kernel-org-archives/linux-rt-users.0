Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F445C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhKVUmZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238087AbhKVUmQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Nov 2021 15:42:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B51260FF2;
        Mon, 22 Nov 2021 20:39:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpG5h-001r6Q-Ba;
        Mon, 22 Nov 2021 15:39:05 -0500
Message-ID: <20211122203905.190967569@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 15:38:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 10/10] Linux 5.10.78-rt56-rc2
References: <20211122203847.390551309@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 51b05e9abe6f..075041f2f7e9 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt55
+-rt56-rc2
-- 
2.33.0
