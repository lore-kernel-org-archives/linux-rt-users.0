From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH v2] rt-tests: printf format compile warning
Date: Thu, 03 May 2012 14:13:56 -0700
Message-ID: <4FA2F514.5070104@linux.intel.com>
References: <4FA2E120.1020909@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	williams@redhat.com, jkacur@redhat.com
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3917 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004Ab2ECVO0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 17:14:26 -0400
In-Reply-To: <4FA2E120.1020909@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 05/03/2012 12:48 PM, Frank Rowand wrote:
> 
> V2: use type casting instead of ugly constant in format string
> 
> 
> Fix printf format string to fix compile warning for ARM 32 bit target.
> 

Oh much better. :-)

> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  src/cyclictest/cyclictest.c |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/src/cyclictest/cyclictest.c
> ===================================================================
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1575,7 +1575,7 @@ int main(int argc, char **argv)
>  		print_tids(parameters, num_threads);
>  		if (break_thread_id) {
>  			printf("# Break thread: %d\n", break_thread_id);
> -			printf("# Break value: %lu\n", break_thread_value);
> +			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
>  		}
>  	}
>  	
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
