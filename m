Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6023AE9A
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062507; cv=none; b=mFh2LpMPeesZNdo6RwjyavRW36SekTuGRiU5wxWZes+huYHNjsqnSi5XyZwZMz5wjkLpBfwjtzBKrK5PJM819+r32m2XfrSBgO2a6CPh15imdGQQh/mFSTEJewBv6snTmYSoMA248Qp4HyxPoz2uRl5OHg11oyw4WhuEzextBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062507; c=relaxed/simple;
	bh=rgbpyEo9yesEYS317IDBebT1raLV8o1R74Gy5nN4vq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWWMOnnw2t5/1l8cp+Lh/Vyyp4xMmSGdItxPY0fgNd5m40/lrhbpucC7HHtWhnhsSkEDqjgpcrVJJ0UvuDnu7Uz481XXkYgFQzDhXxumRA6FHoIgTTpy8whMaSGFcfSFbYhJJFhlnckfZjvvhk3FVMrXJiHxVXpyd5q5E3eZJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItoUVL5Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItoUVL5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6H4lFQIk2GUxhWy2FavpB0N+OJc57BACchLCrA27a1U=;
	b=ItoUVL5Y1oLDgwf0Rt3yG3bfo7BnJj+C1LFeY4HeF4uYmUnE8iq+j973vFv4OGiuWC568D
	wnd5gMgR542blqFjqx85B24GSDm+vu8T7XLIcSyMNBF9SS4zSQRR6KRU302mACe+QlBhcf
	X4AXt3E05KLU5agMYYZOwr9JNWy9MfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-lxSJ0cpBPna8JeQLVcT6ww-1; Tue,
 21 Oct 2025 12:01:41 -0400
X-MC-Unique: lxSJ0cpBPna8JeQLVcT6ww-1
X-Mimecast-MFC-AGG-ID: lxSJ0cpBPna8JeQLVcT6ww_1761062500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A823B195605C;
	Tue, 21 Oct 2025 16:01:39 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EAE901800577;
	Tue, 21 Oct 2025 16:01:35 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:01:34 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 03/12] sched_debug: Fix double-free crash in
 fill_waiting_task()
Message-ID: <67xq4zr7dr6d5k362dcmalwlxjcvtljcowx6eah5q4e57enyid@z4atth7l454r>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-3-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-3-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 16, 2025 at 09:24:35PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> Fix a critical double-free bug that occurs when fill_waiting_task()
> returns early without allocating new memory for cpu_info->starving.
> 
> Root cause:
> In sched_debug_parse(), the code saves old_tasks = cpu_info->starving,
> then calls fill_waiting_task(). If fill_waiting_task() returns early
> (nr_entries <= 0 or cpu_info == NULL), it doesn't allocate new memory
> or update cpu_info->starving. This leaves cpu_info->starving pointing
> to the old memory. When the code later frees old_tasks, it's freeing
> the same memory that cpu_info->starving still points to. On the next
> iteration, old_tasks again points to this already-freed memory, causing
> a double-free crash.
> 
> Example crash sequence:
> 1. First parse: cpu_info->starving = malloc(memory A)
> 2. Second parse: old_tasks = memory A
>                  nr_entries = 5, so cpu_info->starving = malloc(memory B)
>                  free(old_tasks) ??? frees memory A
> 3. Third parse:  old_tasks = memory B
>                  nr_entries = 0, so fill_waiting_task() returns early
>                  cpu_info->starving still points to memory B
>                  free(old_tasks) ??? frees memory B
> 4. Fourth parse: old_tasks = memory B (already freed!)
>                  nr_entries > 0, so cpu_info->starving = malloc(memory C)
>                  free(old_tasks) ??? DOUBLE FREE of memory B ??? CRASH
> 
> The fix:
> Explicitly set cpu_info->starving = NULL in fill_waiting_task() when
> returning early without allocation. This ensures that cpu_info->starving
> never points to freed memory, preventing the double-free.
> 
> Impact:
> - Prevents random crashes in sched_debug backend
> - Enables stable operation with varying numbers of runnable tasks
> - Critical for test suite reliability
> 
> Testing:
> - Verified no crash with: sudo stalld -f -v -N -b sched_debug -t 3 -c 0 -l
> - Runs stably for extended periods without crashes
> 
> ???? Generated with [Claude Code](https://claude.com/claude-code)
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/sched_debug.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_debug.c b/src/sched_debug.c
> index 04a12ef2a7c2..102a4e02d57d 100644
> --- a/src/sched_debug.c
> +++ b/src/sched_debug.c
> @@ -525,6 +525,7 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
>  
>  	if (cpu_info == NULL) {
>  		warn("NULL cpu_info pointer!\n");
> +		cpu_info->starving = NULL;
>  		return 0;
>  	}
>  
> @@ -533,8 +534,10 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
>  	else
>  		nr_entries = cpu_info->nr_running;
>  
> -	if (nr_entries <= 0)
> +	if (nr_entries <= 0) {
> +		cpu_info->starving = NULL;
>  		return 0;
> +	}
>  
>  	cpu_info->starving = malloc(sizeof(struct task_info) * nr_entries);
>  	if (cpu_info->starving == NULL) {
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

