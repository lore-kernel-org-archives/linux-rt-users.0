From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 0/1] sched: fix typo in sched-rt-group.txt file
Date: Thu, 21 May 2009 10:47:32 +0900
Message-ID: <49b7c2350905201847l1ea97fcfvc3dd5067163e73f3@mail.gmail.com>
References: <1242783552.31161.53.camel@centos51>
	 <49b7c2350905192150n4d6b710er571b8a1bd228198b@mail.gmail.com>
	 <alpine.DEB.2.00.0905201433060.1080@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	tglx <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:48937 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbZEUBrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2009 21:47:33 -0400
In-Reply-To: <alpine.DEB.2.00.0905201433060.1080@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 21, 2009 at 3:59 AM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
>
> On Wed, 20 May 2009, GeunSik Lim wrote:
>
>> 2009/5/20 GeunSik Lim <leemgs1@gmail.com>:
>> >
>> >
>> > Dear Ingo,
>> >
>> >
>> > I made 2 patch files again about static prioriy levels according t=
o ingo's advice
>> > and explanation. (Reference: http://marc.info/?t=3D124211992800003=
&r=3D1&w=3D2 archives. )
>> >
>> > Fix static priority related range and chart map(userspace/kernelsp=
ace) of ftrace.
>> > =C2=A0 - about chart map of static priority in =C2=A0ftrace.txt fi=
le
>> > =C2=A0 - about static priority levels(range) in sched-rt-group.txt=
 file
>> >
>> >
>> > commit d6af702008117ca489a2f5476239d1688a517e98
>> > Author: GeunSik,Lim <leemgs1@gmail.com>
>> > Date: =C2=A0 Tue May 12 17:20:32 2009 +0900
>> >
>> > =C2=A0 =C2=A0sched: fix typo in sched-rt-group.txt file
>> >
>> > =C2=A0 =C2=A0Fix typo about static priority's range.
>> >
>> > =C2=A0 =C2=A0* Kernel Space priority 0(high) to 99(low) =C2=A0 -->=
 User Space RT priority 99(high) to 1(low)
>> > =C2=A0 =C2=A0* Kernel Space priority 100(high) to 139(low)--> User=
 Space nice -20(high) to 19(low)
>> >
>>
>> Ingo,
>> I want to =C2=A0change some descriptions according to below discussi=
on.
>>
>> before) * Kernel Space priority 0(high) to 99(low) =C2=A0 --> User S=
pace RT
>> priority 99(high) to 1(low)
>> after) =C2=A0 =C2=A0* =C2=A0Kernel Space priority 0(high) to 98(low)=
 =C2=A0 --> User Space
>> RT priority 99(high) to 1(low)
>>
>> I want to your advice and opinion about this changes.
>>
>> If I mistook, Please correct me.
>>
>> thks.
>>
>>
>>
>> Steven Rostedt:
>> =C2=A0 Shouldn't that be:
>> =C2=A0 Kernel priority: 0(high) to 98(low) =C2=A0 =C2=A0=3D=3D> user=
 RT priority 99(high) to 1(low)
>>
>> GeunSik Lim :
>> =C2=A0 Thank you for your opinion. =C2=A0I think about corrected exp=
ression for
>> =C2=A0 quick chart to map between kernel space and user space in ftr=
ace .
>>
>> Steven Rostedt:
>> =C2=A0100 items does not map to 99. Which begs the question, what ca=
n have
>> =C2=A0internal kernel priority 99?
>>
>> GeunSik Lim :
>> =C2=A0 ok. =C2=A0Below example is about =C2=A0kernel (static) priori=
ty 99 that you said.
>> =C2=A0 please, refer
>> =C2=A0 to http://www.kernel.org/doc/man-pages/online/pages/man2/sche=
d_setscheduler.2.html
>> =C2=A0webpage.
>>
>> =C2=A0 For processes scheduled under one of the normal scheduling po=
licies
>> =C2=A0 (SCHED_OTHER, SCHED_IDLE, SCHED_BATCH), sched_priority is not=
 used in
>> =C2=A0 scheduling decisions (it must be specified as 0).
>>
>> int main (int argc, char **argv)
>> { =C2=A0 =C2=A0 int pidnumber, ret;
>> =C2=A0 =C2=A0 =C2=A0 struct sched_param p;
>> =C2=A0 =C2=A0 =C2=A0 p.sched_priority =3D 0; <------ Kernel (static)=
 priority.
>> =C2=A0 =C2=A0 =C2=A0 if (argc !=3D 2) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("usage: setb=
atch <pid>\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(-1);
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 pidnumber =3D atol(argv[1]);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 3 =3D Number of SCHED_BATCH Con=
stant */
>> =C2=A0 =C2=A0 =C2=A0 ret =3D sched_setscheduler(pidnumber, 3, &p);
>> =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("could not s=
et pid %d to SCHED_BATCH: err %d.\n", pid, ret);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 printf("pid %d is SCHED_BATCH from now on.\n", =
pid);
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> }
>>
>>
>> >
>> > =C2=A0 =C2=A0Processes scheduled with SCHED_OTHER or SCHED_BATCH m=
ust be assigned
>> > =C2=A0 =C2=A0the static priority 0. Processes scheduled under SCHE=
D_FIFO or SCHED_RR
>> > =C2=A0 =C2=A0can have a static priority in the range 1 to 99.
>> > =C2=A0 =C2=A0(reference: $> man 2 sched_setscheduler)
>> >
>> > =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
>> >
>> > diff --git a/Documentation/scheduler/sched-rt-group.txt b/Document=
ation/scheduler/sched-rt-group.txt
>> > index 5ba4d3f..1537146 100644
>> > --- a/Documentation/scheduler/sched-rt-group.txt
>> > +++ b/Documentation/scheduler/sched-rt-group.txt
>> > @@ -169,7 +169,7 @@ get their allocated time.
>> >
>> > =C2=A0Implementing SCHED_EDF might take a while to complete. Prior=
ity Inheritance is
>> > =C2=A0the biggest challenge as the current linux PI infrastructure=
 is geared towards
>> > -the limited static priority levels 0-139. With deadline schedulin=
g you need to
>> > +the limited static priority levels 0-99. With deadline scheduling=
 you need to
>> > =C2=A0do deadline inheritance (since priority is inversely proport=
ional to the
>> > =C2=A0deadline delta (deadline - now).
>
> Note, this document deals with internal kernel manipulations. The "pr=
io"
> inside the kernel is indeed 0-139. Actually, if we count the idle tas=
k, it
> is 0-140. The PI code will also deal with non RT tasks so it is corre=
ct to
> say that the priority inheritance deals with 0-139 (I don't think the=
 idle
> task ever touches anything needing PI).
>
> The sched_setscheduler user API uses a different priority mapping. I =
was
> looking at the code inside sched.c and I believe this is the mapping:
>
>
> 0 to 98 - maps to RT tasks 99 to 1 (SCHED_RR or SCHED_FIFO)
>
> 99 - maps to internal kernel threads that want to be lower than RT ta=
sks
> =C2=A0 =C2=A0 but higher than SCHED_OTHER tasks. Although I'm not sur=
e if any
> =C2=A0 =C2=A0 kernel thread actually uses this. I'm not even sure how=
 this can be
> =C2=A0 =C2=A0 set, because the internal sched_setscheduler function d=
oes not allow
> =C2=A0 =C2=A0 for it.
Thank you for additional explanation about kernel-space static priority=
 99
in the map of priority values between kernel-space and user-space.

I will update like belows.

Kernel priority: 0(high) to 98(low)      =3D=3D> user RT priority 99(hi=
gh)
to 1(low) with SCHED_RR or SCHED_FIFO
Kernel priority: 99                            =3D=3D> sched_priority i=
s
not used in scheduling deci
sions (it must be specified as 0)
Kernel priority: 100(high) to 139(low) =3D=3D> user nice -20(high) to 1=
9(low)
Kernel priority: 140                          =3D=3D> idle task priorit=
y


>
> 100 to 139 - maps nice levels -20 to 19. These are not set via
> =C2=A0 =C2=A0sched_setscheduler, but are set via the nice system call=
=2E
>
> 140 - reserved for idle tasks.
>
> -- Steve
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
