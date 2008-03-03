From: "Bosko Radivojevic" <bosko.radivojevic@gmail.com>
Subject: Re: High resolution timers on AT91SAM926x
Date: Mon, 3 Mar 2008 22:42:29 +0100
Message-ID: <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>
References: <200803011457.40857.david-b@pacbell.net>
	 <d6c8ef150803030226m75f68bffvfa20feba9133b247@mail.gmail.com>
	 <200803031039.57909.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: "David Brownell" <david-b@pacbell.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:42144 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759952AbYCCVmf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 16:42:35 -0500
Received: by an-out-0708.google.com with SMTP id d31so60030and.103
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Mar 2008 13:42:34 -0800 (PST)
In-Reply-To: <200803031039.57909.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David,

I had CONFIG_ATMEL_TCLIB enabled, but not TCB_CLKSRC and
TCB_CLKSRC_BLOCK=0. With all those options, I finally have HRT
functionality. But, strange thing is that jitter of my little example
(get time, sleep 1ms, get time, show the difference) is around 250us.
Maybe this is normal for this architecture?

System is (as noted on rt.wik site) very slow with NO_HZ option enabled.

Thanks again!

On Mon, Mar 3, 2008 at 7:39 PM, David Brownell <david-b@pacbell.net> wrote:
> On Monday 03 March 2008, Bosko Radivojevic wrote:
>  > thank you for the reply. But, I'm getting pretty strange behavior.
>
>  Presumably you got different results when your Kconfig
>  enabled a HRT/NO_HZ capable clockevent source, instead
>  of just the PIT?
>
>  CONFIG_ATMEL_TCLIB=y
>
>
> CONFIG_ATMEL_TCB_CLKSRC=y
>  CONFIG_ATMEL_TCB_CLKSRC_BLOCK=0
>
