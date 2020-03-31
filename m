Return-Path: <SRS0=jf0u=5Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C6C2D0F1
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECBF214DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgCaQf0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgCaQfP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Mar 2020 12:35:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B472920CC7;
        Tue, 31 Mar 2020 16:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jJJr7-002VfA-Kz; Tue, 31 Mar 2020 12:35:13 -0400
Message-Id: <20200331163513.525283482@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 31 Mar 2020 12:34:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Tiejun Chen <tiejunc@vmware.com>
Subject: [PATCH RT 1/3] lib/ubsan: Remove flags parameter from calls to ubsan_prologue() and
 ubsan_epilogue()
References: <20200331163453.805082089@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.106-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Tiejun Chen <tiejunc@vmware.com>

Fails to build with CONFIG_UBSAN=y

lib/ubsan.c: In function '__ubsan_handle_vla_bound_not_positive':
lib/ubsan.c:348:2: error: too many arguments to function 'ubsan_prologue'
  ubsan_prologue(&data->location, &flags);
  ^~~~~~~~~~~~~~
lib/ubsan.c:146:13: note: declared here
 static void ubsan_prologue(struct source_location *location)
             ^~~~~~~~~~~~~~
lib/ubsan.c:353:2: error: too many arguments to function 'ubsan_epilogue'
  ubsan_epilogue(&flags);
  ^~~~~~~~~~~~~~
lib/ubsan.c:155:13: note: declared here
 static void ubsan_epilogue(void)
             ^~~~~~~~~~~~~~

Signed-off-by: Tiejun Chen <tiejunc@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/ubsan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5830cc9a2164..199c75e03469 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -339,18 +339,17 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 void __ubsan_handle_vla_bound_not_positive(struct vla_bound_data *data,
 					void *bound)
 {
-	unsigned long flags;
 	char bound_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(bound_str, sizeof(bound_str), data->type, bound);
 	pr_err("variable length array bound value %s <= 0\n", bound_str);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_vla_bound_not_positive);
 
-- 
2.25.1


