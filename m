From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Subject: [Trace how to] Kernel Bug when entering something after login
Date: Thu, 26 Jul 2007 18:04:21 +0530
Message-ID: <f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
References: <200707251900.47704.juergen127@kreuzholzen.de>
	 <1185390398.3227.8.camel@chaos>
	 <200707261000.25465.juergen127@kreuzholzen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
To: "Juergen Beisert" <juergen127@kreuzholzen.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:45004 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbXGZMeW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 08:34:22 -0400
Received: by py-out-1112.google.com with SMTP id d32so955620pye
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jul 2007 05:34:21 -0700 (PDT)
In-Reply-To: <200707261000.25465.juergen127@kreuzholzen.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Everyone,

On 7/26/07, Juergen Beisert <juergen127@kreuzholzen.de> wrote:
> On Wednesday 25 July 2007 21:06, Thomas Gleixner wrote:
> > Solution below
>
> Seems to work now. Thanks.
>
> Juergen
> -

First of all very sorry to cross post.

I discovered the same problem on our MPC5200 and it after patching, it
now works. But I could somehow not get the call trace and hence could
not report the bug.

I compiled the kernel with "CONFIG_FUNCTION_TRACE" and then I get
undefined references on "early_printk". Is there something I am doing
wrong in the kernel config or was there an additional patch to enable
this support for MPC5200 ?

I see more bugs when I run "stress" but I cant solve them or even
report them, because I cant see the trace information.

thanks in advance
regards
/prady

-- 
htp://prady.livejournal.com
