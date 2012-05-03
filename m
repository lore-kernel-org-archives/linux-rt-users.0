From: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Subject: Re: real-time CAN bus with Linux on ARM (Beagleboard/bone)
Date: Thu, 3 May 2012 15:39:19 +0900
Message-ID: <CAKG=6c6hGXBkW3CU5-+67jMApzJmGv8Lm=_+Mci+K3F9G6y+rw@mail.gmail.com>
References: <CAKG=6c7PCBrBCvBYSnz8pXGeiudFvS3tQpAi1b3ZK1ker_HEUg@mail.gmail.com>
	<CAPB=Z-rsE=3w30HYa3DQ8C0_+ijJvf4LYC3UBDwO69w1Y9-dKQ@mail.gmail.com>
	<CAKG=6c536kqsSK1qceydAZ556+7=K-1sx3U7HDpn-aWDEL6+ag@mail.gmail.com>
	<CAPB=Z-rL5e8C5hE2WfQX1xM24waA8riU1TND1h-yAvx20LUuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37061 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab2ECGjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 02:39:21 -0400
Received: by bkcji2 with SMTP id ji2so1052817bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 02 May 2012 23:39:20 -0700 (PDT)
In-Reply-To: <CAPB=Z-rL5e8C5hE2WfQX1xM24waA8riU1TND1h-yAvx20LUuOA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2012/5/3 Raz <raziebe@gmail.com>
>
> specific driver. the CAN address space mapped is the pci hole address=
 space. This is how this specific board is designed.
> If i was in your shoes, i would have made some preliminary interrupt =
latency
> tests . There are cases where preempt rt is not suitable due to hardw=
are slowness.
> Did you test the board with cyclictest ?

Nope, I'm still in the prior step of investigating possible solutions
fulfilling my requirements. So, I haven't bought any hardware yet, but
I'm trying to find out which platform/set-up is suitable for my
development. Do you have any suggestions for me?

Marcus

>
> On Thu, May 3, 2012 at 9:06 AM, Marcus Liebhardt <marcus.liebhardt@yu=
jinrobot.com> wrote:
>>
>> 2012/5/2 Raz <raziebe@gmail.com>:
>> > funny.. just did CANopen driver a week ago.
>>
>> What do you mean exactly? Did you create a create a CANopen
>> implementation on top of SocketCAN or did you write a specific drive=
r
>> for the MCP2515 or the integrated CAN controller (DCAN)?
>>
>> >
>> > On Wed, May 2, 2012 at 5:27 AM, Marcus Liebhardt
>> > <marcus.liebhardt@yujinrobot.com> wrote:
>> >>
>> >> Hi everybody!
>> >>
>> >> Due to bandwidth and latency problems, I am currently investigati=
ng a
>> >> set-up involving CAN bus, an ARM board and a Linux RTOS to improv=
e our
>> >> motion control framework. For development and testing purpose, I =
have
>> >> the following set-up in mind:
>> >> A master node consisting of the Beaglebone [1] (similar to the
>> >> Beagleboard, powered by an ARM Cortex A8) in combination with a C=
AN
>> >> Cape [2] (includes two MCP2515 CAN controllers and additionally a=
llows
>> >> the use of the integrated CAN controller of the ARM microprocesso=
r).
>> >> The other nodes in the CAN network are custom boards.
>> >
>> >
>> >>
>> >> Before going into details about performance and configuration, I =
like
>> >> to ask, if there is anybody out there who successfully applied th=
e
>> >> RT-patch to a kernel working on the Beagleboard?
>> >
>> > I did it a week a go with AMD Geode 300MHZ.
>> >>
>> >> There have been discussions on this list and elsewhere about this
>> >> topic, but I couldn't find out, if someone finally succeeded in t=
his.
>> >> However, this paper [3] made me believe it is possible.
>> >> Since I am no expert in ARM software development, Linux, CAN nor
>> >> real-time systems, I'm looking for a working solution with a (as)
>> >> simple (as possible) configuration.
>> >> In my investigation I took a look at Xenomai (see [4] for example
>> >> set-up), but discarded it, because I couldn't find real-time safe
>> >> drivers for the mentioned CAN devices.
>> >> Using the Linux RT-patch seems to be less work than setting up Xe=
nomai
>> >> and writing specific modules for it. Also, telling from what I re=
ad in
>> >> this interesting discussion [5] it should be well-suited for our
>> >> requirements - we need 10 ms cycles and latencies below 1 ms shou=
ld be
>> >> enough, since that is already much better than what we have now.
>> >>
>> > I was required to deliver 4ms with with 200us latency on a hrtimer=
 along
>> > with CAN
>> > traffic. meaning, I have 5 of high prio threads must launch each 4=
ms,
>> > and check CAN mailbox for axis state , and obviously sending
>> > CAN output if needed.
>> > The CAN driver is user space. The high prio threads are use space.
>> > It took about a month till it worked. they were too many CAN packe=
t losses
>> > and overruns.
>>
>> OK, that makes me feel more confident about a Linux + PREEMPT_RT
>> solution, since you managed to get an application running with tough=
er
>> constraints.
>>
>> > This is what i did:
>> >
>> > 1. I use preempt rt without any ftrace, or any other debug facilit=
y.
>> > i also compiled the kernel for a Geode processor.
>> >
>> > 2. I fixed my CAN kernel driver to use ISR and not threaded interr=
upt. There
>> > is no work in kernel other than waking the user space driver  and =
a context
>> > switch on Gedoe AMD costs over 50us . who needs it ?
>> >
>> > 3. Hack the hrtimer so that it will wake the user space high prio =
threads
>> > each 4 ticks
>> >    and not sleep ( do not do nanosleep if you need, your thread wi=
ll not  be
>> > awakened by the hrtimer but by ksoftirqq)
>> >
>> > 4. made CAN thread prio less by 1 than high prio threads.
>> >
>> > 5. modify can user space CAN thread to pull as many packets as pos=
sible
>> > while it can.
>> >
>> > 6. reduce lock contention the CAN implementation. i suggest you se=
parate the
>> > tx from rx.
>> >    and if can , do not  lock with mutexes but use gcc  atomic buil=
tins
>> > operations to handle the queues.
>> >
>> > The code is legacy code written originally to vxWorks - i do the p=
orting to
>> > linux preempt rt
>> > so i get plenty of user space.
>>
>> Thanks for these detailed hints. Maybe in some weeks I will actually
>> be able to make use of them! ;-)
>>
>> Cheers,
>> Marcus
>>
>> >
>> >
>> >> However, the CAN support still gives me an headache. The CAN cape
>> >> manufacturer claims a SocketCAN support. However, I'm not sure, i=
f the
>> >> SocketCAN driver is suitable for RT applications. As far as I
>> >> understood, the RT patch will not change or affect the SocketCAN
>> >> driver, meaning that it will not make this driver real-time safe.=
 So,
>> >> I am wondering if a SocketCAN device will actually support the cy=
cle
>> >> time and latency we need. I read, that one can tune the RT system=
 by
>> >> configuring it according to one's needs. For example, I could ada=
pt
>> >> the priorities of the IRQs connected to the CAN device. Assuming =
what
>> >> I wrote so far is correct - please correct my if otherwise - my
>> >> question is:
>> >> Do you think the described set-up is feasible and will support ou=
r
>> >> requirements?
>> >>
>> >> Thanks a lot for your feedback!
>> >>
>> >> Best regards,
>> >> Marcus Liebhardt
>> >>
>> >> [1] http://beagleboard.org/bone
>> >> [2] http://www.towertech.it/en/products/hardware/tt3201-can-cape/
>> >> [3] https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf
>> >> [4]
>> >> http://veter-project.blogspot.com/2011/09/real-time-enough-about-=
pwms-and-shaky.html
>> >> [5] http://www.spinics.net/lists/linux-rt-users/msg05648.html
>> >>
>> >> --
>> >> Dipl.-Ing. (M.Sc.) Marcus Liebhardt
>> >> Control Engineer
>> >> Yujin Robot
>> >> =C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=
=B5=B1=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601=
, 153-023.
>> >> Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-g=
u,
>> >> Seoul, 153-023, Republic of Korea
>> >> Website: http://www.yujinrobot.com
>> >> Email: marcus.liebhardt@yujinrobot.com
>> >> Phone: +82-2-2104-0435
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-r=
t-users"
>> >> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> >
>> >
>>
>> --
>> Dipl.-Ing. (M.Sc.) Marcus Liebhardt
>> Control Engineer
>> Yujin Robot
>> =C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=
=B1=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 1=
53-023.
>> Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
>> Seoul, 153-023, Republic of Korea
>> Website: http://www.yujinrobot.com
>> Email: marcus.liebhardt@yujinrobot.com
>> Phone: +82-2-2104-0435
>
>



--
Dipl.-Ing. (M.Sc.) Marcus Liebhardt
Control Engineer
Yujin Robot
=C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=B1=
=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 153-=
023.
Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
Seoul, 153-023, Republic of Korea
Website: http://www.yujinrobot.com
Email: marcus.liebhardt@yujinrobot.com
Phone: +82-2-2104-0435
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
