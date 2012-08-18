From: Javier Sanz <jsanza@gmail.com>
Subject: Re: linux rt 3.4.8-rt16 and nv 302.17, and system freezes, does
 nvidia strike again?
Date: Sat, 18 Aug 2012 11:52:06 +0200
Message-ID: <CAOLSsAwG-KNdOwWxGSQmRA8mrA+mTvCgDLS4oneYOsguk8mzDQ@mail.gmail.com>
References: <CAOLSsAw3QG40xSokZ8spMa1_J81n2L9fb2g68jEo-r0iCMP8gA@mail.gmail.com>
	<1345264436.8439.15.camel@marge.simpson.net>
	<20120818070110.GA26476@dlc-dt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "David L. Craig" <dlc@radix.net>, Mike Galbraith <efault@gmx.de>,
	Javier Sanz <jsanza@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60796 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2HRJwI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Aug 2012 05:52:08 -0400
Received: by eeil10 with SMTP id l10so1343107eei.19
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Aug 2012 02:52:07 -0700 (PDT)
In-Reply-To: <20120818070110.GA26476@dlc-dt.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yes, i got the same problem, black screen, no mouse, no keyboard ...
i didnt  change any config file from X or nvidia ... only rt patch
applied  ...  :(
I'll try with nvidia 304.37 ... no patch required ? ... i'll test ...

thank you


2012/8/18 David L. Craig <dlc.usa@gmail.com>:
> On 12Aug18:0633+0200, Mike Galbraith wrote:
>
>> On Fri, 2012-08-17 at 22:40 +0200, Javier Sanz wrote:
>> >
>> > Sorry about nvidia drivers issue, but nobody help me from another forums ...
>> >
>> > I can't boot linux rt 3.4.8-rt16 with nvidia 302.17 patched for 3.x-rt
>> > series using the famous  "patch-3.0-rt-nvidia.patch"
>> >
>> > My Fedora 17 starts ok,  services ok, but into loading nvidia driver,
>> > it freezes ...  no text mode, no keyboard .. all locked !
>> >
>> > I guess some one has it working ... can you help me? which patch did
>> > you use?  how do you do it?  where can i find it ?
>> >
>> > I'll try with lastest 3.4.9-rt17  and  nvidia 304.37 with the same patch ..
>>
>> I just built 3.4.9-rt17 with nvidia 304.37.  For my 8600 GT card at
>> least, no patch is required, it builds and runs just fine as is.
>
> Is this bug report similar to what you're experiencing?
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=684952
> --
> May the LORD God bless you exceedingly abundantly!
>
> Dave_Craig______________________________________________
> "So the universe is not quite as you thought it was.
>  You'd better rearrange your beliefs, then.
>  Because you certainly can't rearrange the universe."
> __--from_Nightfall_by_Asimov/Silverberg_________________
