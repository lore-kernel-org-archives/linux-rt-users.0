From: =?ISO-8859-15?Q?Max_M=FCller?= <mxmr@gmx.net>
Subject: Re: Tweak Latency on Intel ATOM
Date: Tue, 16 Feb 2010 07:50:02 +0100
Message-ID: <4B7A401A.70902@gmx.net>
References: <loom.20100209T081421-234@post.gmane.org>	<20100210163818.7f54ec3a@torg>	<4B73B7B5.4070509@gmx.net>	<20100211093447.3c0a97cd@torg>	<4B7914C6.8080005@gmx.net> <20100215083847.1a4a7ef0@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:27840 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0BPGuC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Feb 2010 01:50:02 -0500
In-Reply-To: <20100215083847.1a4a7ef0@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams schrieb:
> On Mon, 15 Feb 2010 10:32:54 +0100
> Max M=FCller <mxmr@gmx.net> wrote:
> =20
>  =20
>>> I'd say you're doing pretty good keeping under 50us. You might want=
 to
>>> try it under a heavier load than the shell script you've been runni=
ng.
>>> If you don't want to fool with rteval, try kicking off a kernel com=
pile
>>> in another window like this:
>>>
>>> $ while true; do make -j4 clean bzImage modules; done
>>>
>>> and then run cyclictest. A kernel compile with parallel jobs (-j) i=
s a
>>> good overall load of computation and I/O.
>>>
>>>  =20
>>>      =20
>> I tested now like you told me with irqbalance and cpuspeed services=20
>> disabled. I hope i made the right for disabling irqbalance, i used t=
he=20
>> kernel parameter acpi_no_irqbalance. Is this correct? Unfortunately =
the=20
>> results were nearly equal as before.
>>    =20
>
> I don't think you're going to get much better results on the Atom. I
> have an MSI Nettop box with the dual-core version and I saw about the
> same results as you.
>
> What sort of scheduling deadlines are you trying to meet?=20
>
> Clark
>  =20
Shorter it is better it would be :-)
I can also live with this results, but i wanted to make sure to get the=
=20
best out of this hardware.

Are you running both cores on the MSI box (maybe also with=20
hyperthreading enabled) with this results?

In the meantime i thought also if the SMI (system management mode) coul=
d=20
have a bad influence. I wrote a little userspace  programm which=20
disables global SMI bit of the ICH7 southbridge. But also no better=20
results.
After that i was told (thanks to Luis Claudio!) to check latency with=20
the kernel module hwlat_detector. The results of this module was 0. I=20
interpreted this that there is no SMI that causes the latency on my ATO=
M=20
system.

Regards,
Max


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
