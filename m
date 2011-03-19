From: jordan <triplesquarednine@gmail.com>
Subject: Re: 2.6.33-7-rt30 and 2.6.38 comparison
Date: Sat, 19 Mar 2011 11:28:41 -0400
Message-ID: <AANLkTin+9R05kzUcxkzKYcQOZ4wLVmJG1RVaM4e=5TMu@mail.gmail.com>
References: <76D8B96C9CCF479A864872F2092B0C8F@e1705>
	<SNT110-W3899829B3D225E2BEC8CDDA8B30@phx.gbl>
	<AANLkTim9aK3vPEiVKQVm3tFZufuYUwSe+=qL8xf=gDb8@mail.gmail.com>
	<SNT110-W53D268D6F9CDC81D542667A8B30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45230 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1CSP2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Mar 2011 11:28:43 -0400
Received: by ewy4 with SMTP id 4so1172433ewy.19
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Mar 2011 08:28:42 -0700 (PDT)
In-Reply-To: <SNT110-W53D268D6F9CDC81D542667A8B30@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Victor,

> For sure 23 msec is terrible; I was so surprised to see that!

So was I man :)  On my old Dell inspiron 6400, coreduo with 2.6.37, i
am running quite stable at 2.3ms (as in no xruns, at all).  it's a
semi-slow machine, with 1 sketchy PCI bus, too. It has been recycled
into a rackmount, and has "on/off" operation. It's still good enough
though, to run several VSTi's at once, some effects chains,
sooperlooper and a sampler. I never have problems with it. i use it
live (with my band). RT runs like crap on it, so i used 2.6.37 with
BFS.

I'm very impressed with recent kernels, using a non-RT kernel seems to
not be a problem.
although, most of the time, they do require tweaking.

i won't be excited about RT-kernels, until i see 2.6.38-rt ~ that
should be a good one!

I recycle junk laptops - ie: busted display / keyboard / failed GPU /
etc ~ useless to most people, but they are easily converted into
dedicated music gear. (synth-modules, VSTi hosts, FX rack).
So i am often working with "sub-standard" equipment. surprisingly most
of the time you can tune
them quite well ~ and get very reasonable performance. RT can
misbehave on some gear so i use BFS scheduler in those corner cases. I
mostly will use Zen-kernel (www.zen-kernel.org) as that kernel can be
tuned up very well, and has all of the bellz and whistles.

> Yes Lenovo Thinkpad are famous for having good performance... and furthermore the T410s is "Ubuntu certified". However I experience hang on with the 2.6.33.7.2-rt kernel, but I have a touchscreen (input = 4 fingers multitouch working natively under Maverick... really great) and I suspect the mutitouch screen is responsible of this. Hopefully the performaces og the preempt are great!

I have heard lenovo laptops are quite nice for running linux. :)
...in this case it could be your multi-touch, but it also could be
your video card. . On my one machine if i use a compositor (compiz,
metacity, etc) it randomly will have soft lockups. All of the audio
stuff still will work but the display goes down the drain.  On another
machine, an older version of BFQ ( I/O scheduler ), would potentially
cause lockups. (although i had thought that it was my ATI card) both
of those machines are quite stable now though. :)

jordan
