Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC826C7EE29
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jun 2023 01:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFIBME (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjFIBMD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2023 21:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A1E47
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jun 2023 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686273075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKgOLKDTsYWvdqsp1XsUosocX8QvfGur3sjYjMRA4Fk=;
        b=U8ZwHPAY88aFISsIirI3VF5v5Cge2wmsEAU8W4O89yeWEH0YcZmx3LEMlngkxe0kBIPahd
        UKpwr1tIdT5ZEETK5miC7lkVYODQzjm3Mipij24/3/5IQsznJlB2emHIVfXVEpLLNaDsxY
        ZM7Qajg42tCtE1jxr9mll6lp7DfrLxw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-8dVApdFIOWSeDR8Ya2cpxg-1; Thu, 08 Jun 2023 21:11:09 -0400
X-MC-Unique: 8dVApdFIOWSeDR8Ya2cpxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AC953C0C88F;
        Fri,  9 Jun 2023 01:11:08 +0000 (UTC)
Received: from localhost (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 321C1140E955;
        Fri,  9 Jun 2023 01:11:08 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 2/3] Revert "mm/page_alloc: fix potential deadlock on zonelist_update_seqseqlock"
Date:   Thu,  8 Jun 2023 22:11:03 -0300
Message-Id: <20230609011104.967128-3-lgoncalv@redhat.com>
In-Reply-To: <20230609011104.967128-1-lgoncalv@redhat.com>
References: <20230609011104.967128-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v5.10.180-rt89-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts commit a992c387b41186ab968fd176ca26b432b05c53ec.

The support for deferred printing was removed in v5.10-rc1-rt1 by commit
9153e3c5cb0c9 ("printk: remove deferred printing") because:

    Since printing occurs either atomically or from the printing
    kthread, there is no need for any deferring or tracking possible
    recursion paths. Remove all printk context tracking.

Also, disabling interrupts in __build_all_zonelists() should produce warnings
once that code path is hit.

Fixes: a992c387b4118 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
Fixes: 083183f8bea0f ("rt: printk: remove new references to deferred printing")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 mm/page_alloc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7e65e3ef16e3a..3760a06932a6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6043,20 +6043,7 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
-	unsigned long flags;
 
-	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
-	 */
-	local_irq_save(flags);
-	/*
-	 * Explicitly disable this CPU's synchronous printk() before taking
-	 * seqlock to prevent any printk() from trying to hold port->lock, for
-	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
-	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
-	 */
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -6091,7 +6078,6 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
-	local_irq_restore(flags);
 }
 
 static noinline void __init
-- 
2.40.1

