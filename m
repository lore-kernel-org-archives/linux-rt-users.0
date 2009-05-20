From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 0/1] sched: fix typo in sched-rt-group.txt file
Date: Wed, 20 May 2009 13:50:52 +0900
Message-ID: <49b7c2350905192150n4d6b710er571b8a1bd228198b@mail.gmail.com>
References: <1242783552.31161.53.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	tglx <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:39621 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZETEuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2009 00:50:51 -0400
In-Reply-To: <1242783552.31161.53.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/5/20 GeunSik Lim <leemgs1@gmail.com>:
>
>
> Dear Ingo,
>
>
> I made 2 patch files again about static prioriy levels according to i=
ngo's advice
> and explanation. (Reference: http://marc.info/?t=3D124211992800003&r=3D=
1&w=3D2 archives. )
>
> Fix static priority related range and chart map(userspace/kernelspace=
) of ftrace.
> =C2=A0 - about chart map of static priority in =C2=A0ftrace.txt file
> =C2=A0 - about static priority levels(range) in sched-rt-group.txt fi=
le
>
>
> commit d6af702008117ca489a2f5476239d1688a517e98
> Author: GeunSik,Lim <leemgs1@gmail.com>
> Date: =C2=A0 Tue May 12 17:20:32 2009 +0900
>
> =C2=A0 =C2=A0sched: fix typo in sched-rt-group.txt file
>
> =C2=A0 =C2=A0Fix typo about static priority's range.
>
> =C2=A0 =C2=A0* Kernel Space priority 0(high) to 99(low) =C2=A0 --> Us=
er Space RT priority 99(high) to 1(low)
> =C2=A0 =C2=A0* Kernel Space priority 100(high) to 139(low)--> User Sp=
ace nice -20(high) to 19(low)
>

Ingo,
I want to  change some descriptions according to below discussion.

before) * Kernel Space priority 0(high) to 99(low)   --> User Space RT
priority 99(high) to 1(low)
after)    *  Kernel Space priority 0(high) to 98(low)   --> User Space
RT priority 99(high) to 1(low)

I want to your advice and opinion about this changes.

If I mistook, Please correct me.

thks.



Steven Rostedt:
  Shouldn't that be:
  Kernel priority: 0(high) to 98(low)    =3D=3D> user RT priority 99(hi=
gh) to 1(low)

GeunSik Lim :
  Thank you for your opinion.  I think about corrected expression for
  quick chart to map between kernel space and user space in ftrace .

Steven Rostedt:
 100 items does not map to 99. Which begs the question, what can have
 internal kernel priority 99?

GeunSik Lim :
  ok.  Below example is about  kernel (static) priority 99 that you sai=
d.
  please, refer
  to http://www.kernel.org/doc/man-pages/online/pages/man2/sched_setsch=
eduler.2.html
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


>
> =C2=A0 =C2=A0Processes scheduled with SCHED_OTHER or SCHED_BATCH must=
 be assigned
> =C2=A0 =C2=A0the static priority 0. Processes scheduled under SCHED_F=
IFO or SCHED_RR
> =C2=A0 =C2=A0can have a static priority in the range 1 to 99.
> =C2=A0 =C2=A0(reference: $> man 2 sched_setscheduler)
>
> =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
>
> diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentati=
on/scheduler/sched-rt-group.txt
> index 5ba4d3f..1537146 100644
> --- a/Documentation/scheduler/sched-rt-group.txt
> +++ b/Documentation/scheduler/sched-rt-group.txt
> @@ -169,7 +169,7 @@ get their allocated time.
>
> =C2=A0Implementing SCHED_EDF might take a while to complete. Priority=
 Inheritance is
> =C2=A0the biggest challenge as the current linux PI infrastructure is=
 geared towards
> -the limited static priority levels 0-139. With deadline scheduling y=
ou need to
> +the limited static priority levels 0-99. With deadline scheduling yo=
u need to
> =C2=A0do deadline inheritance (since priority is inversely proportion=
al to the
> =C2=A0deadline delta (deadline - now).
>
>
>
>
> -----------------------------------------------
> To unsubscribe from this list: send the line "unsubscribe linux-***"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
> GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
> e-Mail =C2=A0:1) geunsik.lim@samsung.com
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 2) leemgs@gmail.com , leemgs1@gmail.com
> HomePage: http://intomail.dnip.net/invain/me/
> -----------------------------------------------
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
