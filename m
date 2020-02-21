Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FBC35666
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFDC206EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320391;
	bh=PL3ARuBtrQ1fVJQpeUG6r9odQMSABBgCWQJmf5DOwdk=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ncGy/SxnvZLAY/t0GG6ysCIL4XU250UlslvxZQn5+UxxxNoLqUl1Nc03FFL4b7aZK
	 jDRvhvg1/hIgaC6C60I0yd0zaeKzA5RHbl0M2lAnT+tSaslOqmULaXJrzeqiXGueUO
	 qsCTj7cBeBS6+C5TaE7qH5vcmUakG9BGzQ8L11O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgBUV02 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgBUVZ2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:28 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52BE824683;
        Fri, 21 Feb 2020 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320328;
        bh=PL3ARuBtrQ1fVJQpeUG6r9odQMSABBgCWQJmf5DOwdk=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=aHkctyYZVhKo76tPv28JvsQ0anWlNuvePoP5T9IrAdeE1kgdu1tNVpaLopZumSQ8G
         /ObzrF4H2/z/YwsCzkoqGHFl9ubk8EsHEQOoZol95GHlMxkM4JYOb6JG0XJO6b7Tsy
         ntOtFZELlEPNlg5B32ek5JAiQMg0jAcak9TUAPj8=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 13/25] lib/ubsan: Don't seralize UBSAN report
Date:   Fri, 21 Feb 2020 15:24:41 -0600
Message-Id: <979d699889bdefd12405df031feb27f4256d895d.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commmit 4702c28ac777b27acb499cbd5e8e787ce1a7d82d ]

At the moment, UBSAN report will be serialized using a spin_lock(). On
RT-systems, spinlocks are turned to rt_spin_lock and may sleep. This will
result to the following splat if the undefined behavior is in a context
that can sleep:

| BUG: sleeping function called from invalid context at /src/linux/kernel/locking/rtmutex.c:968
| in_atomic(): 1, irqs_disabled(): 128, pid: 3447, name: make
| 1 lock held by make/3447:
|  #0: 000000009a966332 (&mm->mmap_sem){++++}, at: do_page_fault+0x140/0x4f8
| Preemption disabled at:
| [<ffff000011324a4c>] rt_mutex_futex_unlock+0x4c/0xb0
| CPU: 3 PID: 3447 Comm: make Tainted: G        W         5.2.14-rt7-01890-ge6e057589653 #911
| Call trace:
|  dump_backtrace+0x0/0x148
|  show_stack+0x14/0x20
|  dump_stack+0xbc/0x104
|  ___might_sleep+0x154/0x210
|  rt_spin_lock+0x68/0xa0
|  ubsan_prologue+0x30/0x68
|  handle_overflow+0x64/0xe0
|  __ubsan_handle_add_overflow+0x10/0x18
|  __lock_acquire+0x1c28/0x2a28
|  lock_acquire+0xf0/0x370
|  _raw_spin_lock_irqsave+0x58/0x78
|  rt_mutex_futex_unlock+0x4c/0xb0
|  rt_spin_unlock+0x28/0x70
|  get_page_from_freelist+0x428/0x2b60
|  __alloc_pages_nodemask+0x174/0x1708
|  alloc_pages_vma+0x1ac/0x238
|  __handle_mm_fault+0x4ac/0x10b0
|  handle_mm_fault+0x1d8/0x3b0
|  do_page_fault+0x1c8/0x4f8
|  do_translation_fault+0xb8/0xe0
|  do_mem_abort+0x3c/0x98
|  el0_da+0x20/0x24

The spin_lock() will protect against multiple CPUs to output a report
together, I guess to prevent them to be interleaved. However, they can
still interleave with other messages (and even splat from __migth_sleep).

So the lock usefulness seems pretty limited. Rather than trying to
accomodate RT-system by switching to a raw_spin_lock(), the lock is now
completely dropped.

Link: https://lkml.kernel.org/r/20190920100835.14999-1-julien.grall@arm.com
Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Julien Grall <julien.grall@arm.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	lib/ubsan.c
---
 lib/ubsan.c | 76 ++++++++++++++++++++++---------------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index c652b4a820cc..f94cfb3a41ed 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -147,26 +147,21 @@ static bool location_is_valid(struct source_location *loc)
 {
 	return loc->file_name != NULL;
 }
-
-static DEFINE_SPINLOCK(report_lock);
-
-static void ubsan_prologue(struct source_location *location,
-			unsigned long *flags)
+static void ubsan_prologue(struct source_location *location)
 {
 	current->in_ubsan++;
-	spin_lock_irqsave(&report_lock, *flags);
 
 	pr_err("========================================"
 		"========================================\n");
 	print_source_location("UBSAN: Undefined behaviour in", location);
 }
 
-static void ubsan_epilogue(unsigned long *flags)
+static void ubsan_epilogue(void)
 {
 	dump_stack();
 	pr_err("========================================"
 		"========================================\n");
-	spin_unlock_irqrestore(&report_lock, *flags);
+
 	current->in_ubsan--;
 }
 
@@ -175,14 +170,13 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 {
 
 	struct type_descriptor *type = data->type;
-	unsigned long flags;
 	char lhs_val_str[VALUE_LENGTH];
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
@@ -194,7 +188,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 		rhs_val_str,
 		type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 void __ubsan_handle_add_overflow(struct overflow_data *data,
@@ -222,20 +216,19 @@ EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
 void __ubsan_handle_negate_overflow(struct overflow_data *data,
 				void *old_val)
 {
-	unsigned long flags;
 	char old_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
 
 	pr_err("negation of %s cannot be represented in type %s:\n",
 		old_val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 
@@ -243,13 +236,12 @@ EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 				void *lhs, void *rhs)
 {
-	unsigned long flags;
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
 
@@ -259,58 +251,52 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 	else
 		pr_err("division by zero\n");
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
 
 static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s null pointer of type %s\n",
 		type_check_kinds[data->type_check_kind],
 		data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_misaligned_access(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s misaligned address %p for type %s\n",
 		type_check_kinds[data->type_check_kind],
 		(void *)ptr, data->type->type_name);
 	pr_err("which requires %ld byte alignment\n", data->alignment);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 					unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 	pr_err("%s address %p with insufficient space\n",
 		type_check_kinds[data->type_check_kind],
 		(void *) ptr);
 	pr_err("for an object of type %s\n", data->type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
@@ -356,12 +342,10 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 
 void __ubsan_handle_nonnull_return(struct nonnull_return_data *data)
 {
-	unsigned long flags;
-
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	pr_err("null pointer returned from function declared to never return null\n");
 
@@ -369,49 +353,46 @@ void __ubsan_handle_nonnull_return(struct nonnull_return_data *data)
 		print_source_location("returns_nonnull attribute specified in",
 				&data->attr_location);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_nonnull_return);
 
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
 
 void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
 {
-	unsigned long flags;
 	char index_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(index_str, sizeof(index_str), data->index_type, index);
 	pr_err("index %s is out of range for type %s\n", index_str,
 		data->array_type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
 
 void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 					void *lhs, void *rhs)
 {
-	unsigned long flags;
 	struct type_descriptor *rhs_type = data->rhs_type;
 	struct type_descriptor *lhs_type = data->lhs_type;
 	char rhs_str[VALUE_LENGTH];
@@ -420,7 +401,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
 	val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
@@ -443,18 +424,16 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 			lhs_str, rhs_str,
 			lhs_type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
 void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
-	unsigned long flags;
-
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 	pr_err("calling __builtin_unreachable()\n");
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 	panic("can't return from __builtin_unreachable()");
 }
 EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
@@ -462,19 +441,18 @@ EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
 void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
 				void *val)
 {
-	unsigned long flags;
 	char val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(val_str, sizeof(val_str), data->type, val);
 
 	pr_err("load of value %s is not a valid value for type %s\n",
 		val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
-- 
2.14.1

