Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EB336ECD
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062596; cv=none; b=Gc3c9jO1sP+z5Tp3QA6rRaWgV1hKhLnM0QyV4l2xjgxQ7vBDghO9VNPye/a2zP2UzZ32sZC6SE6IipjdlQ5KwxGCR3ZXfPynEViWcXcHjHxCAXw8u9nIDqkYx/6OIhPFMe9Bl19yTGzDtyBg4Ebkt0AuDGApSMZHEtPFsTTfPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062596; c=relaxed/simple;
	bh=DUiHd7WOVgjrQHcLG2v4uduReZaUC++jeAPsU/3uabU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j79mipAsZu9NY6ug+k972IrbVsQ0Z+MX+Q1nVKnixLLn/M2B8tKc/muFJtPO+Jhqyyno3+CXX7W+CijQPLQDkpLEJwnrDo+BeF0PIpRQgMelTV7G3bJS/2TDUfNVyOVLxXpWSWCI0j8tZmlS+EE9FnT3PEbwqYIvtBsqBOM93wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzfNaQW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzfNaQW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yxIpov8q1HQM1HQXX7X1TYx+Q25FjidiuS5xFKVp8F8=;
	b=HzfNaQW2DsISxU40myG6b5FXr8BvrRsZmBBVQDbSF0hf07wPKe7vjKTl+m0Tp7jkveetfl
	0BUTW3GCe88U3OgD01uo9nZeEIywI02fRP7TsWcHxLofckY77xOfJ7H33SdITJU5xotT3+
	IhNO0hvyPAebbxtEOei0pRVsNGdAj8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-Y_k5VKMXPAaI1pZCfNqPTQ-1; Tue,
 21 Oct 2025 12:03:10 -0400
X-MC-Unique: Y_k5VKMXPAaI1pZCfNqPTQ-1
X-Mimecast-MFC-AGG-ID: Y_k5VKMXPAaI1pZCfNqPTQ_1761062589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 946271956048;
	Tue, 21 Oct 2025 16:03:08 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 19FA119560A2;
	Tue, 21 Oct 2025 16:03:04 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:03:03 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	debarbos@redhat.com, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 04/12] stalld.c: remove noisy idle report and added
 report to should_skip_idle_cpus()
Message-ID: <xhlnvoxitqi4bw5bxlw3yiae5ac3nje2xu5x7mw4qzqag2ghv3@7qdwlfxutzho>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-4-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-4-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Oct 16, 2025 at 09:24:36PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> comment out the log_verbose() call in get_cpu_busy_list(), since
> it's not helpful for production and chews up a lot of screen real-
> estate when running tests. Added a report in should_skip_idle_cpus()
> which reports that there were busy cpus and that a run-queue parse
> will be done.
> 
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index 4c00158cf239..e8c927750ee0 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -289,9 +289,10 @@ int get_cpu_busy_list(struct cpu_info *cpus, int nr_cpus, char *busy_cpu_list)
>  			continue;
>  		}
>  
> -		log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
> -			     cpu->id, cpu->idle_time, idle_time);
> -
> +		/*
> +		 * log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
> +		 *	     cpu->id, cpu->idle_time, idle_time);
> +		 */

Any particular reason of this code is commented out instead of deleted?

>  		/* If the idle time did not change, the CPU is busy. */
>  		if (cpu->idle_time == idle_time) {
>  			busy_cpu_list[i] = 1;
> @@ -795,7 +796,7 @@ static int should_skip_idle_cpus(struct cpu_info *cpus, int nr_cpus, char *busy_
>  		log_verbose("all CPUs had idle time, skipping parse\n");
>  		return 1;
>  	}
> -
> +	log_verbose("some cpus ran, so run-queues should be parsed\n");
>  	return 0;
>  }
>  
> -- 
> 2.51.0
> 

