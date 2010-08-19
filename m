From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Thu, 19 Aug 2010 11:15:50 -0700
Message-ID: <AANLkTikFMnr=5=rgU5V7cny5j=ZNLVUJMEewvAOpbpEx@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
	<AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
	<4C6AC4A6.4080407@redhat.com>
	<AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
	<4C6AE6D7.2060006@us.ibm.com>
	<AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
	<4C6D46C7.5020209@us.ibm.com>
	<1282233963.31855.10.camel@baracus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nivedita Singhvi <niv@us.ibm.com>,
	David Sommerseth <davids@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46905 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0HSSPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Aug 2010 14:15:51 -0400
Received: by ewy23 with SMTP id 23so1515477ewy.19
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Aug 2010 11:15:50 -0700 (PDT)
In-Reply-To: <1282233963.31855.10.camel@baracus>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 19, 2010 at 9:06 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Thu, 2010-08-19 at 07:59 -0700, Nivedita Singhvi wrote:
>> On 08/17/2010 03:22 PM, Manikandan Ramachandran wrote:
>>
>>
>> > I see a scenario where higher priority task is ready to run but lo=
wer
>> > priority IRQ thread is hogging the cpu. Please see the timeline lo=
g
>> > below:
>> >
>> > GIVE ffff0c1c [Comment: High priority IRQ thread wakes up high
>> > priority process at jiffy 0xffff0c1c]
>> > **ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff=
0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c22##**ffff0c22**##fff=
f0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ff=
ff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##f=
fff0c22##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c23##**ffff0c23**##=
ffff0c24##**ffff0c24**##ffff0c24##**ffff0c24**##ffff0c24##
>> > [Comment: Low priority IDE[ide_intr] handler hogs CPU for almost 3=
 ms]
>> > GOTffff0c26 [Comment: High priority task wakes up after 10 ms!!]
>> >
>> > I fail to understand why scheduler failed to schedule high priorit=
y
>> > task 10 times in a row. FYI, I have put IDE thread to SCHED_NORMAL
>> > while high priority thread and task to SCHED_FIFO.
>>
>> Not really sure from the above what's going on, what priorities
>> you are running at, etc.
>>
>> You might want look at the output of "ps -eLo pid,rtprio,policy,comm=
"
>> to see if you can confirm your scheduler attributes.
>>
>
> Also, use the tracing facilities, as its hard to understand your time
> line and the source of it.
>
> I think if your priorities are right, your kernel config is right, an=
d
> your measurement tool doesn't interfere, 10 ms latency is incredibly
> unlikely.
>
>
>> thanks,
>> Nivedita
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
I see many tracing options. Any trace config in particular?


--=20
Thanks,
Manik
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
