Return-Path: <SRS0=su7P=WO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD678C3A589
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Aug 2019 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EA621773
	for <linux-rt-users@archiver.kernel.org>; Sun, 18 Aug 2019 09:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHRJKk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:10:40 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:34710 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRJKk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Aug 2019 05:10:40 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:244:b080:7446:96cf:df6:1525])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 28A9678035D;
        Sun, 18 Aug 2019 11:10:36 +0200 (CEST)
Subject: Re: Kernel 5.0.21rt16 hangs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <f410b429-db86-f81c-7c67-f563fa808b62@free.fr>
 <20190814144207.qi7qtcpvyfpoc7cj@linutronix.de>
From:   Yann COLLETTE <ycollette.nospam@free.fr>
Message-ID: <50eb3b28-b402-8395-6695-b7ba5ae8f392@free.fr>
Date:   Sun, 18 Aug 2019 11:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814144207.qi7qtcpvyfpoc7cj@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-classic
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Thanks a lot.
I tested this patch on kernelt-5.0.21-rt16 and it fixed my problem.
No more freeze.

Best regards,

YC

Le 14/08/2019 à 16:42, Sebastian Andrzej Siewior a écrit :
> On 2019-08-09 17:45:13 [+0200], Yann COLLETTE wrote:
>> Hello,
> Hi,
>
>> I am using kernel-rt 5.0.21rt16 on fedora 30.
> …
>> Aug  9 17:16:35 localhost kernel: Preemption disabled at:
>> Aug  9 17:16:35 localhost kernel: [<ffffffff8c67239e>]
>> reservation_object_add_shared_fence+0x3e/0x1b0
>> Aug  9 17:16:35 localhost kernel: CPU: 3 PID: 1087 Comm: Xorg Not tainted
>> 5.0.21-rt16.fc30.x86_64 #1
>> Aug  9 17:16:35 localhost kernel: Hardware name: HP 450-a121nf/2B29, BIOS
>> A0.11 01/15/2016
>> Aug  9 17:16:35 localhost kernel: Call Trace:
>> Aug  9 17:16:35 localhost kernel: dump_stack+0x5c/0x80
>> Aug  9 17:16:35 localhost kernel: ?
>> reservation_object_add_shared_fence+0x3e/0x1b0
>> Aug  9 17:16:35 localhost kernel: __schedule_bug.cold+0x44/0x51
>> Aug  9 17:16:35 localhost kernel: __schedule+0x5c6/0x6f0
>> Aug  9 17:16:35 localhost kernel: schedule+0x43/0xd0
>> Aug  9 17:16:35 localhost kernel: rt_spin_lock_slowlock_locked+0x114/0x2b0
>> Aug  9 17:16:35 localhost kernel: rt_spin_lock_slowlock+0x51/0x80
>> Aug  9 17:16:35 localhost kernel: __wake_up_common_lock+0x61/0xb0
>> Aug  9 17:16:35 localhost kernel: radeon_fence_is_signaled+0x74/0x90
>> [radeon]
>> Aug  9 17:16:35 localhost kernel:
>> reservation_object_add_shared_fence+0x97/0x1b0
>> Aug  9 17:16:35 localhost kernel: radeon_vm_bo_update+0x409/0x640 [radeon]
>> Aug  9 17:16:35 localhost kernel: radeon_gem_va_ioctl+0x41c/0x500 [radeon]
> …
>> I don't know if this bug is related to the kernel of if this is a mesa
>> problem.
> That backtrace is kernel related. I'm not sure if this is related to the
> hang up you observe.
> Could you please try the following patch:
>
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index bf4d4c80fbc67..c6370dcdd77d2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -168,7 +168,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>   		return 0;
>   
>   retry:
> -	seq = read_seqcount_begin(&resv->seq);
> +	seq = read_seqbegin(&resv->seq);
>   	rcu_read_lock();
>   
>   	fobj = rcu_dereference(resv->fence);
> @@ -177,7 +177,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>   	else
>   		shared_count = 0;
>   	fence_excl = rcu_dereference(resv->fence_excl);
> -	if (read_seqcount_retry(&resv->seq, seq)) {
> +	if (read_seqretry(&resv->seq, seq)) {
>   		rcu_read_unlock();
>   		goto retry;
>   	}
> @@ -1034,12 +1034,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>   
>   		robj = buf_obj->resv;
>   		while (true) {
> -			seq = read_seqcount_begin(&robj->seq);
> +			seq = read_seqbegin(&robj->seq);
>   			rcu_read_lock();
>   			fobj = rcu_dereference(robj->fence);
>   			shared_count = fobj ? fobj->shared_count : 0;
>   			fence = rcu_dereference(robj->fence_excl);
> -			if (!read_seqcount_retry(&robj->seq, seq))
> +			if (!read_seqretry(&robj->seq, seq))
>   				break;
>   			rcu_read_unlock();
>   		}
> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
> index 4d32e2c678626..37d8f6b18ef90 100644
> --- a/drivers/dma-buf/reservation.c
> +++ b/drivers/dma-buf/reservation.c
> @@ -110,15 +110,13 @@ int reservation_object_reserve_shared(struct reservation_object *obj,
>   	new->shared_count = j;
>   	new->shared_max = max;
>   
> -	preempt_disable();
> -	write_seqcount_begin(&obj->seq);
> +	write_seqlock(&obj->seq);
>   	/*
>   	 * RCU_INIT_POINTER can be used here,
>   	 * seqcount provides the necessary barriers
>   	 */
>   	RCU_INIT_POINTER(obj->fence, new);
> -	write_seqcount_end(&obj->seq);
> -	preempt_enable();
> +	write_sequnlock(&obj->seq);
>   
>   	if (!old)
>   		return 0;
> @@ -158,8 +156,7 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
>   	fobj = reservation_object_get_list(obj);
>   	count = fobj->shared_count;
>   
> -	preempt_disable();
> -	write_seqcount_begin(&obj->seq);
> +	write_seqlock(&obj->seq);
>   
>   	for (i = 0; i < count; ++i) {
>   		struct dma_fence *old_fence;
> @@ -181,8 +178,7 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
>   	/* pointer update must be visible before we extend the shared_count */
>   	smp_store_mb(fobj->shared_count, count);
>   
> -	write_seqcount_end(&obj->seq);
> -	preempt_enable();
> +	write_sequnlock(&obj->seq);
>   }
>   EXPORT_SYMBOL(reservation_object_add_shared_fence);
>   
> @@ -209,14 +205,11 @@ void reservation_object_add_excl_fence(struct reservation_object *obj,
>   	if (fence)
>   		dma_fence_get(fence);
>   
> -	preempt_disable();
> -	write_seqcount_begin(&obj->seq);
> -	/* write_seqcount_begin provides the necessary memory barrier */
> +	write_seqlock(&obj->seq);
>   	RCU_INIT_POINTER(obj->fence_excl, fence);
>   	if (old)
>   		old->shared_count = 0;
> -	write_seqcount_end(&obj->seq);
> -	preempt_enable();
> +	write_sequnlock(&obj->seq);
>   
>   	/* inplace update, no shared fences */
>   	while (i--)
> @@ -298,13 +291,10 @@ int reservation_object_copy_fences(struct reservation_object *dst,
>   	src_list = reservation_object_get_list(dst);
>   	old = reservation_object_get_excl(dst);
>   
> -	preempt_disable();
> -	write_seqcount_begin(&dst->seq);
> -	/* write_seqcount_begin provides the necessary memory barrier */
> +	write_seqlock(&dst->seq);
>   	RCU_INIT_POINTER(dst->fence_excl, new);
>   	RCU_INIT_POINTER(dst->fence, dst_list);
> -	write_seqcount_end(&dst->seq);
> -	preempt_enable();
> +	write_sequnlock(&dst->seq);
>   
>   	if (src_list)
>   		kfree_rcu(src_list, rcu);
> @@ -345,7 +335,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
>   		shared_count = i = 0;
>   
>   		rcu_read_lock();
> -		seq = read_seqcount_begin(&obj->seq);
> +		seq = read_seqbegin(&obj->seq);
>   
>   		fence_excl = rcu_dereference(obj->fence_excl);
>   		if (fence_excl && !dma_fence_get_rcu(fence_excl))
> @@ -390,7 +380,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
>   			}
>   		}
>   
> -		if (i != shared_count || read_seqcount_retry(&obj->seq, seq)) {
> +		if (i != shared_count || read_seqretry(&obj->seq, seq)) {
>   			while (i--)
>   				dma_fence_put(shared[i]);
>   			dma_fence_put(fence_excl);
> @@ -439,7 +429,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
>   
>   retry:
>   	shared_count = 0;
> -	seq = read_seqcount_begin(&obj->seq);
> +	seq = read_seqbegin(&obj->seq);
>   	rcu_read_lock();
>   	i = -1;
>   
> @@ -486,7 +476,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
>   
>   	rcu_read_unlock();
>   	if (fence) {
> -		if (read_seqcount_retry(&obj->seq, seq)) {
> +		if (read_seqretry(&obj->seq, seq)) {
>   			dma_fence_put(fence);
>   			goto retry;
>   		}
> @@ -542,7 +532,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
>   retry:
>   	ret = true;
>   	shared_count = 0;
> -	seq = read_seqcount_begin(&obj->seq);
> +	seq = read_seqbegin(&obj->seq);
>   
>   	if (test_all) {
>   		unsigned i;
> @@ -563,7 +553,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
>   				break;
>   		}
>   
> -		if (read_seqcount_retry(&obj->seq, seq))
> +		if (read_seqretry(&obj->seq, seq))
>   			goto retry;
>   	}
>   
> @@ -576,7 +566,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
>   			if (ret < 0)
>   				goto retry;
>   
> -			if (read_seqcount_retry(&obj->seq, seq))
> +			if (read_seqretry(&obj->seq, seq))
>   				goto retry;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a6e5184d436c9..b5fbd16034122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -250,11 +250,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	new->shared_count = k;
>   
>   	/* Install the new fence list, seqcount provides the barriers */
> -	preempt_disable();
> -	write_seqcount_begin(&resv->seq);
> +	write_seqlock(&resv->seq);
>   	RCU_INIT_POINTER(resv->fence, new);
> -	write_seqcount_end(&resv->seq);
> -	preempt_enable();
> +	write_sequnlock(&resv->seq);
>   
>   	/* Drop the references to the removed fences or move them to ef_list */
>   	for (i = j, k = 0; i < old->shared_count; ++i) {
> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> index ad01c92aaf748..2910a133077a3 100644
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -449,7 +449,7 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
>   				 unsigned int flags,
>   				 long timeout)
>   {
> -	unsigned int seq = __read_seqcount_begin(&resv->seq);
> +	unsigned int seq = read_seqbegin(&resv->seq);
>   	struct dma_fence *excl;
>   	bool prune_fences = false;
>   
> @@ -500,9 +500,9 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
>   	 * signaled and that the reservation object has not been changed (i.e.
>   	 * no new fences have been added).
>   	 */
> -	if (prune_fences && !__read_seqcount_retry(&resv->seq, seq)) {
> +	if (prune_fences && !read_seqretry(&resv->seq, seq)) {
>   		if (reservation_object_trylock(resv)) {
> -			if (!__read_seqcount_retry(&resv->seq, seq))
> +			if (!read_seqretry(&resv->seq, seq))
>   				reservation_object_add_excl_fence(resv, NULL);
>   			reservation_object_unlock(resv);
>   		}
> @@ -3943,7 +3943,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
>   	 *
>   	 */
>   retry:
> -	seq = raw_read_seqcount(&obj->resv->seq);
> +	seq = read_seqbegin(&obj->resv->seq);
>   
>   	/* Translate the exclusive fence to the READ *and* WRITE engine */
>   	args->busy = busy_check_writer(rcu_dereference(obj->resv->fence_excl));
> @@ -3961,7 +3961,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	if (args->busy && read_seqcount_retry(&obj->resv->seq, seq))
> +	if (args->busy && read_seqretry(&obj->resv->seq, seq))
>   		goto retry;
>   
>   	err = 0;
> diff --git a/include/linux/reservation.h b/include/linux/reservation.h
> index ee750765cc941..11cc05f489365 100644
> --- a/include/linux/reservation.h
> +++ b/include/linux/reservation.h
> @@ -71,7 +71,7 @@ struct reservation_object_list {
>    */
>   struct reservation_object {
>   	struct ww_mutex lock;
> -	seqcount_t seq;
> +	seqlock_t seq;
>   
>   	struct dma_fence __rcu *fence_excl;
>   	struct reservation_object_list __rcu *fence;
> @@ -90,7 +90,7 @@ reservation_object_init(struct reservation_object *obj)
>   {
>   	ww_mutex_init(&obj->lock, &reservation_ww_class);
>   
> -	__seqcount_init(&obj->seq, reservation_seqcount_string, &reservation_seqcount_class);
> +	seqlock_init(&obj->seq);
>   	RCU_INIT_POINTER(obj->fence, NULL);
>   	RCU_INIT_POINTER(obj->fence_excl, NULL);
>   }


