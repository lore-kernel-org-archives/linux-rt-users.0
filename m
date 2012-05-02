From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 1/4] rt-tests: printf format compile warning
Date: Wed, 02 May 2012 13:36:46 -0700
Message-ID: <4FA19ADE.8050402@linux.intel.com>
References: <4FA09D6A.2050101@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	williams@redhat.com, jkacur@redhat.com
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29802 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688Ab2EBUhS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 16:37:18 -0400
In-Reply-To: <4FA09D6A.2050101@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 05/01/2012 07:35 PM, Frank Rowand wrote:
> 
> Fix printf format string to allow for 32 bit and 64 bit word size.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

Tested cross-compilation for ARM, no warnings for this section.

Tested-by: Darren Hart <dvhart@linux.intel.com>

> ---
>  src/cyclictest/cyclictest.c |    3 	2 +	1 -	0 !
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: b/src/cyclictest/cyclictest.c
> ===================================================================
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -24,6 +24,7 @@
>  #include <time.h>
>  #include <errno.h>
>  #include <limits.h>
> +#include <inttypes.h>
>  #include <linux/unistd.h>
>  
>  #include <sys/prctl.h>
> @@ -1575,7 +1576,7 @@ int main(int argc, char **argv)
>  		print_tids(parameters, num_threads);
>  		if (break_thread_id) {
>  			printf("# Break thread: %d\n", break_thread_id);
> -			printf("# Break value: %lu\n", break_thread_value);
> +			printf("# Break value: %" PRIu64 "\n", break_thread_value);
>  		}
>  	}
>  	
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
