From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Mon, 16 Aug 2010 23:07:15 -0700
Message-ID: <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36433 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0HQGHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 02:07:16 -0400
Received: by wwf26 with SMTP id 26so531501wwf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 23:07:15 -0700 (PDT)
In-Reply-To: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

:
>
> Hello All,
>
> =A0=A0=A0 I=A0created a very simple program which has higher priority=
 than normal tasks and runs a tight loop. Under same test environment I=
 ran this program=A0on both non-rt and rt=A02.6.33.5 kernel.=A0=A0To my=
 suprise I see that performance of non-RT=A0kernel is better than RT. n=
on-RT=A0kernel took 3 sec and 366156 usec while RT=A0kernel took about =
3 sec and 418011 usec.Can someone please explain why the performance of=
 non-rt kernel is better than rt kernel? From the face of the test resu=
lt, I feel RT has more overhead,Is there=A0any configuration that I cou=
ld do to bring down the overhead?
>
> Processor:
> ----------------
> processor=A0=A0=A0=A0=A0=A0 : 0
> cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 7448
> clock=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 996.000000MHz
> revision=A0=A0=A0=A0=A0=A0=A0 : 2.2 (pvr 8004 0202)
> bogomips=A0=A0=A0=A0=A0=A0=A0 : 83.10
> processor=A0=A0=A0=A0=A0=A0 : 1
> cpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 7448
> clock=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 996.000000MHz
> revision=A0=A0=A0=A0=A0=A0=A0 : 2.2 (pvr 8004 0202)
> bogomips=A0=A0=A0=A0=A0=A0=A0 : 83.10
>
> CFS optimization:
> --------------------------
> # cat /proc/sys/kernel/sched_rt_runtime_us
> 1000000
> # cat /proc/sys/kernel/sched_rt_period_us
> 1000000
> # cat /proc/sys/kernel/sched_compat_yield
> 1
>
> Test Program:
> ---------------------
>
> main()
> {
>
> =A0=A0=A0 int sched_rr_min,sched_rr_max;
> =A0=A0=A0 struct sched_param scheduling_parameters;
> =A0=A0=A0 struct timeval tv,late_tv;
> =A0=A0=A0 suseconds_t usec_diff,avg_usec =3D 0;
> =A0=A0=A0 time_t sec_diff, avg_sec =3D 0;
> =A0=A0=A0 int i;
> =A0=A0=A0 long count =3D 1;
>
> =A0=A0=A0 sched_rr_min =3D sched_get_priority_min(SCHED_RR);
> =A0=A0=A0 sched_rr_max =3D sched_get_priority_max(SCHED_RR);
> =A0=A0=A0 scheduling_parameters.sched_priority =3D sched_rr_min+4;
> =A0=A0=A0 sched_setscheduler(0, SCHED_RR, &scheduling_parameters);// =
Run the process with the given priority
>
> =A0=A0=A0 for(i =3D 0 ; i < 150 ; i++) {
> =A0=A0=A0=A0=A0=A0 gettimeofday(&tv, NULL);
> =A0=A0=A0=A0=A0=A0 while(count > 0){
> =A0=A0=A0=A0=A0=A0=A0 //printf(".");
> =A0=A0=A0=A0=A0=A0=A0 count++;
> =A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0 gettimeofday(&late_tv, NULL);
> =A0=A0=A0=A0=A0=A0 count =3D 1;
> =A0=A0=A0=A0=A0=A0 sec_diff =3D (late_tv.tv_sec - tv.tv_sec);
> =A0=A0=A0=A0=A0=A0 avg_sec +=3D sec_diff;
> =A0=A0=A0=A0=A0=A0 usec_diff =3D ( (late_tv.tv_usec > tv.tv_usec) ? (=
late_tv.tv_usec - tv.tv_usec) : ( tv.tv_usec - late_tv.tv_usec));
> =A0=A0=A0=A0=A0=A0 avg_usec +=3D usec_diff;
> =A0=A0=A0=A0=A0=A0 printf("Iteration #%d sec %x usec %x\n",i,(sec_dif=
f),(usec_diff));
> =A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0 printf("Average of #%d sec %x usec %x\n",i,(avg_se=
c/i),(avg_usec)/i);
> }
>
> Partial Result of non-rt kernel:
> -------------------------------------------
>
> Iteration #140 sec 3 usec 3aef8
> Iteration #141 sec 3 usec 3aefe
> Iteration #142 sec 3 usec 3aee4
> Iteration #143 sec 4 usec b935b=A0 [Why there is this periodic bump ?=
?] [Scheduler at work??]
> Iteration #144 sec 3 usec 3aef2
> Iteration #145 sec 3 usec 3aef0
> Iteration #146 sec 3 usec 3aef4
> Iteration #147 sec 4 usec b934b
> Iteration #148 sec 3 usec 3aeed
> Iteration #149 sec 3 usec 3aef9
>
> Partial Result of rt kernel:
> -------------------------------------------
> Iteration #135 sec 3 usec 47328
> Iteration #136 sec 4 usec ac4fd
> Iteration #137 sec 3 usec 48b0b
> Iteration #138 sec 3 usec 4738c
> Iteration #139 sec 4 usec ac4d5
> Iteration #140 sec 3 usec 483cb
> Iteration #141 sec 3 usec 48500
> Iteration #142 sec 4 usec acc49
> Iteration #143 sec 3 usec 47c1f
> Iteration #144 sec 3 usec 478c2
> Iteration #145 sec 3 usec 47e48
> Iteration #146 sec 4 usec ac9b5
> Iteration #147 sec 3 usec 48de4
> Iteration #148 sec 3 usec 46fbe
> Iteration #149 sec 4 usec ac52e
> Average of #150 sec 3 usec 660db
>
> Thanks,
> Mani
>
>
>
>


--
Thanks,
Manik

Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
