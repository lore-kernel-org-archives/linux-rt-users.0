From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 2/4] Android: rename arch from bionic to android
Date: Thu, 22 Oct 2015 10:36:27 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221035570.5687@riemann>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com> <1445454011-18839-3-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <henrik@austad.us>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36951 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbbJVIga (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 04:36:30 -0400
Received: by wicfv8 with SMTP id fv8so109172380wic.0
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 01:36:29 -0700 (PDT)
In-Reply-To: <1445454011-18839-3-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 21 Oct 2015, Henrik Austad wrote:

> From: Henrik Austad <henrik@austad.us>
> 
> Bionic is the libc implementation used in Android and should not be
> confused with the architecture.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Makefile                  |  3 +--
>  src/arch/android/Makefile | 22 ++++++++++++++++++++++
>  src/arch/bionic/Makefile  | 22 ----------------------
>  3 files changed, 23 insertions(+), 24 deletions(-)
>  create mode 100644 src/arch/android/Makefile
>  delete mode 100644 src/arch/bionic/Makefile
> 
> diff --git a/Makefile b/Makefile
> index 703333fe1b42..86a5c4b211a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,8 +69,7 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
>  endif
>  endif
>  
> -# Include any arch specific makefiles here.
> -include src/arch/bionic/Makefile
> +include src/arch/android/Makefile
>  
>  VPATH	= src/cyclictest:
>  VPATH	+= src/signaltest:
> diff --git a/src/arch/android/Makefile b/src/arch/android/Makefile
> new file mode 100644
> index 000000000000..e25f67203e5a
> --- /dev/null
> +++ b/src/arch/android/Makefile
> @@ -0,0 +1,22 @@
> +
> +# Bionic (android) does not have:
> +# - pthread barriers
> +# - pthread_[gs]etaffinity
> +#
> +# Typically see something like "aarch64-linux-android"
> +ifeq (android,$(ostype))
> +	USE_BIONIC := 1
> +	CFLAGS += -DPTHREAD_BIONIC
> +
> +	LDFLAGS += -pie
> +# -lrt and -lpthread is in standard bionic library, no standalone library
> +	LIBS := $(filter-out -lrt,$(LIBS))
> +	LIBS := $(filter-out -lpthread,$(LIBS))
> +
> +# BIONIC does not support PI, barriers and has different files in
> +# include/. This means that currently, only these binaries will compile
> +# and link properly:
> +# - cyclictest
> +# - hackbench
> +	sources := cyclictest.c hackbench.c
> +endif
> diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
> deleted file mode 100644
> index e25f67203e5a..000000000000
> --- a/src/arch/bionic/Makefile
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -
> -# Bionic (android) does not have:
> -# - pthread barriers
> -# - pthread_[gs]etaffinity
> -#
> -# Typically see something like "aarch64-linux-android"
> -ifeq (android,$(ostype))
> -	USE_BIONIC := 1
> -	CFLAGS += -DPTHREAD_BIONIC
> -
> -	LDFLAGS += -pie
> -# -lrt and -lpthread is in standard bionic library, no standalone library
> -	LIBS := $(filter-out -lrt,$(LIBS))
> -	LIBS := $(filter-out -lpthread,$(LIBS))
> -
> -# BIONIC does not support PI, barriers and has different files in
> -# include/. This means that currently, only these binaries will compile
> -# and link properly:
> -# - cyclictest
> -# - hackbench
> -	sources := cyclictest.c hackbench.c
> -endif
> -- 
> 1.9.1
> 
> --

Thanks

Signed-off-by: John Kacur <jkacur@redhat.com>
