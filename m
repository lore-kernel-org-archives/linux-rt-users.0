Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E1AC35656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238424656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582299352;
	bh=QbZZjtKI98EjfR3SZ3C2xf5hCpMf0oGgUg0h9KzYhU8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q11+Vm0L4USNXI2cm821Nsab89K8srADa8EmrAsjFEHYQtmBObII/zzRUEraILZpb
	 +CbjSyDjluucS8ZXPvBJdi3/K2kUe+hlTTGEppABzuKaTKPv6c+HHpU5D12hwYUgGi
	 CgGoJ9NBU3GO5pXz8f2KD5ncXlUER+Icgx4eseps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBUPfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:35:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728583AbgBUPfv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 10:35:51 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-zqN5k-aUOhuAPMR5562QGA-1; Fri, 21 Feb 2020 10:35:47 -0500
X-MC-Unique: zqN5k-aUOhuAPMR5562QGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 895BE107ACC9;
        Fri, 21 Feb 2020 15:35:46 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8985919E9C;
        Fri, 21 Feb 2020 15:35:42 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracing: Fix trace entry and trace common fields for preempt_lazy_count
Date:   Fri, 21 Feb 2020 16:35:41 +0100
Message-Id: <20200221153541.681468-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When commit 65fd07df3588 added preempt_lazy_count into 'struct trace_entry'
it did not add 4 bytes padding. Also we need to update the common fields
for tracepoint, otherwise some tools (bpftrace) stop working due to missing
common fields.

Fixes: 65fd07df3588 ("x86: Support for lazy preemption")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h | 2 ++
 kernel/trace/trace_events.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f3b1ef07e4a5..51a3f5188923 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -65,6 +65,8 @@ struct trace_entry {
 	unsigned short		migrate_disable;
 	unsigned short		padding;
 	unsigned char		preempt_lazy_count;
+	unsigned char		padding1;
+	unsigned short		padding2;
 };
 
 #define TRACE_EVENT_TYPE_MAX						\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index accaae59a762..1fe37b7aeaff 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -183,6 +183,9 @@ static int trace_define_common_fields(void)
 	__common_field(int, pid);
 	__common_field(unsigned short, migrate_disable);
 	__common_field(unsigned short, padding);
+	__common_field(unsigned char,  preempt_lazy_count);
+	__common_field(unsigned char,  padding1);
+	__common_field(unsigned short, padding2);
 
 	return ret;
 }
-- 
2.24.1

