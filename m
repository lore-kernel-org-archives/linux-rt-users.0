From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 1/1] ftrace: fix typo in ftrace.txt file
Date: Wed, 20 May 2009 13:40:24 +0900
Message-ID: <49b7c2350905192140nba960d8l7af31c29752a8fcd@mail.gmail.com>
References: <1242783692.31161.56.camel@centos51>
	 <alpine.DEB.2.00.0905192153080.7816@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	tglx <tglx@linutronix.de>, williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:1657 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZETEkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2009 00:40:23 -0400
In-Reply-To: <alpine.DEB.2.00.0905192153080.7816@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/5/20 Steven Rostedt <rostedt@goodmis.org>:
>
> On Wed, 20 May 2009, GeunSik Lim wrote:
>
>>
>>
>> commit 43bf3fdddfd6b0ac65ef59bec3c79d9f9064e8bd
>> Author: GeunSik,Lim <leemgs1@gmail.com>
>> Date: =C2=A0 Thu May 14 13:39:18 2009 +0900
>>
>> =C2=A0 =C2=A0 ftrace: fix typo in ftrace.txt file.
>>
>> =C2=A0 =C2=A0 Fix typo about chart to map the kernel priority to
>> =C2=A0 =C2=A0 user land priorities.
>>
>> =C2=A0 =C2=A0 About sched_setscheduler(2)
>> =C2=A0 =C2=A0 Processes scheduled under SCHED_FIFO or SCHED_RR
>> =C2=A0 =C2=A0 can have a static priority in the range 1 to 99.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: GeunSik Lim <geunsik.lim@=
samsung.com>
>>
>> diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ft=
race.txt
>> index fd9a3e6..0e17632 100644
>> --- a/Documentation/trace/ftrace.txt
>> +++ b/Documentation/trace/ftrace.txt
>> @@ -518,9 +518,14 @@ priority with zero (0) being the highest priori=
ty and the nice
>> =C2=A0values starting at 100 (nice -20). Below is a quick chart to m=
ap
>> =C2=A0the kernel priority to user land priorities.
>>
>> - =C2=A0Kernel priority: 0 to 99 =C2=A0 =C2=A0=3D=3D> user RT priori=
ty 99 to 0
>> - =C2=A0Kernel priority: 100 to 139 =3D=3D> user nice -20 to 19
>> - =C2=A0Kernel priority: 140 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D> idle=
 task priority
>> + Kernel priority: 0(high) to 99(low) =C2=A0 =C2=A0=3D=3D> user RT p=
riority 99(high) to 1(low)
>
> Shouldn't that be:
>
> =C2=A0Kernel priority: 0(high) to 98(low) =C2=A0 =C2=A0=3D=3D> user R=
T priority 99(high) to 1(low)
>
Thank you for your opinion.  I think about corrected expression for
quick chart to map between kernel space and user space in ftrace .

> 100 items does not map to 99. Which begs the question, what can have
> internal kernel priority 99?
>
ok.  Below example is about  kernel (static) priority 99 that you said.
please, refer to
http://www.kernel.org/doc/man-pages/online/pages/man2/sched_setschedule=
r.2.html
 webpage.

 For processes scheduled under one of the normal scheduling policies
(SCHED_OTHER, SCHED_IDLE, SCHED_BATCH), sched_priority is not used in
 scheduling decisions (it must be specified as 0).


int main (int argc, char **argv)
{	int pidnumber, ret;
	struct sched_param p;
	p.sched_priority =3D 0; <------ Kernel (static) priority.
	if (argc !=3D 2) {
		printf("usage: setbatch <pid>\n");
		exit(-1);
	}
	pidnumber =3D atol(argv[1]);
         /* 3 =3D Number of SCHED_BATCH Constant */
	ret =3D sched_setscheduler(pidnumber, 3, &p);
	if (ret) {
		printf("could not set pid %d to SCHED_BATCH: err %d.\n", pid, ret);
		return -1;
	}
	printf("pid %d is SCHED_BATCH from now on.\n", pid);
	return 0;
}


>> + Kernel priority: 100(high) to 139(low) =3D=3D> user nice -20(high)=
 to 19(low)
>> + Kernel priority: 140 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D=3D> idle task priority
>> +
>> +Processes scheduled with SCHED_OTHER or SCHED_BATCH must be assigne=
d
>> +the static priority 0. Processes scheduled under SCHED_FIFO or SCHE=
D_RR
>
> This line is confusing. "static priorty 0" really has no meaning here=
=2E
> Those now enter the "nice" priorities, and this statement does not
> represent what is shown in the ftrace output.
>
I agree with your opinion about exact understanding of ftrace output.
I will remove this additional description to avoid confusing
when we use this document as ftrace how to.

>> +can have a static priority in the range 1 to 99.
>> + (reference: $> man 2 sched_setscheduler)
>>
>
> -- Steve
>
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
