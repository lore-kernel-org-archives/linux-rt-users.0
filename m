Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653272E5B36
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797120; cv=none; b=Q/6EwL9KtnEOvCZZNYf1n5zs8/sOaJF3zmg4J0UC90kr9kJuu3I3LIJv0yK4g8dV4ub29xBBFjSsPWJ++Cv8AmgGaX0vZrm3hez972ObmXgHcScqKHBnmQWe2w6JjMYaRXlYvrri4r8MNQfoUYZKVOmE+pe/z8kTyndV0ILqB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797120; c=relaxed/simple;
	bh=lxBSDCwzmMk2LyJT+TR9T4YaEWlQXGhMhoT82tyercI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHQPjSTVwwayodwq7SFEos5J2xxZvzEZalNqgyqWFFjXOeGDm8J98Dg5M/zhmsZLoW3zCAK8ZQJtXHpweijOa6R7/QsgdQ/xL8DjVXC4JMiVUj5W3EyMYj98iO7emCRE/96Qf0GwV0d/he5VcucXvKp8H5ju3VndyYaeVOLZCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6CC4CEF5;
	Mon, 10 Nov 2025 17:52:00 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:51:58 -0600
From: Clark Williams <williams@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [stalld v2 2/6] Makefile: Improve compiler flag detection for
 -fcf-protection
Message-ID: <aRImPhGtA7X_9yPg@lysander>
References: <20251110132241.43685-1-wander@redhat.com>
 <20251110132241.43685-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132241.43685-3-wander@redhat.com>

On Mon, Nov 10, 2025 at 10:22:37AM -0300, Wander Lairson Costa wrote:
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
>  Makefile | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d605e60..23e786d 100644
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
> @@ -43,23 +40,23 @@ ifeq ($(ARCH),powerpc)
>  USE_BPF := 0
>  MTUNE := -mtune=powerpc
>  endif
> -ifeq ($(strip $(IS_MINVER)), false)
> -FCF_PROTECTION := 
> -endif
> -
> -
> -$(info USE_BPF=$(USE_BPF))
> -$(info FCF_PROTECTION=$(FCF_PROTECTION))
> -$(info MTUNE=$(MTUNE))
>  
>  DEBUG	?=	0
>  
>  INSTALL	=	install
>  CC	:=	gcc
> +
> +# Test if compiler supports -fcf-protection
> +FCF_PROTECTION := $(shell echo 'int main(void){return 0;}' | \
> +		$(CC) -x c -fcf-protection - \
> +		-o /dev/null 2>/dev/null && \
> +		echo '-fcf-protection')
> +
>  FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
>  		-fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer \
>  		$(strip $(FCF_PROTECTION)) -fpie
>  
> +
>  # Test if compiler supports -mno-omit-leaf-frame-pointer
>  OMIT_LEAF_FP := $(shell echo 'int main(void){return 0;}' | \
>  		$(CC) -x c -mno-omit-leaf-frame-pointer - \
> @@ -74,6 +71,10 @@ DEFS	:=	-DUSE_BPF=$(USE_BPF) -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S
>  
>  CFLAGS	:=      -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS)
>  
> +$(info USE_BPF=$(USE_BPF))
> +$(info FCF_PROTECTION=$(FCF_PROTECTION))
> +$(info MTUNE=$(MTUNE))
> +
>  ifeq ($(DEBUG),0)
>  CFLAGS	+=	-g -O2
>  else
> -- 
> 2.51.1
> 
Signed-off-by: Clark Williams <williams@redhat.com>
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
