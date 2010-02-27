From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rt3
Date: Sat, 27 Feb 2010 19:10:09 +0900
Message-ID: <49b7c2351002270210m6a1d2534qa64aaeaba7a61b92@mail.gmail.com>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
	 <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
	 <4B88E4F3.4010308@cauwe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>, nando@ccrma.stanford.edu,
	Carsten Emde <ce@ceag.ch>
To: Xavier Miller <xavier.miller@cauwe.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B88E4F3.4010308@cauwe.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> The name is -rt4, not -rt3
> Xavier Miller.
Hi Xavier.
When I checked -rt tag currently, tag name is -rt4 based 2.6.33.
So, I changed -rt tag name to -rt4.
Test result is normal with 2.6.33-rt4 on
my desktop(Q6600, SSD64G, DDR2 2GRAM) at least.  :)

Thanks,

On Sat, Feb 27, 2010 at 6:25 PM, Xavier Miller <xavier.miller@cauwe.org=
> wrote:
> Hello,
>
> The name is -rt4, not -rt3
>
> Xavier Miller.
>
> Le 26/02/10 20:54, Thomas Gleixner a =C3=A9crit :
>> We are pleased to announce the next update to our new preempt-rt
>> series.
>>
>> =C2=A0 =C2=A0 - Update to 2.6.33
>>
>> =C2=A0 =C2=A0 - rt fixes:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Peter Zijlstr=
a (1):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0highmem, -rt: Implem=
ent pfn and prot kmaps
>>
>> =C2=A0 =C2=A0 =C2=A0 Thomas Gleixner (2):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0x86: pci: Prevent mmconfig memory corruption
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mmc: omap_hsmmc: Fix the locking mess
>>
>> A note on the development process:
>>
>> =C2=A0 The rt/2.6.33 branch is now stabilization only. The rt/head b=
ranch
>> =C2=A0 will follow linus tree from now on, so it will inherit all
>> =C2=A0 (mis)features which come in the merge window.
>>
>> Download locations:
>>
>> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/projects/rt/
>>
>> Git development branch:
>> =C2=A0 =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux=
-2.6-tip.git rt/head
>>
>> Git release branch:
>> =C2=A0 =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux=
-2.6-tip.git rt/2.6.33
>>
>> Gitweb:
>> =C2=A0 =C2=A0http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2=
=2E6-tip.git;a=3Dshortlog;h=3Drt/2.6.33
>>
>> Information on the RT patch can be found at:
>>
>> =C2=A0 =C2=A0http://rt.wiki.kernel.org/index.php/Main_Page
>>
>> To build the 2.6.33-rt3 tree, the following patches should be
>> applied:
>>
>> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.3=
3.tar.bz2
>> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/projects/rt/patc=
h-2.6.33-rt3.bz2
>>
>> Enjoy !
>>
>> =C2=A0 =C2=A0 =C2=A0 tglx
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
