Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA93D994
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821043; cv=none; b=L0tf1W3jAcMEHwt/MvU57WUHc2o0iTuW9VBKOVvjQ2Xy3RtlMsMY7f0NisNfddYilp+gTM6sjyvKtq9iZEu3WxkHoxccUjiRTT0y2r9ojnzZMDcnEC7kJfh3kmnOdHcxkQ1HMjIIMt+OFgCYD3LwaWrt7kEAtjhySw59J5UKHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821043; c=relaxed/simple;
	bh=kmVUHTun3BMqdYq/08lD4uNgQskWm2DrBZwxYl7Tb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmZPqMrCouIXhbGooh6QLMrCdVzBrN4MKjZafcX9AL1GPZ9QRbaOcwWk+SAkLoaIG4uiuQnCFNCc8yJXU5Pn/A3ytz4zi3rH4wCLIM55Hd3R7loRoNkZrKM8FRidyK/ZCDweIZGoWOrgVkfOob5cb5HYaUv+gQaLaq1Kd2B4zTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Odtz2qpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Odtz2qpO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762821040;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=XfaiLUGe4SkM++rqwzL5qBwSgF6zEz9QqWLaIenbZLw=;
	b=Odtz2qpOIyunKCOVZAkzN7dYdgyWOsYufmpuQKrUB7k88sBFSgzEK89jynEYwIH6eE7rTY
	W/sAfk3RVHSyFAHZoYKwTe1++juFIbLYVeNBpGfGznsTdPCehDy/ULv3c/sZfoLDXu7xXn
	fOqg6rMaqYrDNHjzvqEtEYs45Ihd9UA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-gJ2q3aXIOyatvmTTiY7CLg-1; Mon,
 10 Nov 2025 19:30:37 -0500
X-MC-Unique: gJ2q3aXIOyatvmTTiY7CLg-1
X-Mimecast-MFC-AGG-ID: gJ2q3aXIOyatvmTTiY7CLg_1762821036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 562011800650;
	Tue, 11 Nov 2025 00:30:36 +0000 (UTC)
Received: from localhost (unknown [10.22.80.141])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C3391800361;
	Tue, 11 Nov 2025 00:30:35 +0000 (UTC)
Date: Mon, 10 Nov 2025 19:30:34 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 4/6] Makefile: Remove redundant GCC version check
Message-ID: <5fjjcwk6wdmmppegnnoqybyz2ql667dowattintrggocbj5esm@skc6hcm3zeri>
Reply-To: debarbos@redhat.com
References: <20251110132241.43685-1-wander@redhat.com>
 <20251110132241.43685-5-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-5-wander@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 10, 2025 at 10:22:39AM -0300, Wander Lairson Costa wrote:
> The minimum GCC version check was introduced to handle the `-fcf-protection`
> flag, which was not available in older compiler versions. However, a more
> robust method that directly tests for compiler support for this flag has
> been implemented.
> 
> This commit removes the now-redundant GCC version check, simplifying the
> Makefile and relying on the more accurate feature detection.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  Makefile | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 619413f..ba67698 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,11 +14,6 @@ GCC_VER=$(shell gcc --version | grep ^gcc | cut -f 3 -d ' ' | cut -f 1 -d '.')
>  endif
>  $(info GCC_VER=$(GCC_VER))
>  
> -# Does the current GCC compiler have fcf-protection and c99+ as default?
> -MIN_GCC_VER := 8
> -IS_MINVER := $(intcmp $(GCC_VER), $(MIN_GCC_VER), false, true, true)
> -$(info IS_MINVER=$(IS_MINVER))
> -
>  USE_BPF := 1
>  MTUNE	:= -mtune=generic
>  M64	:= -m64
> -- 
> 2.51.1
> 

Acked-by: Derek Barbosa <debarbos@redhat.com>

-- 
Derek <debarbos@redhat.com>

