From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] rt-tests: Makefile: Assume numa_parse_cpustring_all
 available
Date: Thu, 21 Apr 2016 12:08:54 -0400
Message-ID: <20160421120854.490ce681@redhat.com>
References: <alpine.LFD.2.20.1604211736070.11619@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcDUQJC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Apr 2016 12:09:02 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA681C049D52
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Apr 2016 16:08:56 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1604211736070.11619@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Apr 2016 17:38:43 +0200 (CEST)
John Kacur <jkacur@redhat.com> wrote:

> From 5e5a1cb500a26b63aff8a19a2669e224c5d6e87a Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Thu, 21 Apr 2016 17:29:51 +0200
> Subject: [PATCH] rt-tests: Makefile: Assume numa_parse_cpustring_all available
> 
> NUMA users should have long ago stepped up to libs that have
> numa_parse_cpustring_all(). Make this the default so that we can include
> isolated cpus in the affinity string.
> 
> If there are any NUMA users or distros left that have old libraries that
> don't have numa_parse_cpu_string_all(), and only numa_parse_cpu_string()
> they can compile like this
> 
> make HAVE_PARSE_CPUSTRING_ALL=0
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-and-Tested-by: Luiz Capitulino <lcapitulino@redhat.com>

> ---
>  Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 280fd3bec979..ff1d1b0554a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -57,16 +57,17 @@ ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
>  NUMA 	:= 1
>  endif
>  
> -# The default is to assume that you only have numa_parse_cpustring
> -# If you are sure you have a version of libnuma with numa_parse_cpustring_all
> +# The default is to assume that you have numa_parse_cpustring_all
> +# If you have an older version of libnuma that only has numa_parse_cpustring
>  # then compile with
> -# make HAVE_PARSE_CPUSTRING_ALL=1
> +# make HAVE_PARSE_CPUSTRING_ALL=0
> +HAVE_PARSE_CPUSTRING_ALL?=1
>  ifeq ($(NUMA),1)
>  	CFLAGS += -DNUMA
>  	NUMA_LIBS = -lnuma
> -ifdef HAVE_PARSE_CPUSTRING_ALL
> -	CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
> -endif
> +	ifeq ($(HAVE_PARSE_CPUSTRING_ALL),1)
> +		CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
> +	endif
>  endif
>  
>  include src/arch/android/Makefile

