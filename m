From: Jens M Andreasen <jens.andreasen@comhem.se>
Subject: Re: [LAD] [Fwd: Re: realtime kernel for Debian]
Date: Thu, 26 Mar 2009 19:34:30 +0100
Message-ID: <1238092470.6651.21.camel@c80-216-254-250.bredband.comhem.se>
References: <49C8FF4D.1040204@gmail.com> <49CA0982.5090404@gmail.com>
	 <49CA976C.4070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: pkg-multimedia-maintainers@lists.alioth.debian.org,
	linux-audio-user <linux-audio-user@lists.linuxaudio.org>,
	linux-rt-users@vger.kernel.org, 64studio-devel@lists.64studio.com,
	Musix GNU+Linux users list <musix-users@lists.ourproject.org>,
	Ubuntu Studio Development & Technical Discussion
	<ubuntu-studio-devel@lists.ubuntu.com>,
	Linux-audio-dev@lists.linuxaudio.org
To: Grammostola Rosea <rosea.grammostola@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54600 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754200AbZCZSgH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Mar 2009 14:36:07 -0400
In-Reply-To: <49CA976C.4070004@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29-rt1.bz2

... is out :)

/j


On Wed, 2009-03-25 at 21:43 +0100, Grammostola Rosea wrote:
> Hi,
> 
> Sorry, but I've to call again...
> 
> The developers seems very willing to include a realtime kernel there 
> repo. They need some people who wants to build and maintain it. This is 
> really  a chance  for  linux audio, especially on Debian.  *This is the 
> moment!*
> 
> So please consider to offer your help in building, maintaining  and/or 
> testing!
> 
> Thanks in advance,
> 
> \r
> 
> 
> 
> 
> 
> Grammostola Rosea wrote:
> > Grammostola Rosea wrote:
> >> Hi,
> >>
> >> There is an promising discussion on the debian-dev mailinglist. Maybe 
> >> some people who knows more about realtime kernels could join. Also 
> >> users who might want to have an realtime kernel in Debian and/or want 
> >> help testing could join the discussion. I think it would be nice if 
> >> there is also an realtime kernel in Debian or that the default kernel 
> >> would be improved for realtime (audio) usage.
> >>
> >>
> >> http://www.debian.org/MailingLists/subscribe
> > Here is the thread about a realtime kernel in Debian:
> >
> >
> > http://www.linux-archive.org/debian-development/268999-realtime-kernel-debian.html 
> >
> >
> >
> > Kind regards,
> >
> > \r
> >
> >
> >
> >
> >>
> >> \r
> >>
> >> ------------------------------------------------------------------------
> >>
> >> Subject:
> >> Re: realtime kernel for Debian
> >> From:
> >> "Giacomo A. Catenazzi" <cate@debian.org>
> >> Date:
> >> Tue, 24 Mar 2009 13:26:35 +0100
> >> To:
> >> debian-devel@lists.debian.org
> >>
> >> To:
> >> debian-devel@lists.debian.org
> >>
> >>
> >> Raphael Hertzog wrote:
> >>> On Tue, 24 Mar 2009, Giacomo A. Catenazzi wrote:
> >>>> Do you really need real time kernel?
> >>>> Debian is a technical driven project, but reading the previous two 
> >>>> quotes,
> >>>> "real time" is used as marketing thing.
> >>>
> >>> It's good to question the use of any feature, but a real-time kernel is
> >>> certainly very useful in many industrial applications and Debian is
> >>> popular in that field. (Don't put a marketing label on anything where
> >>> you are not yourself sure of your expertise.)
> >>
> >> Yes, I didn't write very well my sentence: the previous quotes was more
> >> about "there exist rt kernels", "ubuntu has a rt kernel", but not solid
> >> requirements. I had to write some "seems", and I'm sorry for the two
> >> quoted people if it seems an attack.
> >> Anyway, later in the mail, I asked for precise needs, so we could see
> >> better what we should improve.
> >>
> >> IMHO most users want a low latency kernel, but not a slower kernel, so
> >> a CONFIG_HZ_1000 would be nice.  But the original post was about
> >> multimedia production (and not reproduction), so the needs are probably
> >> other.
> >>
> >> My point was more:
> >> - Debian has not rt kernel. Why? Non DD interested or/and low demand?
> >>   This is an important point. We must not produce a rt-kernel if
> >>   we cannot provide testers and developers (in unstable).
> >> - kernel management is a weak point in distribution: no good method
> >>   for kernel dependencies, using full capabilities, ...
> >>
> >> so IMHO we should try harder with the normal kernel, so that we
> >> can use the same infrastructure and testers. If we fail and we
> >> are able to support rt kernels, IMO it is good to provide it in Debian.
> >>
> >> The original mail was about "multimedia production" and few year ago 
> >> kernel
> >> developers had a lot of interaction with music industries.
> >> I'm not an expert in the field, but how far are we in their need with
> >> standard kernels?)
> >>
> >>
> >>> I do use a real-time kernel on a Debian based system for one of my
> >>> customers (but I have to recompile the kernel anyway because I do other
> >>> customizations) and I have good reasons to do so because I can't suffer
> >>> serial overrun and I must ensure that the serial interrupt handler
> >>> is run in the required time and that no other (kernel) task has higher
> >>> priority.
> >>
> >> These *other customizations* are important to rt-kernel. So we need
> >> a person (or more) that know the needs and could support us.
> >> "realtime" alone is only a label ;-)
> >>
> >> ciao
> >>     cate
> >>
> >>
> >
> >
> 
> _______________________________________________
> Linux-audio-dev mailing list
> Linux-audio-dev@lists.linuxaudio.org
> http://lists.linuxaudio.org/mailman/listinfo/linux-audio-dev

