Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687B1DF99C
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063332; cv=none; b=MvZvzDqBp0LXciEv2ej1XG5WOJPENSGW1UeUJ3HE0LO62T2YHiFbi4UnpFWWLz6uuFwGsBkG567VlqWetNpSAXXUuBgRhplGOROMm33dOYkEHn6XkPWTXyqREVouDDCF0apj/RhdCz9rmpatKc8VSsFLIgjuBk1JnybJxHIIs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063332; c=relaxed/simple;
	bh=S/vXNH9V2olEmb17UcNXJMErFRH7EMfqj+3VVd0LW9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxnMb8FHAN85EL+DybmDgdBWjUq9IeeFaIoAvfl5h3lsESt5cmez2lna2KYgoZiO4WNKppm2YODPhyKGHyy5HWhJhcTEAWPaf6wOqL6kMFDUfcx4N9L6HilaodUmP3jZjTxg2O9UVB++/NVBFMXIlOchkr6fhXXxIiCODU0nBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYSXk4oO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYSXk4oO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761063330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfGEAWWwjgBZlzHkO6nvOHTZn6PUHPdnFM4FCe+7LfU=;
	b=RYSXk4oOrpfGhQhk5dDAGEWfEhFbPomFDVm1GPf6jr3XVSXG6PyRM3Ie56LsFmCYp3FSYl
	oKzLANB18uOynuTgwk6BkqScfpQxslgA3rzqcPTm/JcKJcpoOxPLOAMwKOMP07y7nIJqVL
	aXBCRg1gJjZNwzUpNwpi+oZQueHBJ5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-ccq2AC06NFilRQJO8UUiUg-1; Tue,
 21 Oct 2025 12:15:26 -0400
X-MC-Unique: ccq2AC06NFilRQJO8UUiUg-1
X-Mimecast-MFC-AGG-ID: ccq2AC06NFilRQJO8UUiUg_1761063324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09585180122A;
	Tue, 21 Oct 2025 16:15:24 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8ACFD1800577;
	Tue, 21 Oct 2025 16:15:20 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:15:18 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	debarbos@redhat.com, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 05/12] stalld.c: initialize cpu_info->idle_time to be -1
Message-ID: <kfpaoyfsa3rebj7cegqbnjyqpeo6gmqtgkkbx7z3u6vihnbfik@kuy5od7qdlhw>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-5-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-5-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 16, 2025 at 09:24:37PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> Initialize the idle_time value of a cpu_info structure to be -1 so
> that it will be presumed busy for the first time through the loop,
> which will force an initial check of the run queues.
> 
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index e8c927750ee0..6cd4bf68d04a 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -293,6 +293,15 @@ int get_cpu_busy_list(struct cpu_info *cpus, int nr_cpus, char *busy_cpu_list)
>  		 * log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
>  		 *	     cpu->id, cpu->idle_time, idle_time);
>  		 */
> +
> +		/* If this is the first check (idle_time was -1), assume busy to be safe */
> +		if (cpu->idle_time == -1) {
> +			cpu->idle_time = idle_time;
> +			busy_cpu_list[i] = 1;
> +			busy_count++;
> +			continue;
> +		}
> +
>  		/* If the idle time did not change, the CPU is busy. */
>  		if (cpu->idle_time == idle_time) {
>  			busy_cpu_list[i] = 1;
> @@ -1168,6 +1177,7 @@ int main(int argc, char **argv)
>  	for (i = 0; i < config_nr_cpus; i++) {
>  		cpus[i].buffer = allocate_memory(1, config_buffer_size);
>  		cpus[i].buffer_size = config_buffer_size;
> +		cpus[i].idle_time = -1;  /* Initialize to -1 so first check doesn't skip busy CPUs */
>  	}
>  
>  	if (config_log_syslog)
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

