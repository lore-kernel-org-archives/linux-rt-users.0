From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [Announce] 2.6.29-rt1
Date: Thu, 26 Mar 2009 17:02:49 +0900
Message-ID: <49b7c2350903260102p772b2910xfe245e4b91fe2c0b@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain>
	 <1238015156.2500.83.camel@ht.satnam>
	 <alpine.LFD.2.00.0903252208440.3397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:36166 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbZCZICv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Mar 2009 04:02:51 -0400
In-Reply-To: <alpine.LFD.2.00.0903252208440.3397@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I understood statement that Thosmas explained about invalid access of
2.6.29-rt1 soruces.
In general,
We remeber rc directory (./v2.6/testing/ and release directory
(./v2.6/) certainly.

Release Version is located in http://www.kernel.org/pub/linux/kernel/v2=
=2E6/ site.
RC      Version is located in
http://www.kernel.org/pub/linux/kernel/v2.6/testing/ site.

I summarized quick howto per notice of "2.6.* rt patch" file.
fc9#> wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.tar=
=2Ebz2
  (If linux version is RC[release candidate] version,
 use "wget http://www.kernel.org/pub/linux/kernel/v2.6/testing/***" com=
mand.)
fc9#> wget http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6=
=2E29-rt1.bz2
fc9#> tar xjf ./linux-2.6.29.tar.bz2
fc9#> tar xvjf ./patch-2.6.29-rt1-broken-out.tar.bz2
fc9#> cd ./linux-2.6.29
fc9#> for i in `cat ../patches/series | grep patch | grep -v "#"  `;do
echo "+++ patching $i"; patch -p1 <

=2E./patches/$i;done
fc9#> cp ./arch/x86/configs/i386_defconfig ./.config
fc9#> make menuconfig
        ..... Below Omission .....
  =09

Regards,
GeunSik Lim


2009/3/26 Thomas Gleixner <tglx@linutronix.de>:
> On Thu, 26 Mar 2009, Jaswinder Singh Rajput wrote:
>
>> On Wed, 2009-03-25 at 21:59 +0100, Thomas Gleixner wrote:
>> > We are pleased to announce the next update to our new preempt-rt
>> > series.
>> >
>> > =C2=A0 =C2=A0 =C2=A0- port forward to 2.6.29 final
>> >
>> > Download locations:
>> >
>> > =C2=A0 =C2=A0 http://rt.et.redhat.com/download/
>> > =C2=A0 =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/
>> >
>> > Information on the RT patch can be found at:
>> >
>> > =C2=A0 =C2=A0 http://rt.wiki.kernel.org/index.php/Main_Page
>> >
>> > to build the 2.6.29-rt1 tree, the following patches should be
>> > applied:
>> >
>> > =C2=A0 =C2=A0 http://www.kernel.org/pub/linux/kernel/v2.6/testing/=
linux-2.6.29.tar.bz2
>>
>> Is this valid ?
>
> If we remove the testing/ it should work better :)
>
> =C2=A0 tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
