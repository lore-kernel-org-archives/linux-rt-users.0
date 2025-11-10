Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702482D8DD6
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797079; cv=none; b=bcbIa1Y32rnn7oe+/gwMNNPftC9zLfqhY+MeL/4jBy2zT4Rb0QBbXlrExsssjxMVzdqVwgOspdCuz/gRdAW8Txj4YvnU7V/PuuFH/RdC66GHNlFbRlbrOSbdnSbAznMGeKTmGhg7KSmRAReKJxlBendT3NEe6qKBWiuUr5PzWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797079; c=relaxed/simple;
	bh=bYyX4EbtLtUF0tdc7VMxZsP2g+/7xrda3cBpTnNrc7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFDd59zcMlLWM0DKGx6xe4WmsY0IAmGULbPGl+OneaYmn3Xu0SHahAsh5RC6BNmwYwKpFq+uTV2HiXmsn/pNd7/TVm5LYm0eUHTKYA6bJQiML7BTSPzmBNsV4EM3j9DBkHLaZJpFqSKj+chKxl/8Lpxh2pAd0SvEY7+ntwcehSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A021C113D0;
	Mon, 10 Nov 2025 17:51:18 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:51:17 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 1/6] Makefile: Conditionally add
 -mno-omit-leaf-frame-pointer
Message-ID: <aRImFar71AybVbAm@lysander>
References: <20251110132241.43685-1-wander@redhat.com>
 <20251110132241.43685-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-2-wander@redhat.com>

On Mon, Nov 10, 2025 at 10:22:36AM -0300, Wander Lairson Costa wrote:
> The -mno-omit-leaf-frame-pointer option is not available on all
> architectures (e.g., s390x) or with older compiler versions. To avoid
> compilation errors on such systems, this change adds a check to ensure
> the option is only used when the compiler supports it.
> 
> This approach is similar to the existing check for -fcf-protection.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c19e0bd..d605e60 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -60,7 +60,13 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
>  		-fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer \
>  		$(strip $(FCF_PROTECTION)) -fpie
>  
> -MOPTS   :=  	$(strip $(MTUNE)) $(strip $(M64)) -mno-omit-leaf-frame-pointer
> +# Test if compiler supports -mno-omit-leaf-frame-pointer
> +OMIT_LEAF_FP := $(shell echo 'int main(void){return 0;}' | \
> +		$(CC) -x c -mno-omit-leaf-frame-pointer - \
> +		-o /dev/null 2>/dev/null && \
> +		echo '-mno-omit-leaf-frame-pointer')
> +
> +MOPTS   :=  	$(strip $(MTUNE)) $(strip $(M64)) $(strip $(OMIT_LEAF_FP))
>  
>  WOPTS	:= 	-Wall -Werror=format-security
>  
> -- 
> 2.51.1
> 
Signed-off-by: Clark Williams <williams@redhat.com>
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
