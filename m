Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BB2E5427
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797003; cv=none; b=GokR3608Etz/JJYZHOFTMzEM9jfWtfiYJ0hpfsG5DYEZTHcs0EER+RpjaIeAsOJl1pvODFIL5H5Kx+cW4mLFq1WWiVjyY9wFFLDTTIhkLKwWbnpjsNVo3n3wfa0RPU0C9a5k+m0YDbVeO9VEAEKPrMfwMMXEUQYad/2pbVtOeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797003; c=relaxed/simple;
	bh=k4HLkqG8Y9yZv6sZmyjmI0LCszWhLlRy+otmGauAzFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THpmInhXBscrDIT2F3NHvDe+sSP+utWuR+fuVCiRbzRjrvW3k8BHLT/RySUr7Tv9e5s1v77iGs77dUdUnL6xQJqrSCF0Cm2PHUKJ/LgKipYOq6++ExooskUP1N/WINMP3CiPvDvSLcL3AiOiD/OjBCT3RJgQY0/tzaZyCu+JiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0830C113D0;
	Mon, 10 Nov 2025 17:50:02 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:50:01 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 5/6] Makefile: Print BPF tool versions for debugging
Message-ID: <aRIlyT1alF54ZOtM@lysander>
References: <20251110132241.43685-1-wander@redhat.com>
 <20251110132241.43685-6-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-6-wander@redhat.com>

On Mon, Nov 10, 2025 at 10:22:40AM -0300, Wander Lairson Costa wrote:
> This commit adds informational messages to the Makefile to print the
> kernel version, clang version, and bpftool version. This will help in
> debugging BPF-related compilation issues by providing clear information
> about the build environment.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index ba67698..43eb9b8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -121,6 +121,10 @@ VMLINUX_BTF_PATHS	:= /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
>  VMLINUX_BTF_PATH	:= $(or $(VMLINUX_BTF),$(firstword                            \
>                                            $(wildcard $(VMLINUX_BTF_PATHS))))
>  
> +$(info KERNEL=$(KERNEL_REL))
> +$(info $(shell $(CLANG) --version | head -1))
> +$(info $(shell $(BPFTOOL) --version))
> +
>  ifeq ($(ARCH),x86_64)
>  CLANGARCH="-D__x86_64__"
>  endif
> -- 
> 2.51.1
> 
Looks good to me

Signed-off-by: Clark Williams <williams@redhat.com>

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
