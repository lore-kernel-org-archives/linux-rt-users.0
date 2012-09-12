From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 22:29:00 +0200
Message-ID: <5050F08C.1070801@xenomai.org>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com> <02D8B38C-C6C2-43A8-B601-721B48612106@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Hartmut Behrens <hartmut.behrens@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xenomai.org ([88.191.95.136]:38712 "EHLO xenomai.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab2ILU3E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 16:29:04 -0400
In-Reply-To: <02D8B38C-C6C2-43A8-B601-721B48612106@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/12/2012 09:01 PM, Sven-Thorsten Dietrich wrote:

> 
> On Sep 12, 2012, at 3:20 AM, Hartmut Behrens
> <hartmut.behrens@gmail.com> wrote:
> 
>> Hi,
>> 
>> I have patched a 3.2 kernel for a OMAP compatible processor (ARM 
>> Cortex A8) to be used on an Gumstix Overo with the
>> CONFIG_PREEMPT_RT patch.
>> 
>> I have noticed that the latency of the patched kernel on this
>> platform is <300usec (using cyclictest), similar to what is
>> reported for the ARM9 platforms at 
>> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
>> 
>> Is this the best performance that can be expected from ARM7/9
>> platforms?
>> 
>> Could it be improved by using different kernel config settings -
>> e.g. CONFIG_LATENCY_TRACE=n  - 
>> https://rt.wiki.kernel.org/index.php/Cyclictest mentions that
>> latency tracing adds significant kernel overhead?
> 
> 
> There are a lot of options that can be eliminated / optimized to
> reduce memory footprint and overhead.


One of these options is, maybe surprisingly, CONFIG_THUMB2_KERNEL.

-- 
                                                                Gilles.
