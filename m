From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Fri, 06 Jul 2012 11:58:46 -0400
Message-ID: <4FF70B36.3050103@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF68396.2010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34741 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2GFP6t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 11:58:49 -0400
Received: by eaak11 with SMTP id k11so3711066eaa.19
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2012 08:58:48 -0700 (PDT)
In-Reply-To: <4FF68396.2010904@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 7/6/12 2:20 AM, Dong Liu wrote:

>
> Is it possible to non-preemptible RCU in PREEMPT_RT kernel? I know it
> will reduce the system's RT performance, but we can make sure the reason
> of this cpu stall error is the preemptible RCU
>
>

I tried this approach. I made some change to init/Kconfig 
kernel/rcutree.c. Successful built the PREEMPT kerne with 
non-preemptible rcu implementation. But the kernel crashed at boot time :(

Dong
