Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F66C7EE23
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Mar 2023 20:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCAUCs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAUCr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2023 15:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA874E5D2
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Mar 2023 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677700921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=nN8Fr1WAfIHyt9LHX11WffsARPP10wvc09ZhUaWeiao=;
        b=AjjOgwLdQB/enG83fuLsnFVbbBEH2WXR7PTmKzoGFrFGaxebWzcTmVUi9RUYiGO4pTbH1O
        jUiHy5YMvMaTBO0cqUozzBtpH0NQ0RBdVNgQGYUaHFNOKvTPRHvYDGdheXbum1Wc1HUbyJ
        gdiU6rOmrG8USQBnhlE3brpkhaFjLP0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Nqe7Zz1zODSngwgBWRDfmA-1; Wed, 01 Mar 2023 14:55:56 -0500
X-MC-Unique: Nqe7Zz1zODSngwgBWRDfmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CB5B18A64E3
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Mar 2023 19:55:56 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC06FC15BAD;
        Wed,  1 Mar 2023 19:55:55 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0E723400E05C0; Wed,  1 Mar 2023 16:55:37 -0300 (-03)
Date:   Wed, 1 Mar 2023 16:55:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: cyclictest: write tracemark if latency above spike value
Message-ID: <Y/+tuRphtuNBuXEf@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


It is useful to have the following ranges:

	Value			Behaviour

	> break_lat	   -> write tracemark entry, quit cyclictest.

	[spike, break_lat] -> write tracemark entry, continue execution.

	< spike		   -> no tracemark entry, continue execution.


So one can know which events are causing "close to break value"
(and their causes).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 82759d1..22eab05 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1698,6 +1698,9 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 	}
 	spikes++;
 	pthread_mutex_unlock(&trigger_lock);
+	if (trace_marker && diff > trigger) {
+		tracemark_nostop("hit latency trigger (%d > %d)", diff, trigger);
+	}
 }
 
 /* Running status shared memory open */
@@ -1892,7 +1895,7 @@ int main(int argc, char **argv)
 	/* use the /dev/cpu_dma_latency trick if it's there */
 	set_latency_target();
 
-	if (tracelimit && trace_marker)
+	if ((tracelimit && trace_marker) || (trigger && trace_marker))
 		enable_trace_mark();
 
 	if (check_timer())
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index f6b3fed..85a459f 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -32,6 +32,7 @@ int parse_mem_string(char *str, uint64_t *val);
 
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void tracemark_nostop(char *fmt, ...) __attribute__((format(printf, 1, 2)));
 void disable_trace_mark(void);
 
 #define MSEC_PER_SEC		1000
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6c0235d..daa8bb8 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -458,7 +458,7 @@ static void debugfs_prepare(void)
 		     "debug fs not mounted");
 }
 
-void tracemark(char *fmt, ...)
+void tracemark_nostop(char *fmt, ...)
 {
 	va_list ap;
 	int len;
@@ -474,6 +474,21 @@ void tracemark(char *fmt, ...)
 
 	/* write the tracemark message */
 	write(tracemark_fd, tracebuf, len);
+}
+
+void tracemark(char *fmt, ...)
+{
+	va_list ap;
+	int len;
+
+	/* bail out if we're not tracing */
+	/* or if the kernel doesn't support trace_mark */
+	if (tracemark_fd < 0 || trace_fd < 0)
+		return;
+
+	va_start(ap, fmt);
+	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
+	va_end(ap);
 
 	/* now stop any trace */
 	write(trace_fd, "0\n", 2);


