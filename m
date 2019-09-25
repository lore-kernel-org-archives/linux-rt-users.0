Return-Path: <SRS0=768X=XU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEFC432C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Sep 2019 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F0F214D9
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Sep 2019 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfIYJtB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:49:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:50620 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfIYJtA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Sep 2019 05:49:00 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iD3uj-00051l-Cf; Wed, 25 Sep 2019 12:48:49 +0300
Subject: Re: [RFC PATCH] lib/ubsan: Don't seralize UBSAN report
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org,
        Andre Przywara <andre.przywara@arm.com>
References: <20190920100835.14999-1-julien.grall@arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <415424b0-b410-8693-c031-56c85f13fc0c@virtuozzo.com>
Date:   Wed, 25 Sep 2019 12:48:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920100835.14999-1-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 9/20/19 1:08 PM, Julien Grall wrote:
> At the moment, UBSAN report will be serialized using a spin_lock(). On
> RT-systems, spinlocks are turned to rt_spin_lock and may sleep. This will
> result to the following splat if the undefined behavior is in a context
> that can sleep:
> 
> [ 6951.484876] BUG: sleeping function called from invalid context at /src/linux/kernel/locking/rtmutex.c:968
> [ 6951.484882] in_atomic(): 1, irqs_disabled(): 128, pid: 3447, name: make
> [ 6951.484884] 1 lock held by make/3447:
> [ 6951.484885]  #0: 000000009a966332 (&mm->mmap_sem){++++}, at: do_page_fault+0x140/0x4f8
> [ 6951.484895] irq event stamp: 6284
> [ 6951.484896] hardirqs last  enabled at (6283): [<ffff000011326520>] _raw_spin_unlock_irqrestore+0x90/0xa0
> [ 6951.484901] hardirqs last disabled at (6284): [<ffff0000113262b0>] _raw_spin_lock_irqsave+0x30/0x78
> [ 6951.484902] softirqs last  enabled at (2430): [<ffff000010088ef8>] fpsimd_restore_current_state+0x60/0xe8
> [ 6951.484905] softirqs last disabled at (2427): [<ffff000010088ec0>] fpsimd_restore_current_state+0x28/0xe8
> [ 6951.484907] Preemption disabled at:
> [ 6951.484907] [<ffff000011324a4c>] rt_mutex_futex_unlock+0x4c/0xb0
> [ 6951.484911] CPU: 3 PID: 3447 Comm: make Tainted: G        W         5.2.14-rt7-01890-ge6e057589653 #911
> [ 6951.484913] Call trace:
> [ 6951.484913]  dump_backtrace+0x0/0x148
> [ 6951.484915]  show_stack+0x14/0x20
> [ 6951.484917]  dump_stack+0xbc/0x104
> [ 6951.484919]  ___might_sleep+0x154/0x210
> [ 6951.484921]  rt_spin_lock+0x68/0xa0
> [ 6951.484922]  ubsan_prologue+0x30/0x68
> [ 6951.484924]  handle_overflow+0x64/0xe0
> [ 6951.484926]  __ubsan_handle_add_overflow+0x10/0x18
> [ 6951.484927]  __lock_acquire+0x1c28/0x2a28
> [ 6951.484929]  lock_acquire+0xf0/0x370
> [ 6951.484931]  _raw_spin_lock_irqsave+0x58/0x78
> [ 6951.484932]  rt_mutex_futex_unlock+0x4c/0xb0
> [ 6951.484933]  rt_spin_unlock+0x28/0x70
> [ 6951.484934]  get_page_from_freelist+0x428/0x2b60
> [ 6951.484936]  __alloc_pages_nodemask+0x174/0x1708
> [ 6951.484938]  alloc_pages_vma+0x1ac/0x238
> [ 6951.484940]  __handle_mm_fault+0x4ac/0x10b0
> [ 6951.484941]  handle_mm_fault+0x1d8/0x3b0
> [ 6951.484942]  do_page_fault+0x1c8/0x4f8
> [ 6951.484943]  do_translation_fault+0xb8/0xe0
> [ 6951.484945]  do_mem_abort+0x3c/0x98
> [ 6951.484946]  el0_da+0x20/0x24
> 
> The spin_lock() will protect against multiple CPUs to output a report
> together, I guess to prevent them to be interleaved. However, they can
> still interleave with other messages (and even splat from __migth_sleep).
> 
> So the lock usefulness seems pretty limited. Rather than trying to
> accomodate RT-system by switching to a raw_spin_lock(), the lock is now
> completely dropped.
> 
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>


>  lib/ubsan.c | 64 ++++++++++++++++++++++---------------------------------------
>  1 file changed, 23 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index e7d31735950d..39d5952c4273 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -140,25 +140,21 @@ static void val_to_string(char *str, size_t size, struct type_descriptor *type,
>  	}
>  }
>  
> -static DEFINE_SPINLOCK(report_lock);
> -
> -static void ubsan_prologue(struct source_location *location,
> -			unsigned long *flags)
> +static void ubsan_prologue(struct source_location *location)
>  {
>  	current->in_ubsan++;
> -	spin_lock_irqsave(&report_lock, *flags);
>  
>  	pr_err("========================================"
>  		"========================================\n");
>  	print_source_location("UBSAN: Undefined behaviour in", location);
>  }
>  
> -static void ubsan_epilogue(unsigned long *flags)
> +static void ubsan_epilogue(void)
>  {
>  	dump_stack();
>  	pr_err("========================================"
>  		"========================================\n");
> -	spin_unlock_irqrestore(&report_lock, *flags);
> +
>  	current->in_ubsan--;
>  }
>  
> @@ -167,14 +163,13 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>  {
>  
>  	struct type_descriptor *type = data->type;
> -	unsigned long flags;
>  	char lhs_val_str[VALUE_LENGTH];
>  	char rhs_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
>  	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
> @@ -186,7 +181,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>  		rhs_val_str,
>  		type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  void __ubsan_handle_add_overflow(struct overflow_data *data,
> @@ -214,20 +209,19 @@ EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
>  void __ubsan_handle_negate_overflow(struct overflow_data *data,
>  				void *old_val)
>  {
> -	unsigned long flags;
>  	char old_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
>  
>  	pr_err("negation of %s cannot be represented in type %s:\n",
>  		old_val_str, data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
>  
> @@ -235,13 +229,12 @@ EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
>  void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>  				void *lhs, void *rhs)
>  {
> -	unsigned long flags;
>  	char rhs_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
>  
> @@ -251,58 +244,52 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>  	else
>  		pr_err("division by zero\n");
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
>  
>  static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  
>  	pr_err("%s null pointer of type %s\n",
>  		type_check_kinds[data->type_check_kind],
>  		data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void handle_misaligned_access(struct type_mismatch_data_common *data,
>  				unsigned long ptr)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  
>  	pr_err("%s misaligned address %p for type %s\n",
>  		type_check_kinds[data->type_check_kind],
>  		(void *)ptr, data->type->type_name);
>  	pr_err("which requires %ld byte alignment\n", data->alignment);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
>  					unsigned long ptr)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  	pr_err("%s address %p with insufficient space\n",
>  		type_check_kinds[data->type_check_kind],
>  		(void *) ptr);
>  	pr_err("for an object of type %s\n", data->type->type_name);
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
> @@ -351,25 +338,23 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
>  
>  void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
>  {
> -	unsigned long flags;
>  	char index_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(index_str, sizeof(index_str), data->index_type, index);
>  	pr_err("index %s is out of range for type %s\n", index_str,
>  		data->array_type->type_name);
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
>  
>  void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  					void *lhs, void *rhs)
>  {
> -	unsigned long flags;
>  	struct type_descriptor *rhs_type = data->rhs_type;
>  	struct type_descriptor *lhs_type = data->lhs_type;
>  	char rhs_str[VALUE_LENGTH];
> @@ -378,7 +363,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
>  	val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
> @@ -401,18 +386,16 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  			lhs_str, rhs_str,
>  			lhs_type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
>  
>  
>  void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
>  {
> -	unsigned long flags;
> -
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  	pr_err("calling __builtin_unreachable()\n");
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  	panic("can't return from __builtin_unreachable()");
>  }
>  EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
> @@ -420,19 +403,18 @@ EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
>  void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
>  				void *val)
>  {
> -	unsigned long flags;
>  	char val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(val_str, sizeof(val_str), data->type, val);
>  
>  	pr_err("load of value %s is not a valid value for type %s\n",
>  		val_str, data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
> 
