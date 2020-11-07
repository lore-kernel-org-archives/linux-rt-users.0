Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57595C388F9
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27299208E4
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 10:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgKGKVc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 7 Nov 2020 05:21:32 -0500
Received: from wp003.webpack.hosteurope.de ([80.237.132.10]:54164 "EHLO
        wp003.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgKGKVc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 7 Nov 2020 05:21:32 -0500
Received: from p548daada.dip0.t-ipconnect.de ([84.141.170.218] helo=kmk0.Speedport_W_724V_09011603_06_006); authenticated
        by wp003.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kbL05-0003bK-S7; Sat, 07 Nov 2020 10:59:13 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 4/4] rt-tests: oslat: Close trace fds
Date:   Sat,  7 Nov 2020 10:58:43 +0100
Message-Id: <20201107095843.11909-5-kurt@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107095843.11909-1-kurt@linutronix.de>
References: <20201107095843.11909-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;kurt@linutronix.de;1604744492;4ce37acd;
X-HE-SMSGID: 1kbL05-0003bK-S7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

oslat is also using enable_trace_mark() and never closes the fds. Add it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/oslat/oslat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 918e6733c066..0018c472e0c1 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -871,5 +871,7 @@ int main(int argc, char *argv[])
 		g.cpu_list = NULL;
 	}
 
+	disable_trace_mark();
+
 	return 0;
 }
-- 
2.26.2

