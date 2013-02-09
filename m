From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: rt-tests: make rpm fails if numactl-devel is missing
Date: Fri, 8 Feb 2013 18:26:44 -0800
Message-ID: <5115B3E4.7000707@am.sony.com>
References: <51158456.8000009@am.sony.com> <FDED51B5-DFB9-4C2D-BC7E-0F4594194697@thebigcorporation.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Clark Williams <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [216.32.181.184] ([216.32.181.184]:11906 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760493Ab3BIC2H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 21:28:07 -0500
In-Reply-To: <FDED51B5-DFB9-4C2D-BC7E-0F4594194697@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/08/13 16:49, Sven-Thorsten Dietrich wrote:
> 
> On Feb 8, 2013, at 3:03 PM, Frank Rowand <frank.rowand@am.sony.com> wrote:
> 
>> Hi all,
>>
>> I'm not sure what the best solution for this is.  Or if it is even
>> worth fixing.  So just reporting for the archives...
>>
>> rt-tests can be built without NUMA:
>>
>>   make NUMA=0
>>
>> But "make rpm" does not have a way to be successful without NUMA:
> 
> I ran into this in the past with OBS on Suse.
> 
> There was a tertiary issue, because some distros use i386
> and others use i586 or i686.
> 
> E.g.
> 
> [sven@www rt-tests]$ gcc -dumpmachine
> i586-suse-linux
> 
> diff --git a/Makefile b/Makefile
> index 3a82407..7bb022c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,7 +16,7 @@ srcdir        ?= $(prefix)/src
>  
>  machinetype = $(shell $(CC) -dumpmachine | \
>      sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
> -ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
> +ifneq ($(filter x86_64 i586 ia64 mips powerpc,$(machinetype)),)
>  NUMA   := 1
>  endif
> 
> So all in all, this feature probably only works on some, and maybe needs to be worked around more often than not.
> 
> Sven

OK, that prodded me enough to create an ugly patch, which will be following
in another email.

-Frank


