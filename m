From: Ove Karlsen <ove.karlsen@paradoxuncreated.com>
Subject: Re: rt kernel, pro-audio use
Date: Thu, 20 Dec 2012 09:36:51 +0100
Message-ID: <50D2CE23.2050303@paradoxuncreated.com>
References: <50D231F5.4060604@gentoostudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Damien Moody <webmaster@gentoostudio.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:48990 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2LTIga (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 03:36:30 -0500
In-Reply-To: <50D231F5.4060604@gentoostudio.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/19/2012 10:30 PM, Damien Moody wrote:
> Hi,
>
> I have a couple of questions.
>
> 1. I'd like to keep informed when the rt kernel gets updated, so I can 
> put up a new Gentoo ebuild on my site (gentoostudio.org). Is this the 
> list for that? If not, what is?
>
> 2. I use the rt patches a la rt-sources on Gentoo. I'm a musician and 
> audio engineer. What advantages does the rt patch set provide over 
> other patch sets like ck-sources and pf-sources, where latency can be 
> configured to be very low? I'd like to document this on my site.
>
> Thanks!
> Damien
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
1 - yes. Have your email client filter mails with "announce" in the 
header, to "rt kernel updates" folder for instance. Something like that.

2 - rt-patch provides extremely low latency, if you hardware can handle 
it. Intel E5 is a good cpu, for extreme low latency.
Ck-patches doesn`t really provide any improvement over fair-scheduler. 
Actually fair-scheduler performs on overall better, with lower peak 
latencies. Ck-patches has slightly lower average latencies. While 
audio-performance was similar when I tested both, visual jitter, was 
less with fair scheduler, and 90hz timer.

I did some tests to make linux run with the least-jitter possible. You 
can read the conlusions on that here: 
http://paradoxuncreated.com/Blog/wordpress/?p=2268

It seems RT-patch is not neccesary for very low latency audio, and a 
good firewire card, atleast on the old firewire-stack, hopefully the new 
one is as good at latency, where I ran audio at 0.33ms latency, with 
RT-threads.

The rt-patch using only threadmode, (not impacting performance, other 
than on the thread it is used) might be good for audio, since visual 
jitter already can be minimized on the regular kernel. if 0.33 should 
not work with standard and it is a software problem, or you want to try 
even lower. 0.2ms is very close to virtual hardware, and ofcourse is 
something a musician would want.

Other than that RT patch might have specific uses outside general 
computing and media.

Peace Be With You.




