From: =?ISO-8859-15?Q?Max_M=FCller?= <mxmr@gmx.net>
Subject: Re: Tweak Latency on Intel ATOM
Date: Thu, 11 Feb 2010 08:54:29 +0100
Message-ID: <4B73B7B5.4070509@gmx.net>
References: <loom.20100209T081421-234@post.gmane.org> <20100210163818.7f54ec3a@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:42306 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0BKIFf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2010 03:05:35 -0500
In-Reply-To: <20100210163818.7f54ec3a@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams schrieb:
> On Tue, 9 Feb 2010 07:41:58 +0000 (UTC)
> Max Miller <mxmr@gmx.net> wrote:
>
>  =20
>> Hello,
>>
>> im am using the PREEMPT-RT patch on linux 2.6.29.6. It runs on a MSI=
965GSE
>> industial board with Intel ATOM CPU (N270, 1,6GHz) and i945GSE North=
bridge.=20
>>
>> I got about 45=B5s as maximum and 13=B5s as average latency when hyp=
erthreading is
>> disabled. With enabled Hyperthreading the maximum latency increses t=
o about
>> 100=B5s. I measured the latency with cyclictest.=20
>>
>> What can i do to get better maximum latency? Can I do somthing in th=
e kernel
>> configuration or are there some kernel bootoptions? Or is it still i=
mpossible
>> with this CPU to get better results?
>>
>> Thanks in advance,
>> Max Miller=20
>>
>>
>>    =20
>
> Make sure you turn off any power management settings in the BIOS and
> turn off the irqbalance and cpuspeed services on the Linux side.
>
> What cyclictest command are you using to measure latency?
>
> Clark
>  =20

I run cyclictest as follows:

cyclictest -n -t3 -p99

=46or generating additional system load i run (one to several instances=
):

while true; do echo "blah" > /dev/null; done &

Then i watch the max. latency from the thread with the highest priority=
=2E
Sometimes i add the parameter '-h' to generate a history. In this=20
history i can
see that the most latency times are under 20=B5s, only  about 5ppm are=20
worse than 30=B5s.
Am i doing this correctly?


The only powersave setting in the BIOS is "Intel speedstep" which i=20
disabled.


I will check with disabled "irqbalance and cpuspeed services" disabled=20
and will report later.


What should the adequate max. latency on this system?





--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
