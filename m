Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A043BC11D3D
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7008F246A0
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582817853;
	bh=EglmyHB978SteMpFCYWohylMcvEFq9xj9fIqTPSUin8=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=FEHNF5fiA8SE3TOh5AlPkSqLI19xVJKO+bVIkI3xFl2z+qqsJhNZYRXCmwzKcwMPQ
	 HHVW+Gj6gUQx/ghhlu282ZhmIkq5d7JbUYukYK2d2ZsEWkZ2H7uSnZn108xYRQr5GF
	 cq1dS13gL1E7l03nmxFNJRC5GebPzKuJvgbthYQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgB0Phd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgB0Phc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 10:37:32 -0500
Received: from tzanussi-mobl7 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0333524697;
        Thu, 27 Feb 2020 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582817852;
        bh=EglmyHB978SteMpFCYWohylMcvEFq9xj9fIqTPSUin8=;
        h=Subject:From:To:Cc:Date:From;
        b=VMgLisyRaBS1vAGkJjDjpcnpdYeWfC9tzBr+GTFo1fBx6bRXe3aOxzygVbDU+PmC9
         Zx+4xUv9FWLJQYAO01UYTKDXv+i2l1Iva5VuXf1J45ran8edfcF4FQd6wFWiW/2Tsz
         qfu+rZDXfrWQc+EZrOgL14p3I2klSJ7Kmzz1KNg8=
Message-ID: <1582817850.12738.43.camel@kernel.org>
Subject: [PATCH 4.19-rt] lib/ubsan: Remove flags from stray
 ubsan_prolog/epilog() calls
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Thu, 27 Feb 2020 09:37:30 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When applying the upstream commit 4702c28ac777 [lib/ubsan: Don't
seralize UBSAN report] to 4.14 and building with CONFIG_UBSAN, I got a
compile error and fixed it as below.  Realizing that 4.19 might have
the same problem, I checked and found that it did, which this patch
fixes.

Fixes 4.19-rt commit 73b845faa4ec [lib/ubsan: Don't seralize UBSAN
report].

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.14.1

