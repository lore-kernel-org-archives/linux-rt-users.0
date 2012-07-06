From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 02:07:12 -0400
Message-ID: <4FF68090.5050605@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <4FF4C94A.6040105@osadl.org> <4FF5DFDC.9010501@gmail.com> <4FF619D5.3090206@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44381 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2GFGHQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 02:07:16 -0400
Received: by qadb17 with SMTP id b17so241542qad.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2012 23:07:15 -0700 (PDT)
In-Reply-To: <4FF619D5.3090206@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

Thanks! I'll try to take a look at these systems.

Cheers!

Dong

On 7/5/12 6:48 PM, Carsten Emde wrote:
> Hi Dong,
>
>> I tried to disable CONFIG_RT_GROUP_SCHED, but I still got cpu stalls!
> Hmm, sorry. I hoped it would work.
>
>> Is there a recommended config for the RT patch?
> Not really. In the x86 distro case, we base everything on the distro
> configuration, e.g. using
> cp /boot/config-`uname -r` .config
>
> We then disable CONFIG_RT_GROUP_SCHED and CONFIG_DEBUG_STACKOVERFLOW,
> because they are known to cause trouble and long latencies,
> respectively. In addition, we enable diagnostics such a latency
> histograms. That's all.
>
> An alternative approach would be to select a QA farm system that is
> close to your hardware and distro and use the same settings on your
> system. A list of all farm systems sorted by distro is here ->
> https://www.osadl.org/?id=1070; clicking on the system name in the first
> row of this table will display its entire profile. This includes kernel
> parameter, hardware data and, of course, the kernel configuration.
> Sometimes, there is also a quilt series, in case we temporarily use
> off-tree patches that are on their way to mainline. Would be interesting
> to see whether your system also stalls when a configuration is used that
> is successful here.
>
> -Carsten.

