From: Sashka <sashka@mail.ru>
Subject: Re: rt for newbie
Date: Fri, 28 Oct 2011 09:29:43 -0400
Message-ID: <CADZpk3s-4kGZL01C+aYgqKnv09-YFS+Lo76Te2E_mT6A_gK_qg@mail.gmail.com>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com>
 <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com>
 <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com> <4EA9D980.5080903@osadl.org>
Reply-To: sashka@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp8.mail.ru ([94.100.176.53]:51379 "EHLO smtp8.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369Ab1J1Na1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 09:30:27 -0400
Received: from [209.85.216.181] (port=52650 helo=mail-qy0-f181.google.com)
	by smtp8.mail.ru with asmtp
	id 1RJmVt-0004mG-00
	for linux-rt-users@vger.kernel.org; Fri, 28 Oct 2011 17:30:25 +0400
Received: by qyk27 with SMTP id 27so4503223qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Oct 2011 06:30:24 -0700 (PDT)
In-Reply-To: <4EA9D980.5080903@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Carsten,

 Thank you.
 Did I understand you correctly, I need to disable Dynamic Ticks and
Check for stack overflow?
 If yes, then here are my results

# cyclictest -m -Sp99 -i100 -d0
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.01 0.09 0.05 2/122 2187

T: 0 ( 2180) P:99 I:100 C:1969005 Min:      1 Act:    2 Avg:    1 Max: =
     10
T: 1 ( 2181) P:99 I:100 C:1968946 Min:      1 Act:    2 Avg:    2 Max: =
     69
T: 2 ( 2182) P:99 I:100 C:1968888 Min:      1 Act:    2 Avg:    2 Max: =
     12
T: 3 ( 2183) P:99 I:100 C:1968829 Min:      1 Act:    2 Avg:    2 Max: =
     52
T: 4 ( 2184) P:99 I:100 C:1968770 Min:      1 Act:    2 Avg:    1 Max: =
     10
T: 5 ( 2185) P:99 I:100 C:1968712 Min:      1 Act:    5 Avg:    2 Max: =
      9
T: 6 ( 2186) P:99 I:100 C:1968654 Min:      1 Act:    2 Avg:    2 Max: =
     55
T: 7 ( 2187) P:99 I:100 C:1968594 Min:      1 Act:    2 Avg:    1 Max: =
     17

CPU I've got is Xeon X5472  @ 3.00GHz

-Sashka


On Thu, Oct 27, 2011 at 6:21 PM, Carsten Emde <Carsten.Emde@osadl.org> =
wrote:
> Sashka,
>
>> [..]
>> I've got it build several time. I'm confused with all those differen=
t
>> guides telling me what to enable and disable. Most of them are
>> outdated, as I can see.
>
> The usual recommendation is:
>
> 1. Get the config of your distro
> # cd /usr/src/kernels/linux-3.0.7-rt20
> # cp /boot/config-`uname -r` .config
>
> 2. Configure the kernel for RT
> # make menuconfig
> Processor type and features =C2=A0--->
> =C2=A0 =C2=A0 =C2=A0[ ] Tickless System (Dynamic Ticks)
> =C2=A0 =C2=A0 =C2=A0Preemption Model (Fully Preemptible Kernel (RT)) =
=C2=A0--->
> Kernel hacking =C2=A0--->
> =C2=A0 =C2=A0 =C2=A0[ ] Check for stack overflows
>
> To check out the new kernel for its RT capabilities:
> # cd /usr/src
> # git clone https://github.com/clrkwllms/rt-tests
> # cd rt-tests
> # make rpm
> # rpm -ivh RPMS/*/rt-tests*.rpm
> # cyclictest -m -Sp99 -i100 -d0
>
> Let us know what worst-case latency you got.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Carsten.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
