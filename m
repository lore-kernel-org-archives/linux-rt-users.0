From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 1/4] rt-tests: Allow for user-specified PYLIB
Date: Wed, 2 Sep 2015 14:53:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509021453030.19826@riemann>
References: <cover.1440720422.git.joshc@ni.com> <94d6daa3898ca4a5e8c210247638a2c3b80f1a51.1440720422.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34674 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbbIBMx6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 08:53:58 -0400
Received: by wicfx3 with SMTP id fx3so16652619wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Sep 2015 05:53:57 -0700 (PDT)
In-Reply-To: <94d6daa3898ca4a5e8c210247638a2c3b80f1a51.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 27 Aug 2015, Josh Cartwright wrote:

> From: Darren Hart <dvhart@linux.intel.com>
> 
> Allow users (build systems) to specify PYLIB. This allows for a
> cross-build-system to specify the target PYLIB rather than the host
> PYLIB.
> 
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> CC: Clark Williams <williams@redhat.com>
> CC: John Kacur <jkacur@redhat.com>
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index a48e759..1ec7f6a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -34,7 +34,7 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
>  endif
>  endif
>  
> -PYLIB  := $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
> +PYLIB  ?= $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
>  
>  ifndef DEBUG
>  	CFLAGS	+= -O2
> -- 
> 2.5.0
> 

Nice. I see Clark has already grabbed this one.
Signed-off-by: John Kacur <jkacur@redhat.com>
