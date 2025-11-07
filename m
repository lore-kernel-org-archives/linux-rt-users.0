Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178C27E07E
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533692; cv=none; b=p/4P0sHagpSL2Dj2qOm+ZlV4epVqFCbrpq0KSkSgxQU6rPHGLConX9TXScHKFhYtZ4Na+Q2vJCta8iQxpEf1ZwWjiqbvdoItjZZcKwbRweFRy6HvQ3qycPVG4Mj6ffh64NQgRZYJu6mPyyYeCruKcrSYwoJdIfkXv+imafpLa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533692; c=relaxed/simple;
	bh=ecfR/Lwbgn+kYVBJDQYEAscl7aN0BFHOApqS8Qo/kso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLp1RlIzdaslxO4Y132xK1Nv+uYvf9YiIIACFq0dSnv5LMWXOwPJK/4UMOM84H/vjlFUaDe3ZtWR849XJo/Gfc4HRcCc66QoM6UFP/jI+XRy+OjPYj4iodPa+gQYNZeEmMFGgwdF0K4QQJ0c138vqW1iF2C56JsaxE2fEuPek78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNe9cRva; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNe9cRva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762533690;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=4sNS7Ho1mNE72b1qxCjq472cCJXWspbQhyfshbEHQqk=;
	b=XNe9cRvaK/rX3HYQX36q1/Fq/SrDghgTHtUn/2NW3xX15dPzTHw0kTG83Tw+4+qWVc47wp
	+3Ch+EP2mbagy68W39PH0wlNrVset0TZu9cL1nDRU7FFzsKH4EocD1H9HFml4cjIUffsGF
	KD630TSwJ+2ymKKTgLKm9Q9WlKOMl4c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-QAVI84bXMtmzwjjguQx8NQ-1; Fri,
 07 Nov 2025 11:41:27 -0500
X-MC-Unique: QAVI84bXMtmzwjjguQx8NQ-1
X-Mimecast-MFC-AGG-ID: QAVI84bXMtmzwjjguQx8NQ_1762533686
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D3D180045C;
	Fri,  7 Nov 2025 16:41:25 +0000 (UTC)
Received: from localhost (unknown [10.22.80.75])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A305F1800876;
	Fri,  7 Nov 2025 16:41:24 +0000 (UTC)
Date: Fri, 7 Nov 2025 11:41:23 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH 2/3] Makefile: Improve compiler flag detection for
 -fcf-protection
Message-ID: <7etm7f46u757xei6vvzij3lfadnegmtl5tgccnsgofph7n5w6g@myfx5xv7grft>
Reply-To: debarbos@redhat.com
References: <20251107161729.320087-1-wander@redhat.com>
 <20251107161729.320087-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107161729.320087-3-wander@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Nov 07, 2025 at 01:17:27PM -0300, Wander Lairson Costa wrote:
> The previous method of detecting support for -fcf-protection relied on
> a minimum GCC version check, which was not always accurate and could
> fail on different architectures or compiler toolchains.
> 
> This commit replaces the version check with a more robust method that
> directly tests if the compiler supports the -fcf-protection flag. This
> ensures better portability and avoids compilation errors on systems
> where the flag is not available.
> 
> This change mirrors the recently added detection logic for the
> -mno-omit-leaf-frame-pointer flag.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d605e60..bc82858 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -20,17 +20,14 @@ IS_MINVER := $(intcmp $(GCC_VER), $(MIN_GCC_VER), false, true, true)
>  $(info IS_MINVER=$(IS_MINVER))
>  
>  USE_BPF := 1
> -FCF_PROTECTION := -fcf-protection
>  MTUNE	:= -mtune=generic
>  M64	:= -m64
>  
>  ifeq ($(ARCH),aarch64)
> -FCF_PROTECTION := "-fcf-protection=none"
>  M64	:=
>  endif
>  ifeq ($(ARCH),i686)
>  USE_BPF := 0
> -FCF_PROTECTION := "-fcf-protection=branch"
>  endif
>  ifeq ($(ARCH),s390x)
>  MTUNE := -mtune=z13
> @@ -43,9 +40,12 @@ ifeq ($(ARCH),powerpc)
>  USE_BPF := 0
>  MTUNE := -mtune=powerpc
>  endif
> -ifeq ($(strip $(IS_MINVER)), false)
> -FCF_PROTECTION := 
> -endif
> +
> +# Test if compiler supports -fcf-protection
> +FCF_PROTECTION := $(shell echo 'int main(void){return 0;}' | \
> +		$(CC) -x c -fcf-protection - \
> +		-o /dev/null 2>/dev/null && \
> +		echo '-fcf-protection')
>  

If we're no longer guarding FCF_PROTECTION on IS_MINVER, I think we can just
remove that intcmp check all together.

Otherwise this LGTM.

>  
>  $(info USE_BPF=$(USE_BPF))
> -- 
> 2.51.1
> 
-- 
Derek <debarbos@redhat.com>

