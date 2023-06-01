Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F0C77B7E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 23:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjFAXfS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFAXfS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 19:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AAF136
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685662471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pFeg/SKygwhsdXnwRnc8BHP9UgHkEfZsg23AUhyePT8=;
        b=ehg5TTSzOP0hAuIHFNV4Ce51PhGeCX+uW3d5GjZdyFS0iAlaF21tuMHm+eRhgGcpsVzaih
        kPgYZT1sxFKdA1ePZEy1KDxxXEwRP1EF9eKMJ4T3cKvx3TjxPS/zOigntXM1ozhxqXGRjU
        ut5ekko3tp8DCS+qrZyt+A/spS3XndE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-YQKa_gcmMHyfu53q_Zt2LA-1; Thu, 01 Jun 2023 19:34:28 -0400
X-MC-Unique: YQKa_gcmMHyfu53q_Zt2LA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C16243847091
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 23:34:27 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9091620296C6;
        Thu,  1 Jun 2023 23:34:27 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 58CE040155719; Thu,  1 Jun 2023 17:04:50 -0300 (-03)
Date:   Thu, 1 Jun 2023 17:04:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] oslat: remove newline from tracemark message
Message-ID: <ZHj54pQWZ/RfAE/l@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Remove the newline from the trace mark message: it breaks 
tools that expect the trace files to contain the standard 
trace format on each new trace line.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index b680f1e..99f86b8 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -337,8 +337,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	lat = (value * g.unit_per_us + t->counter_mhz - 1) / t->counter_mhz;
 	us = (double)lat / g.unit_per_us;
 	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
-		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n"
-		    "Stopping the test.\n";
+		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";
 		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
 			  g.precision, us);
 		err_quit(line, g.app_name, g.trace_threshold, t->core_i,

