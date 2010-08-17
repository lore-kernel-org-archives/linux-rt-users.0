From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 11:24:13 -0700
Message-ID: <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
	<AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
	<4C6AC4A6.4080407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40323 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411Ab0HQSYS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 14:24:18 -0400
Received: by ewy23 with SMTP id 23so3235553ewy.19
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 11:24:17 -0700 (PDT)
In-Reply-To: <4C6AC4A6.4080407@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 17, 2010 at 10:19 AM, David Sommerseth <davids@redhat.com> =
wrote:
> On 17/08/10 08:07, Manikandan Ramachandran wrote:
>> :
>>>
>>> Hello All,
>>>
>>> =A0 =A0 I created a very simple program which has higher priority t=
han normal tasks and runs a tight loop. Under same test environment I r=
an this program on both non-rt and rt 2.6.33.5 kernel. =A0To my suprise=
 I see that performance of non-RT kernel is better than RT. non-RT kern=
el took 3 sec and 366156 usec while RT kernel took about 3 sec and 4180=
11 usec.Can someone please explain why the performance of non-rt kernel=
 is better than rt kernel? From the face of the test result, I feel RT =
has more overhead,Is there any configuration that I could do to bring d=
own the overhead?
>>>
>>> Processor:
>>> ----------------
>>> processor =A0 =A0 =A0 : 0
>>> cpu =A0 =A0 =A0 =A0 =A0 =A0 : 7448
>>> clock =A0 =A0 =A0 =A0 =A0 : 996.000000MHz
>>> revision =A0 =A0 =A0 =A0: 2.2 (pvr 8004 0202)
>>> bogomips =A0 =A0 =A0 =A0: 83.10
>>> processor =A0 =A0 =A0 : 1
>>> cpu =A0 =A0 =A0 =A0 =A0 =A0 : 7448
>>> clock =A0 =A0 =A0 =A0 =A0 : 996.000000MHz
>>> revision =A0 =A0 =A0 =A0: 2.2 (pvr 8004 0202)
>>> bogomips =A0 =A0 =A0 =A0: 83.10
>>>
>>> CFS optimization:
>>> --------------------------
>>> # cat /proc/sys/kernel/sched_rt_runtime_us
>>> 1000000
>>> # cat /proc/sys/kernel/sched_rt_period_us
>>> 1000000
>>> # cat /proc/sys/kernel/sched_compat_yield
>>> 1
>>>
>>> Test Program:
>>> ---------------------
>>>
>>> main()
>>> {
>>>
>>> =A0 =A0 int sched_rr_min,sched_rr_max;
>>> =A0 =A0 struct sched_param scheduling_parameters;
>>> =A0 =A0 struct timeval tv,late_tv;
>>> =A0 =A0 suseconds_t usec_diff,avg_usec =3D 0;
>>> =A0 =A0 time_t sec_diff, avg_sec =3D 0;
>>> =A0 =A0 int i;
>>> =A0 =A0 long count =3D 1;
>>>
>>> =A0 =A0 sched_rr_min =3D sched_get_priority_min(SCHED_RR);
>>> =A0 =A0 sched_rr_max =3D sched_get_priority_max(SCHED_RR);
>>> =A0 =A0 scheduling_parameters.sched_priority =3D sched_rr_min+4;
>>> =A0 =A0 sched_setscheduler(0, SCHED_RR, &scheduling_parameters);// =
Run the process with the given priority
>>>
>>> =A0 =A0 for(i =3D 0 ; i < 150 ; i++) {
>>> =A0 =A0 =A0 =A0gettimeofday(&tv, NULL);
>>> =A0 =A0 =A0 =A0while(count > 0){
>>> =A0 =A0 =A0 =A0 //printf(".");
>>> =A0 =A0 =A0 =A0 count++;
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0gettimeofday(&late_tv, NULL);
>>> =A0 =A0 =A0 =A0count =3D 1;
>>> =A0 =A0 =A0 =A0sec_diff =3D (late_tv.tv_sec - tv.tv_sec);
>>> =A0 =A0 =A0 =A0avg_sec +=3D sec_diff;
>>> =A0 =A0 =A0 =A0usec_diff =3D ( (late_tv.tv_usec > tv.tv_usec) ? (la=
te_tv.tv_usec - tv.tv_usec) : ( tv.tv_usec - late_tv.tv_usec));
>>> =A0 =A0 =A0 =A0avg_usec +=3D usec_diff;
>>> =A0 =A0 =A0 =A0printf("Iteration #%d sec %x usec %x\n",i,(sec_diff)=
,(usec_diff));
>>> =A0 =A0 }
>>> =A0 =A0 =A0 =A0printf("Average of #%d sec %x usec %x\n",i,(avg_sec/=
i),(avg_usec)/i);
>>> }
>
> It seems to me that this test program only tries to measure speed, wh=
ich
> is not something RT kernels will not give you. =A0As Mark Knecht corr=
ectly
> pointed out, RT kernels care about latency. =A0Non-RT kernels are
> sometimes referred to as Real-Fast kernels.
>
> Your program will run before all SCHED_OTHER programs. =A0But again, =
all
> SCHED_FIFO/SCHED_RR tasks which got a higher priority (like many kern=
el
> threads), will preempt your program, which slows it down. =A0Having t=
hat
> said, this do not mean that running your program with priority 99 is =
a
> clever thing, in fact, that can block the kernel to really do more
> needed stuff, like to take care of I/O traffic, etc, etc.
>
> But to really measure what the RT kernel can give you, try to run
> cyclictest in the rt-tests tree [1]. =A0That program will measure you=
r
> system latency. =A0Btw. to really get a good overview over you latenc=
y,
> run it over a longer time (>several hours).
>
> You can also have peek at a tool call rteval [2] which will run
> cyclictest together with some loads and summarise the performance for
> you. =A0During an rteval run, your box will be heavy loaded - but if =
you
> get max latencies < 100us after some hours of test run, consider that
> pretty good results.
>
> In general, don't use RT if you want to do things quick. =A0RT will b=
e
> slower than non-RT kernels. =A0Try building a kernel on a non-RT kern=
el
> and then on a RT kernel, and you'll feel it very well.
>
> But if you care about latency (a program which needs to react within =
a
> certain time scope after it received some work to do), then the RT
> kernel will serve you better.
>
>
> kind regards,
>
> David Sommerseth
>
>
> [1]
> <http://git.kernel.org/?p=3Dlinux/kernel/git/clrkwllms/rt-tests.git;a=
=3Dsummary>
> [2]
> <http://git.kernel.org/?p=3Dlinux/kernel/git/clrkwllms/rteval.git;a=3D=
summary>
>

Thanks David & Mark for your valuable input!

I'm not expecting RT kernel to be real fast. However I expect latency
of higher priority task to be less in RT kernel. I'll run the tests
that you have suggested and see if there is any inherent issue with my
system.

One more query, with RT patch is it possible for higher priority task
to preempt a lower priority IRQ thread [For eg, IDE] ? If so when does
that happen, during next timer interrupt [Assuming IRQ thread uses
whole schedule slot and doesn't yield between]?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
