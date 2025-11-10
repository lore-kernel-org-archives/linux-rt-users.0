Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AD284884
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797176; cv=none; b=PG+KhNigGezWwe/IZORnUIJsEgXGqQww6LyppaUEujnLFl3RjHwMz+cRoxS5ON+Z8gXDJlEcphs5fLk05BT7qT0fJSFxJByLUog2AlqENcq/mZM5qCtyLjK9Bwujm+x+OUHgRL7ggXo3ZCl42LRI+/lxab/5Enn3Ooj5x0sErnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797176; c=relaxed/simple;
	bh=lByOttAssvtPdaMPLiUuhHkykO7gwXPLIdZBTk11Pls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5X8Gvs0TzPxcNUV4ggRed/S0JI5S4vnoHdDz+0cFPNNPpToXOjMUre1kfi0rzBMAQEfnynjwri+i0reC/sXmEul40xWrCysxZR4NEt2EG9BpGy9No9oxlotsOCQLklcGXfeY+0/uscxXYiVcQxQvBt0YyE7VNKstMRwgY2oLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACCC16AAE;
	Mon, 10 Nov 2025 17:52:55 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:52:54 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 4/6] Makefile: Remove redundant GCC version check
Message-ID: <aRImdsKA8nFMxh5g@lysander>
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
Signed-off-by: Clark Williams <williams@redhat.com>
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
