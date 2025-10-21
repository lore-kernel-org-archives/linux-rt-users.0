Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861334C128
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068178; cv=none; b=tvl3+CS4xRnvdQaDe/kVxfNiRb3Ia0HdW9AURB4Xb2wNpupSElJ37peYgCMIhhn48q48WqWiBXhJwj1l4eokbxfO1y3ZTOl/VO/QO/Q8XPfDyVzwHfInT0DwaC4KhcQEkRG/p27KpzgICo95xA3T/R3hC+cjS7/wSLfjF33oaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068178; c=relaxed/simple;
	bh=03xtXB8l03HIwKaT8FMb86YHdeDfIOPG0DVr+Qq5Ru0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYMMgdQNgsCu311/9dL84e1MJQ2pbhK7PUp9Mb1BkVBq93mfFYSV0/S/c2VD2RDWVDyAVNi1Td5nZ/EC1uczZUkZfVv4rKmBC+Q/RJghb9E/6IFQRLO9tSpYcstdiKQXfCGtkWaURkJEKgK8sRC/qq7IqgkqNNi4VLVeMFmUMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/g0fo8x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/g0fo8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761068176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8b3quP2Kqo9deFM3qkp6mFLJiPfTZr49/DBK2yWbrvA=;
	b=S/g0fo8xoeLBkKRoCM3aA4Vc7H53MT5xu44FTiO3yuY+5YakG7hTnLoesbTfg9hf99UdCR
	CcrlaWthsghqX0KV39dC8gx9vGbza5uIEh4YD/9mweBpXjB4dt0wEW7C2pRF4+W0jm6+jP
	1RGUiyfsUkq4JYVGRarLBM2Pc4plZvw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-ESJ-Ol09NzmMHntGkislCA-1; Tue,
 21 Oct 2025 13:36:11 -0400
X-MC-Unique: ESJ-Ol09NzmMHntGkislCA-1
X-Mimecast-MFC-AGG-ID: ESJ-Ol09NzmMHntGkislCA_1761068170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70DB71956053;
	Tue, 21 Oct 2025 17:36:10 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 35DD11954102;
	Tue, 21 Oct 2025 17:36:05 +0000 (UTC)
Date: Tue, 21 Oct 2025 14:36:04 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 09/12] stalld: Add defensive checks in print_boosted_info
Message-ID: <37ixtcwiujwhwbqs3woddopbht6dg2crsrd6cacwp63uoers6i@cr3ajqpumvh7>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-9-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-9-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 16, 2025 at 09:24:41PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> This adds validation and bounds checking in print_boosted_info() to
> prevent segmentation faults when boosting tasks in FIFO mode.
> 
> Changes:
> - Add NULL check for 'type' parameter
> - Handle fill_process_comm() failures gracefully with fallback
> - Validate cpu->id is within valid range before dereferencing
> - Provide informative error messages for invalid states
> 
> Issue: Test results show stalld crashes with SIGSEGV when using -F
> (force FIFO) flag in aggressive mode (-A). The crash occurs during
> or immediately after the first boost attempt.
> 
> This is a partial fix that adds defensive programming. Further
> investigation needed to identify the root cause of the crashes
> in FIFO boosting mode.
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index ebca23105ce9..466b6db15668 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -435,10 +435,21 @@ void print_boosted_info(int tgid, int pid, struct cpu_info *cpu, char *type)
>  {
>  	char comm[COMM_SIZE];
>  
> -	fill_process_comm(tgid, pid, comm, COMM_SIZE);
> +	/* Validate inputs to prevent crashes */
> +	if (!type) {
> +		warn("print_boosted_info called with NULL type\n");
> +		return;
> +	}

If !type must not happen with correct program logic, I would let it
crash. If we are screwing things up, it is better to have a core dump
than a buggy process running.

> +
> +	if (fill_process_comm(tgid, pid, comm, COMM_SIZE) != 0) {
> +		/* If we can't get the comm, use a placeholder */
> +		snprintf(comm, COMM_SIZE, "<unknown>");
> +	}
>  
> -	if (cpu)
> +	if (cpu && cpu->id >= 0 && cpu->id < config_nr_cpus)
>  		log_msg("boosted pid %d (%s) (cpu %d) using %s\n", pid, comm, cpu->id, type);
> +	else if (cpu)
> +		log_msg("boosted pid %d (%s) (cpu <invalid>) using %s\n", pid, comm, type);
>  	else
>  		log_msg("boosted pid %d (%s) using %s\n", pid, comm, type);
>  }

The same comment applies here.

> -- 
> 2.51.0
> 

