From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 3/4] Android: Expand match for android in ostype
Date: Thu, 22 Oct 2015 10:43:45 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221042270.5687@riemann>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com> <1445454011-18839-4-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <henrik@austad.us>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36355 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbbJVIns (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 04:43:48 -0400
Received: by wicfx6 with SMTP id fx6so125180382wic.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 01:43:46 -0700 (PDT)
In-Reply-To: <1445454011-18839-4-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 21 Oct 2015, Henrik Austad wrote:

> From: Henrik Austad <henrik@austad.us>
> 
> Some buildsystems use androidabe, so an exact match will break in those
> circumstances.
> 
> Cc: John Kacur <jkacur@redhat.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/arch/android/Makefile | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/src/arch/android/Makefile b/src/arch/android/Makefile
> index e25f67203e5a..2c4b4b7ef9ae 100644
> --- a/src/arch/android/Makefile
> +++ b/src/arch/android/Makefile
> @@ -1,10 +1,14 @@
>  
> -# Bionic (android) does not have:
> +# Android use Bionic for libc, and this does not have
>  # - pthread barriers
>  # - pthread_[gs]etaffinity
>  #
> -# Typically see something like "aarch64-linux-android"
> -ifeq (android,$(ostype))
> +# This is all handled by bionic.h based on flags we set here.
> +
> +# Typically see something like "aarch64-linux-android". However, in some
> +# buildsystems, it will be a variation of -androidabe.
> +ost=$(findstring android, $(ostype))
> +ifeq (android,$(ost))
>  	USE_BIONIC := 1
>  	CFLAGS += -DPTHREAD_BIONIC
>  
> @@ -13,9 +17,7 @@ ifeq (android,$(ostype))
>  	LIBS := $(filter-out -lrt,$(LIBS))
>  	LIBS := $(filter-out -lpthread,$(LIBS))
>  
> -# BIONIC does not support PI, barriers and has different files in
> -# include/. This means that currently, only these binaries will compile
> -# and link properly:
> +# Currently, only these binaries will compile and link properly for android
>  # - cyclictest
>  # - hackbench
>  	sources := cyclictest.c hackbench.c
> -- 
> 1.9.1
> 
> --

This change looks fine, of course, just be forewarned that I'll be 
depending on you to test anything that touches android only.

Thanks

Signed-off-by: John Kacur <jkacur@redhat.com>
