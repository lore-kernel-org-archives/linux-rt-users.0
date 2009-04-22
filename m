From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: external gpl kernel module build problem on 2.6.26.8-rt16
Date: Wed, 22 Apr 2009 15:21:00 -0700
Message-ID: <49EF984C.50403@am.sony.com>
References: <49EF8449.2030000@compro.net>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: markh@compro.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa4ehsobe002.messaging.microsoft.com ([216.32.181.12]:50002
	"EHLO WA4EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756146AbZDVWWD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 18:22:03 -0400
In-Reply-To: <49EF8449.2030000@compro.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mark Hounschell wrote:
> I get the following while trying to build this driver. What does it mean.
> 
>  Building modules, stage 2.
>  MODPOST 1 modules
> WARNING: "__bad_func_type" [/local/work/markh/pci5565-linux/driver/rfm2g.ko]
> undefined!
> 
> Then obviously the module doesn't load for the same reason.
> 
> When I grep the kernel for bad_func_type all I see is
> 
> include/linux/rt_lock.h:192:extern int __bad_func_type(void);
> include/linux/pickop.h:8:extern int __bad_func_type(void);
> include/linux/pickop.h:16:      else __bad_func_type();
>                 \
> include/linux/pickop.h:27:      else __ret = __bad_func_type();
> 
> Any help or hints would be appreciated
> 
> Thanks in advance
> Mark

#define PICK_FUNCTION(type1, type2, func1, func2, arg0, ...)            \
do {                                                                    \
        if (PICK_TYPE_EQUAL((arg0), type1))                             \
                func1((type1)(arg0), ##__VA_ARGS__);                    \
        else if (PICK_TYPE_EQUAL((arg0), type2))                        \
                func2((type2)(arg0), ##__VA_ARGS__);                    \
        else __bad_func_type();                                         \
} while (0)

And PICK_FUNCTION_RET() uses the same technique.

Something that invokes PICK_FUNCTION() or PICK_FUNCTION_RET() is passing
in an arg0 that is not type1 and is not type2.

One easy way to figure out what is invoking PICK_FUNCTION()/PICK_FUNCTION_RET()
is to look at the output from the cpp of your driver.  The method I usually
use is to add the flags "-C -E" to my compile command (and remove "-c").
Then search the cpp output for __bad_func_type.

-Frank Rowand
Sony Corporation of America


