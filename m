Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C48C10F14
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EF12183E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600777;
	bh=2OBE/cFCwpdJYJzETJ/GvlSo2GHShxpC+P75/bfURJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=f1t0QTYKN56CSIQl0lTslPC8R8q9/WTTHiVaOysu1MCZY+obR3+FN5kbXT9b31Spc
	 oQHHOP/LNXeO9FSaJb7u+x74ODO67xLly9FIZq8Wi05kl8S9MJKk61nVyvL7KHNFnX
	 FUcm7HbHtF/cJGpmx4qVa5DwdwZ1LR1Qdn+AfaDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbfDRPTU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388548AbfDRPTS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 11:19:18 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BD320674;
        Thu, 18 Apr 2019 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600757;
        bh=2OBE/cFCwpdJYJzETJ/GvlSo2GHShxpC+P75/bfURJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VP8NJ9L4XOQw0FDkk1X3lmTWYsvXAwZY9LT4D86hx8l+pFLCcPCU2Ldl08yg32urr
         OZbxnhL4P540xM0+12mxPnFIz8wpiPsHaTNM3W1RnR688o41wDVAdCTTocNKmxSZY1
         b4BxtTsY0jvj3xTHr6yQLWo5/EzsHQ6lcNooOtz0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 1/3] tracing: Prevent hist_field_var_ref() from accessing NULL tracing_map_elts
Date:   Thu, 18 Apr 2019 10:18:50 -0500
Message-Id: <64ec8dc15c14d305295b64cdfcc6b2b9dd14753f.1555597045.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1555597045.git.tom.zanussi@linux.intel.com>
References: <cover.1555597045.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

hist_field_var_ref() is an implementation of hist_field_fn_t(), which
can be called with a null tracing_map_elt elt param when assembling a
key in event_hist_trigger().

In the case of hist_field_var_ref() this doesn't make sense, because a
variable can only be resolved by looking it up using an already
assembled key i.e. a variable can't be used to assemble a key since
the key is required in order to access the variable.

Upper layers should prevent the user from constructing a key using a
variable in the first place, but in case one slips through, it
shouldn't cause a NULL pointer dereference.  Also if one does slip
through, we want to know about it, so emit a one-time warning in that
case.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Vincent Bernat <vincent@bernat.ch>
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a1136e043f17..453f51ef83ca 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1854,6 +1854,9 @@ static u64 hist_field_var_ref(struct hist_field *hist_field,
 	struct hist_elt_data *elt_data;
 	u64 var_val = 0;
 
+	if (WARN_ON_ONCE(!elt))
+		return var_val;
+
 	elt_data = elt->private_data;
 	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
 
-- 
2.14.1

