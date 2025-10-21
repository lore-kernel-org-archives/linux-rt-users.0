Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF723C51C
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068770; cv=none; b=SwLNBq8CxAnWx09WCIdDa17/P27b+HYkvi1DaxG+RgQE11uSZgYuyXgQqNo/N6NTTLwZwZU+uR639XxOFu+bfoneT5dyVOAxY9cQjA/WkHJKZc67Jz5+U7zueUKzTmrnY8/zHIy+4iAZPEa0cIwldQpwAFOpmteLCwJcb47jGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068770; c=relaxed/simple;
	bh=25NrXSqc3s3IqdavtOjGci5ldVmFtt3D/Rull5ns1zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE4dRvyQtqWKj4gaycP6UpZfLxmbUC6A94xUXFZz+tOoMkt/wVVOfvpVDyJ9astjcPiFPBeDwFodPTug7WfoPnRiY6aTrPYR6CHS70ofntb6ilhzc3KSW2SHgB74WTdJNHx0K8RgruaojZ14aJDqyFygFyKMnk2v0BM1boIRnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQdvHMSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQdvHMSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761068767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5qBL8E5NlC3BJDGvN2VbQR3yi1IG0mqk6E+C6uFPWo=;
	b=DQdvHMSPvyfuNbp2qGH5u8ON4a/x/uX0QI3QacZd3VtkcvVK8lwidDPW9ckAZ3w7+Vcf3d
	CV1GJEAIF2jEU27OI2QAXK9qICsQeCnDddlgwKlXW5OSMeozsC4pSB9HWKMHaD5vBTZO5T
	09eqVXYrey5U45SgsJei/7t7TXtt8Jg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-YvpLm8hpPcWoSmexfkBNbQ-1; Tue,
 21 Oct 2025 13:46:01 -0400
X-MC-Unique: YvpLm8hpPcWoSmexfkBNbQ-1
X-Mimecast-MFC-AGG-ID: YvpLm8hpPcWoSmexfkBNbQ_1761068760
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A587019560B2;
	Tue, 21 Oct 2025 17:46:00 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D975F1956056;
	Tue, 21 Oct 2025 17:45:56 +0000 (UTC)
Date: Tue, 21 Oct 2025 14:45:54 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 12/12] Fix segfault in adaptive/aggressive modes
Message-ID: <fxlfycaccx2kbwy6wq3fgnlwp65tgx45nlphf7qt3ueqr2t26l@j5okqwujvic6>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-12-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-12-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 16, 2025 at 09:24:44PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> The merge_taks_info() function was unconditionally calling
> update_cpu_starving_vector() at line 389, but cpu_starving_vector
> is only allocated in single_threaded_main() (line 1007). This caused
> segmentation faults when running in adaptive or aggressive threading
> modes.
> 
> The fix guards both update_cpu_starving_vector() calls with
> config_single_threaded checks, since this vector is only used
> in single-threaded/power mode.
> 
> Root cause: cpu_starving_vector is a global array used exclusively
> by single-threaded mode to track one starving task per CPU. The
> merge_taks_info() function is called by both backends during parsing,
> regardless of threading mode. In adaptive/aggressive modes, the
> vector remains NULL, causing crashes when accessed.
> 
> Crash backtrace:
>   conservative_main() ??? get_cpu_and_parse() ??? sched_debug_parse() ???
>   merge_taks_info() ??? update_cpu_starving_vector() ??? SEGFAULT at
>   line 362: if (cpu_info->pid)
> 
> This fix allows test_starvation_threshold.sh to pass on sched_debug
> backend with adaptive mode (-M flag).
> 
> ???? Generated with [Claude Code](https://claude.com/claude-code)
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index 305618e577fc..130a7d4eaf9d 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -386,7 +386,8 @@ void merge_taks_info(int cpu, struct task_info *old_tasks, int nr_old, struct ta
>  	int i;
>  	int j;
>  
> -	update_cpu_starving_vector(cpu, &notask);
> +	if (config_single_threaded)
> +		update_cpu_starving_vector(cpu, &notask);
>  
>  	for (i = 0; i < nr_old; i++) {
>  		old_task = &old_tasks[i];
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

