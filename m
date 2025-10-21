Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2D1F584C
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064060; cv=none; b=accbl9rBpTH8ztsYni8PzYSpQnydl8DtX/Y0RGXrinvJjs8vWHJ9u8PX9DOu0XHzZiCYegPrKOvt5gedDN/4FvMzKSab46wGP77I0E2GO0Yfw6ct3lzB7Nd4g75oEGPERNX/Rnf2w/go6JJebnm+IKvB6AqrmKi9SyX2OKCjmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064060; c=relaxed/simple;
	bh=bz9LmyHuXzCxAaCNcSxn7N8X0LTJ1yp/mD5iFQ0YRlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut8KwIA0pd7Y4kYbc20xtjn3ZBBF69eCofvj8zY7GoL7HVwR4/Ye7eMO8SlGmMerUpLRmkEuY9jdt4We4BU6vZV/ySP1CSWjEFKuGsLnSZCAfHeKnZYwuwZkW9wka6v7St82ny8NvPuoE+SFw8sFvT61udt7k0PNnmzlQhgorB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjNicEqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjNicEqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761064057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tlCUriKCfY2uY6YWDYqkAe5/DUGRpvq7Ae65qFPf1ho=;
	b=IjNicEqqrd1rdDDpLC7f2aan+H7n2J126ZSfd/ega7nFC1yLxrDYcqIOeBVGCqR3qe3n2R
	+Hw8NDjAhDvIRHB+OcuiLi/ccHzOO4kax00LJz52KmHJNVdlGfEuCYmDdEpTJ/Cth/g7jT
	2mT827OV6DkRvk35dU73M9U5c0l/wnQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-lFdTF0cPPYqTaSF932b54Q-1; Tue,
 21 Oct 2025 12:27:34 -0400
X-MC-Unique: lFdTF0cPPYqTaSF932b54Q-1
X-Mimecast-MFC-AGG-ID: lFdTF0cPPYqTaSF932b54Q_1761064053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA93219560AD;
	Tue, 21 Oct 2025 16:27:32 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9486019560A2;
	Tue, 21 Oct 2025 16:27:28 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:27:26 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 07/12] stalld.c: Add starvation logging in
 single-threaded log-only mode
Message-ID: <if6nj64pqe6mysbhrkpruf7c3uqe2fbonfepy74wligxp4cveu@gugej5ue2b76>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-7-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-7-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Oct 16, 2025 at 09:24:39PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> In single-threaded mode with -l/--log_only flag, stalld was not logging
> the "starved" message when tasks reached the starvation threshold. This
> was because the config_log_only check occurred before any logging, and
> the "starved" message (present in check_starving_tasks() for per-CPU
> threading modes) was missing from boost_cpu_starving_vector().
> 
> This caused test_log_only.sh to fail when looking for the "starved"
> message in the log output.
> 
> Changes to boost_cpu_starving_vector():
> - Move config_log_only check after starvation detection
> - Add log_msg() call to output "starved" message when threshold reached
> - Reset timestamp (cpu->since) in log-only mode to prevent continuous
>   logging of the same starvation event
> - Change threshold comparison from <= to < for consistency with
>   check_starving_tasks()
> 
> This ensures consistent logging behavior between single-threaded mode
> and per-CPU threading modes when using log-only mode.
> 
> ???? Generated with [Claude Code](https://claude.com/claude-code)
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index 6adc3e9a8cea..ebca23105ce9 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -924,12 +924,22 @@ int boost_cpu_starving_vector(struct cpu_starving_task_info *vector, int nr_cpus
>  			log_verbose("\t cpu %d: pid: %d starving for %llu\n",
>  				    i, cpu->pid, (now - cpu->since));
>  
> -		if (config_log_only)
> +		/* Skip if no task or not starving long enough */
> +		if (cpu->pid == 0 || (now - cpu->since) < config_starving_threshold)
>  			continue;
>  
> -		/* Skip if no task or not starving long enough */
> -		if (cpu->pid == 0 || (now - cpu->since) <= config_starving_threshold)
> +		/* Log when task has reached starvation threshold */
> +		if ((now - cpu->since) >= config_starving_threshold) {

Is this "if" necessary? It wouldn't reach this point if the condition is
false, would it?

> +			log_msg("%s-%d starved on CPU %d for %d seconds\n",
> +				cpu->task.comm, cpu->pid, i,
> +				(now - cpu->since));
> +		}
> +
> +		if (config_log_only) {
> +			/* Reset timestamp to avoid continuous logging */
> +			cpu->since = now;
>  			continue;
> +		}
>  
>  		/* Skip if task is on denylist */
>  		if (config_ignore && !check_task_ignore(&cpu->task))
> -- 
> 2.51.0
> 

