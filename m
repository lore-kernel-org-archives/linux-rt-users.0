Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984F15442A
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Nov 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046078; cv=none; b=dRgbvskR/XFbtW3q+Gpfqk02WxNHjrnb9jznRVTHIs9a89Dm34yN/WfasUcYDPKaC3gdcPsSJ6ojTA8f9ZGn3bSjbCtuUHGPTfBwpM7GZfXMKR+OT25lPxUI4GwMAofRNo7RuGmQ+3D7Fq8F0lOXTERkSPH7NoZ36qhwnufGe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046078; c=relaxed/simple;
	bh=Tvehxq0MvM/X2W5htwVRoyCHNd0E8dnvyVxITeOVhj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9D7d+dfS74zQdDG5zkpHkTug2xflDB4iZ2Ran//7MaN4CPz5Q64rPPnLz3rSAVQ2miGT5g4BLhhrZnW6Wm50HSMgzmn8bwADdI4yxsGZN+T9Vcjw6EhNYPzoX7GvKcwftXFuJQZ8Sy2CgRdgdE0AKRrHs3jCF0mlHZgII/FIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Di8qgKlJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Di8qgKlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732046074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fvcT2DdIBIg8APbMSfx9ipZm7VYUV57nikLeLVF58Jc=;
	b=Di8qgKlJ0vwptv2IUSOpBUUuJJZ7BVoevgosj6XfMWsSXoHpSgula6oesuqVMHUltrxLg6
	7MiRz7sqWuUd81J4lVdfmJm0uMcC9OoJ7XYRablKFAR4Hsk0uRAOQ8mCPKfuqjT85XbC6W
	0lSYOn1FxVc4ZP22hNb8SkRGZlvn/pk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-bcNZMxD1M0GeDkIgdqevcg-1; Tue,
 19 Nov 2024 14:54:32 -0500
X-MC-Unique: bcNZMxD1M0GeDkIgdqevcg-1
X-Mimecast-MFC-AGG-ID: bcNZMxD1M0GeDkIgdqevcg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D698E1954B23;
	Tue, 19 Nov 2024 19:54:30 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04E2530000DF;
	Tue, 19 Nov 2024 19:54:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3CCA84051562E; Tue, 19 Nov 2024 16:48:47 -0300 (-03)
Date: Tue, 19 Nov 2024 16:48:47 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: ende.tan@starfivetech.com
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com,
	leyfoon.tan@starfivetech.com
Subject: Re: [1/1] rt-tests: queuelat: Fix wraparound in __clock_gettime()
Message-ID: <Zzzrn7ceCeAUFfbc@tpad>
References: <20241111014911.11571-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111014911.11571-1-ende.tan@starfivetech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 11, 2024 at 09:49:11AM +0800, ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Include tv_sec in addition to tv_nsec in __clock_gettime(). If the value
> of variable 'a' wraps around, it may cause 'delta' to be negative, while
> 'delta' is defined with u64 type.
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/queuelat/queuelat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index c549cd8..c057389 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -292,7 +292,8 @@ static inline unsigned long long __clock_gettime(void)
>  	if (ret < 0)
>  		return 0;
>  
> -	return now.tv_nsec;
> +	// Combine seconds and nanoseconds into a single value in nanoseconds
> +	return (unsigned long long)now.tv_sec * 1000000000ULL + now.tv_nsec;
>  }
>  
>  #define gettick(val) do { (val) = __clock_gettime(); } while (0)
> -- 
> 2.34.1
> 
> 

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

