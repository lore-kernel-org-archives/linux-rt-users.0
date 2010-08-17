From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 15:22:40 -0700
Message-ID: <AANLkTimzwSq_8A6vQftOUptpSkhY5nbc37ihx=r=Ff33@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
	<AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
	<4C6AC4A6.4080407@redhat.com>
	<AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
	<4C6AE6D7.2060006@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Sommerseth <davids@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45020 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0HQWWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 18:22:42 -0400
Received: by wwf26 with SMTP id 26so1609787wwf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 15:22:41 -0700 (PDT)
In-Reply-To: <4C6AE6D7.2060006@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 17, 2010 at 12:45 PM, Nivedita Singhvi <niv@us.ibm.com> wro=
te:
> On 08/17/2010 11:24 AM, Manikandan Ramachandran wrote:
>
>> Thanks David& =A0Mark for your valuable input!
>>
>> I'm not expecting RT kernel to be real fast. However I expect latenc=
y
>> of higher priority task to be less in RT kernel. I'll run the tests
>> that you have suggested and see if there is any inherent issue with =
my
>> system.
>
> Actually, a more accurate statement would be "I expect max latency
> of higher priority task to be less in RT kernel."
>
> This is true for max latency as reported by you (max, min):
>
> Stock: =A0418011us =A0 =A0 =A0 =A03s
> RT: =A0 =A0 366156us =A0 =A0 =A0 =A03s
>
> So while the min might reflect the best that the system can do, the
> max does seem a tad high -- you do need to look into that.
>
>> One more query, with RT patch is it possible for higher priority tas=
k
>> to preempt a lower priority IRQ thread [For eg, IDE] ? If so when do=
es
>> that happen, during next timer interrupt [Assuming IRQ thread uses
>> whole schedule slot and doesn't yield between]?
>
> Yes, and when that higher priority task becomes runnable.
>
> thanks,
> Nivedita
> --

I see a scenario where higher priority task is ready to run but lower
priority IRQ thread is hogging the cpu. Please see the timeline log
below:

GIVE ffff0c1c [Comment: High priority IRQ thread wakes up high
priority process at jiffy 0xffff0c1c]
**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c21#=
#**ffff0c21**##ffff0c21##**ffff0c21**##ffff0c22##**ffff0c22**##ffff0c22=
##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c2=
2##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c22##**ffff0c22**##ffff0c=
22##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0c23##**ffff0c23**##ffff0=
c24##**ffff0c24**##ffff0c24##**ffff0c24**##ffff0c24##
[Comment: Low priority IDE[ide_intr] handler hogs CPU for almost 3 ms]
GOTffff0c26 [Comment: High priority task wakes up after 10 ms!!]

I fail to understand why scheduler failed to schedule high priority
task 10 times in a row. FYI, I have put IDE thread to SCHED_NORMAL
while high priority thread and task to SCHED_FIFO.

--=20
Thanks,
Manik
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
