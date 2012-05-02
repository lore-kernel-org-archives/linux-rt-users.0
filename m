From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH RFC] rt-tests: Makefile get machinetype from compiler
 instead of uname
Date: Wed, 02 May 2012 13:30:27 -0700
Message-ID: <4FA19963.3030104@linux.intel.com>
References: <4FA09D25.7090808@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	williams@redhat.com, jkacur@redhat.com
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7022 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407Ab2EBUbD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 16:31:03 -0400
In-Reply-To: <4FA09D25.7090808@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/01/2012 07:34 PM, Frank Rowand wrote:
> 
> Fix the machinetype check for cross-compiling.
> 
> This has been tested on an x86_64  Fedora host for an x86_64 target and
> an ARM target.  Additional testing would be greatly appreciated.


Built in Yocto using an ARM cross compiler and ran cyclictest in qemuarm
with the resulting image. Appears sane.

What problem manifested before?

> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

Tested-by: Darren Hart <dvhart@linux.intel.com>

> ---
>  Makefile |    4 	2 +	2 -	0 !
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/Makefile
> ===================================================================
> --- a/Makefile
> +++ b/Makefile
> @@ -14,8 +14,8 @@ bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  srcdir	?= $(prefix)/src
>  
> -machinetype = $(shell uname -m | \
> -    sed -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
> +machinetype = $(shell $(CC) -dumpmachine | \
> +    sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
>  ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
>  NUMA 	:= 1
>  endif
> 

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
