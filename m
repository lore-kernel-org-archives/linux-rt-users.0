Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0049AC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 18:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiA1Skb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235580AbiA1Sk3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 13:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643395229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS8Tt48QFgO0c/9JoP1T++djIXJAgA+f5Vo+y+r1GII=;
        b=DzLnmldQOXrCqG3jxlpwdP7dZAVZtVFpQ24+jETzRyQfecCzwZWvJ9zPIIsoS66WlsqNN5
        qhlbUrdkK90qx8cMXBpE+QXSGRJDViH8epOLjHwDj1qggRe4dKZI0yKvuQY4nW5+DRkRoA
        Zt0t6Zu69zXDRdX6DvM3dHLZR1NEmGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-EIn0ysd5OtGadg7EMow_cQ-1; Fri, 28 Jan 2022 13:40:27 -0500
X-MC-Unique: EIn0ysd5OtGadg7EMow_cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AD4784DA40;
        Fri, 28 Jan 2022 18:40:26 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BD9077465;
        Fri, 28 Jan 2022 18:40:17 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A6A3D416CD79; Fri, 28 Jan 2022 15:39:59 -0300 (-03)
Date:   Fri, 28 Jan 2022 15:39:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3] rt-numa: ignore runtime cpumask if -a CPULIST is specified
Message-ID: <YfQ4f1CWDubRMlmA@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <YfBEDR4E2dNK8XzK@fuller.cnet>
 <YfBFaNrP/1LCgWoN@fuller.cnet>
 <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


When using isolcpus kernel command line option, the CPUs
specified at isolcpus= are not part of the run time environment
cpumask.

This causes "cyclictest -a isolatedcpus" to fail with:

WARN: Couldn't setaffinity in main thread: Invalid argument
FATAL: No allowable cpus to run on
# /dev/cpu_dma_latency set to 0us

To fix this, ignore the runtime cpumask if neither "+", "!"
are specified in the cpu list string.

Suggested by Sebastian Andrzej Siewior.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

v3: simplified version (John Kacur)
v2: fix changelog typo

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index ee5ab99..3eead80 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -131,7 +131,8 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 		return 0;
 	}
 
-	use_current_cpuset(max_cpus, mask);
+	if (strchr(str, '!') != NULL || strchr(str, '+') != NULL)
+		use_current_cpuset(max_cpus, mask);
 	*cpumask = mask;
 
 	return 0;

