From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 3/4] rt-tests: cyclictest avoid unneeded warning
Date: Wed, 02 May 2012 13:38:30 -0700
Message-ID: <4FA19B46.2070005@linux.intel.com>
References: <4FA09D6A.2050101@am.sony.com> <4FA09FAC.8030505@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57340 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407Ab2EBUjC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 16:39:02 -0400
In-Reply-To: <4FA09FAC.8030505@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 05/01/2012 07:45 PM, Frank Rowand wrote:
> Avoid annoying warning message when tracing is not requested and the debug
> file system is not available. 
> 
> The same test already protects against calling event_enable_all().
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

Cross-compile tested for ARM. Visually inspected, looks sane.

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

> ---
>  src/cyclictest/cyclictest.c |    5 	3 +	2 -	0 !
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: b/src/cyclictest/cyclictest.c
> ===================================================================
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1605,8 +1605,9 @@ int main(int argc, char **argv)
>  	if (trace_fd >= 0)
>  		close(trace_fd);
>  
> -	/* turn off all events */
> -	event_disable_all();
> +	if (enable_events)
> +		/* turn off all events */
> +		event_disable_all();
>  
>  	/* turn off the function tracer */
>  	fileprefix = procfileprefix;
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
