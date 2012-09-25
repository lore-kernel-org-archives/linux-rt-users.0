From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Memory leak in 3.4.x-rt ?
Date: Tue, 25 Sep 2012 18:18:31 +0200
Message-ID: <5061D957.4060305@osadl.org>
References: <503775B3.4080504@cantastic.org> <CAL8zT=j5qF=b3bsehLZtV3X7F71LR+aX6L0zGKJqHZd=avkSug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmFsZiBSw7ZzY2g=?= <rtlinux@cantastic.org>,
	linux-rt-users@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:58490 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758222Ab2IYQUK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Sep 2012 12:20:10 -0400
In-Reply-To: <CAL8zT=j5qF=b3bsehLZtV3X7F71LR+aX6L0zGKJqHZd=avkSug@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/25/2012 05:39 PM, Jean-Michel Hautbois wrote:
> 2012/8/24 Ralf R=C3=B6sch<rtlinux@cantastic.org>:
>> Hi,
>>
>> we work on our TX4938 (Toshiba Mips, little endian mode) based embed=
ded
>> system (motion control)
>> running successfully a 3.2 RT patched kernel for month now.
>>
>> I just give a try to a 3.4 RT patched kernel and detected a memory p=
roblem
>> as you can see from the logs below:
>>
>> 3.2 with RT FULL PREEMPT is o.k
>> 3.4 without RT FULL PREEMPT is .ok.
>> 3.4 with RT FULL PREEMPT is not o.k.
>>  [..]
>> uname -a
>> Linux MCU 3.4.9-rt17-11244-gb12622a #23 PREEMPT RT Fri Aug 24 12:15:=
49 CEST
>> 2012 mips GNU/Linux
>> [root@MCU:/opt]# watch -n 1 cat /proc/meminfo  | grep MemFree
>> MemFree:          204304 kB
>> MemFree:          204208 kB
>> MemFree:          204112 kB
>> MemFree:          204064 kB
>> MemFree:          203968 kB
>> MemFree:          203920 kB
>> MemFree:          203824 kB
>> MemFree:          203776 kB
>[..]
> You have a big leak (around 100kB/sec), yes, but can you give us more=
 details ?
> What kind of application ? Network ? video encoder ?
> Which drivers are you using ?
> Did you try using some advanced tools in order to check that your
> application cannot have a memory leak in a specific use case (race
> condition ?) ?
> You will need to be more precise on the memory leak detection, becaus=
e
> with what you gave, I (maybe others can) cannot help you more...
In a first step, I would propose to run "cat /proc/meminfo" repeatedly=20
and no longer only check MemFree but check all other variables. One of=20
them will increase in the same amount as MemFree decreases. Which one i=
s=20
it? Slab? This information will then lead us where to search further.

	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
