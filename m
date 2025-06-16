Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.18.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9620487E;
	Tue, 17 Jun 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.18.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126497; cv=none; b=WlOAkDrujywtitrrUxsi+L0rvQcxsim5/YH2w2QLorijU58C2U5KHfBe/N3/3RFZqqXxfMCRD+idpScPi59DarRs/KsEPH+IAdaf5teQw7wXb2G0kMuVkmm0acNrV92IPLgGqeG0zdwILXksM3ourM4weGeWqVx3jLNY54QI1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126497; c=relaxed/simple;
	bh=Q1A8J6tIZQqQmeNjPYf+1EQTardLiNg1Qdfg4G9Msg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OoEMlEZcdH5aNnRcMcUiWweiWFHC4qEObL9OEBVE1OTzGmt5c8FFRwkHPsSBP9DHfsFoeC1i8K1fVFAFkNIIu4EEDAnh+w6PZt0RcMrO7nI3lUqZNhfaLOke4NCb0q9FBrAZ7h7RO9iRKhOo0p9zy53CK8HM5wMOemouhGbKjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.18.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1uRBTp-000000005bF-2pH6;
	Mon, 16 Jun 2025 17:10:37 +0200
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id 2D42110043C;
	Mon, 16 Jun 2025 17:10:34 +0200 (CEST)
Message-ID: <d72bc0b1-7898-4513-9b50-60b56112c8e1@eltropuls.de>
Date: Mon, 16 Jun 2025 17:10:33 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
Content-Language: de-DE, en-US
In-Reply-To: <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hi Sebastian,

On 14.06.25 10:52, Marc Strämke wrote:
>
> I do not really understand where the IRQ/Preemption disabling is 
> happening. What would the next thing be to do? Function (graph?) 
> tracing on all the functions visible in the backtrace?
>
>
> I tried to look at the event race output starting with the call to 
> igb_set_rx_mode. I have attached the trace with all events and a 
> function filter on igb on only the cpu executing ip.  I cannot 
> understand what is happening between timestasmp 700.149995 and the IRQ 
> disable event on 700.150795....
>
>
> Thanks for your help,
>
> Marc
>
>
I am still trying to figure that puzzle out: Please see the following 
function trace snippet:

ip-690530  [000] ..... 178636.460435: rtnl_is_locked <-__dev_change_flags
ip-690530  [000] ..... 178636.460435: __local_bh_disable_ip 
<-__dev_change_flags
ip-690530  [000] ..... 178636.460435: migrate_disable 
<-__local_bh_disable_ip
ip-690530  [000] ...1. 178636.460435: preempt_disable: 
caller=__local_bh_disable_ip+0x76/0xe0 
parent=__local_bh_disable_ip+0x76/0xe0
ip-690530  [000] ...11 178636.460435: preempt_enable: 
caller=__local_bh_disable_ip+0x76/0xe0 
parent=__local_bh_disable_ip+0x76/0xe0
ip-690530  [000] ....1 178636.460435: rt_spin_lock <-__local_bh_disable_ip
ip-690530  [000] ....1 178636.460436: __rcu_read_lock <-rt_spin_lock
ip-690530  [000] ....1 178636.460436: migrate_disable 
<-__local_bh_disable_ip
ip-690530  [000] ....2 178636.460436: __rcu_read_lock 
<-__local_bh_disable_ip
ip-690530  [000] b...2 178636.460436: rt_spin_lock <-__dev_change_flags
ip-690530  [000] b...2 178636.460436: __rcu_read_lock <-rt_spin_lock
ip-690530  [000] b...2 178636.460436: migrate_disable <-__dev_change_flags
ip-690530  [000] b...3 178636.460436: __dev_set_rx_mode <-__dev_change_flags
ip-690530  [000] b...3 178636.460437: igb_set_rx_mode <-__dev_change_flags

It is my understanding that __local_bh_disable_ip called from 
netif_addr_lock_bh seems to be the origin of my latency.

What i do not understand is, even if the bottom halves are disabled. 
Shouldn't I see the interrupt arriving in the trace?

If i understood it correctly, your talk "Unblocking the softirq lock for 
PREEMPT_RT" during the plumbers conference 2023 is exactly about that 
case, right?

Probably fixing this issue is out of my abilities for now ;-) The wast 
variety of locking concepts inside the kernel is quite intimidating for 
a newcomer in kernel land...


Regards,


Marc

