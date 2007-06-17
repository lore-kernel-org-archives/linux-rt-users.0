From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.21.5-rt14 wont'compile here
Date: Sun, 17 Jun 2007 15:44:24 +0200
Message-ID: <46753AB8.6070305@gmx.net>
References: <46752AF7.10508@gmx.net> <20070617131041.GD18095@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbXFQNpF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Jun 2007 09:45:05 -0400
In-Reply-To: <20070617131041.GD18095@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:
> * Dragan Noveski <perodog@gmx.net> wrote:
>
>   
>> hi list,
>> since i am trying to compile 2.6.24/25 kernel with the rt-patches, no 
>> one version will compile here and i always get the same output.
>> this is how it looks like while trying to compile 2.6.21.4-rt13, but it 
>> looks the same for 2.6.21.5-rt14 :
>>     
>
>   
>>  LD      .tmp_vmlinux1
>> kernel/built-in.o:(.data+0x5d8): undefined reference to 
>> `preempt_mark_thresh'
>> make: *** [.tmp_vmlinux1] Fehler 1
>>     
>
> does the patch below fix this?
>
> 	Ingo
>
> Index: linux-rt.q/kernel/sysctl.c
> ===================================================================
> --- linux-rt.q.orig/kernel/sysctl.c
> +++ linux-rt.q/kernel/sysctl.c
> @@ -382,6 +382,8 @@ static ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= &proc_doulongvec_minmax,
>  	},
> +#endif
> +#ifdef CONFIG_EVENT_TRACE
>  	{
>  		.ctl_name	= CTL_UNNUMBERED,
>  		.procname	= "preempt_mark_thresh",
> @@ -390,8 +392,6 @@ static ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= &proc_doulongvec_minmax,
>  	},
> -#endif
> -#ifdef CONFIG_EVENT_TRACE
>  	{
>  		.ctl_name	= CTL_UNNUMBERED,
>  		.procname	= "trace_enabled",
>
>   
hi ingo, very much thanks for the patch, it is fixing the issue here.
i applied it to the 2.6.21.5-rt14 with '- p1' and the kernel just 
compiled successfully!

i am hurrying to do a reboot and check the performance now -thanks again!

cheers,
doc
