From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: Using -rt and TuxOnIce at the same time
Date: Wed, 04 Nov 2009 07:32:00 +0800
Message-ID: <1257291120.20089.1.camel@localhost.localdomain>
References: <74fd948d0911030640m11993d57hd634210307a6c623@mail.gmail.com>
	 <1257287971.24428.2.camel@localhost.localdomain>
	 <74fd948d0911031445hc83661u2a0f31c5888d24@mail.gmail.com>
	 <1257289019.24428.7.camel@localhost.localdomain>
	 <74fd948d0911031514m528c2693g446d9edf863d528@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-9"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:55206 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZKCXaZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2009 18:30:25 -0500
Received: by ywh40 with SMTP id 40so5886070ywh.33
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2009 15:30:31 -0800 (PST)
In-Reply-To: <74fd948d0911031514m528c2693g446d9edf863d528@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-11-03 at 23:14 +0000, Pedro Ribeiro wrote:
> 2009/11/3 Ng Oon-Ee <ngoonee@gmail.com>:
> > Please bottom-post when posting to a ML. Fixed your mail for this.
> >
> > On Tue, 2009-11-03 at 22:45 +0000, Pedro Ribeiro wrote:
> >> 2009/11/3 Ng Oon-Ee <ngoonee@gmail.com>:
> >> > On Tue, 2009-11-03 at 14:40 +0000, Pedro Ribeiro wrote:
> >> >> Hello all,
> >> >>
> >> >> I'm interested in using both the -rt patchset and the TuxOnIce for hibernation.
> >> >> If you're not aware, TuxOnIce is a patch to enable "proper"
> >> >> hibernation in Linux, IMO much superior to the one provided by the
> >> >> base kernel.
> >> >>
> >> >> Anyway, there is a collision in fork.c which is easily solvable, but
> >> >> apart from that the patches don't collide. However, when I try to
> >> >> hibernate the computer just hangs up. I brought this up on the
> >> >> TuxOnIce mailing list and the main developer told me to contact you
> >> >> first. He also told me that we would like to work with you to solve
> >> >> this problem, since TOX is also  going to be slowly integrated in the
> >> >> mainline kernel over time.
> >> >>
> >> >> The problem is that the computer hangs and I have no way to capture
> >> >> the output. The only thing I could do was to take some photos of the
> >> >> screen. The first photo is what appears immediately after the
> >> >> beggining of the hibernation process. After a few seconds, a rapid
> >> >> succession of text appears and it captured partially on the second
> >> >> (crappy) photo of the screen. On the 3rd photo shows how the system
> >> >> stays indefinitely, and must be restarted by pressing the power button
> >> >> for 3 secs.
> >> >>
> >> >> I know the material I provided is a bit crap, but please let me know
> >> >> how can I help you.
> >> >>
> >> >> The zipped file containing the photos is here
> >> >> http://www.2shared.com/file/8900964/61ee7898/rt-crashtar.html
> >> >>
> >> >> Thanks in advance,
> >> >> Pedro Ribeiro
> >> >
> >> > Hi, I do have RT and ToI working together on Arch Linux here. Do you by
> >> > any chance use an nVidia card? Your issue sounds like an issue with
> >> > hibernating with stock nVidia drivers without the ToI workarounds... You
> >> > need to add "procsetting extra_pages_allowance 7500" to common.conf or
> >> > something like that.
> >> >
> >> > I know I did a single successful hibernate and restart with my RT and
> >> > ToI hybrid (am currently using BFS/ToI for daily use) for testing
> >> > purposes, so it does work, for me at least.
> >> Hi,
> >> are you using the 31.4-rt14 kernel? Because I had it working before
> >> with the 29.4-rt22!
> >>
> >> To answer your question, I have a Intel X4500 integrated video card...
> >> so no nVidia drivers here.
> >>
> >> Pedro
> >
> > I'm using 2.6.31.4-rt14. I would still look at your graphics card for
> > issues, honestly. Have you tried a 'dry-run' hibernate, or are you just
> > doing a 'force' from the gnome menus?
> >
> > In any case, this is (probably) not rt-related, so unless you know that
> > having a ToI only kernel works and the only difference is RT (you may
> > have tested this already, you haven't specifically mentioned it though)
> > it doesn't yet belong on this ML.
> >
> >
> 
> Yes the ToI works by itself, but the graphics card does have some
> issues when restoring - X doesn't restore correctly, I have to change
> to a VT and back to X after resume for it to restore properly - but
> apart from this the hibernate/resume cycle is fine with ToI alone.
> 
> Pedro

I see. That should not be happening, may I suggest that you try to get
to the bottom of that issue first? On my (nvidia) system it just resumes
directly to my working environment, with compiz and all.

Again, considering resuming is in the realms of ToI's influence, you
won't be getting much help here I believe.

