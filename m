From: "Remy Bohmer" <l.pinguin@gmail.com>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Mon, 16 Jul 2007 22:17:08 +0200
Message-ID: <3efb10970707161317h72b30aabq208150b2abde8e5e@mail.gmail.com>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com>
	 <1184615557.2698.3.camel@laptopd505.fenrus.org>
Reply-To: linux@bohmer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	mathieu.desnoyers@polymtl.ca, "Ingo Molnar" <mingo@elte.hu>
To: "Arjan van de Ven" <arjan@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:4934 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbXGPURI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 16:17:08 -0400
Received: by py-out-1112.google.com with SMTP id d32so2502373pye
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jul 2007 13:17:08 -0700 (PDT)
In-Reply-To: <1184615557.2698.3.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Arjan,

Thanks for this suggestion.
But I looked at Systemtap before, and as I remember, it is very
flexible, but it only traces function calls. (or am I missing
something?)
I also need this scheduler-tracer, besides for fully fledged X86
systems, also for ARM based boards also with a very minimal userland,
and limited flash. So, it has to be lightweight also. I can only use
cross-compilers to build the tools... (something Systemtap is not good
at as I remember...)

So, I am missing something here, or it is unfortunately not what I am
looking for...


Kind Regards,

Remy


2007/7/16, Arjan van de Ven <arjan@infradead.org>:
> On Mon, 2007-07-16 at 21:46 +0200, Remy Bohmer wrote:
> > So I was wondering if anybody knows some tool/kernel mechanism which
> > can do this?
> > If not, I will build a kernel extension for it myself (new extension
> > to 'latency_trace' ?)
>
> systemtap has been able to do such things for me in the past...
>
> --
> if you want to mail me at work (you don't), use arjan (at)
> linux.intel.com
> Test the interaction between Linux and your BIOS via
> http://www.linuxfirmwarekit.org
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
