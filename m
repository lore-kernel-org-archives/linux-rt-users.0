From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Using -rt and TuxOnIce at the same time
Date: Tue, 3 Nov 2009 23:14:10 +0000
Message-ID: <74fd948d0911031514m528c2693g446d9edf863d528@mail.gmail.com>
References: <74fd948d0911030640m11993d57hd634210307a6c623@mail.gmail.com>
	 <1257287971.24428.2.camel@localhost.localdomain>
	 <74fd948d0911031445hc83661u2a0f31c5888d24@mail.gmail.com>
	 <1257289019.24428.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Ng Oon-Ee <ngoonee@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:41139 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZKCXOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2009 18:14:07 -0500
Received: by ewy3 with SMTP id 3so2547690ewy.37
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2009 15:14:11 -0800 (PST)
In-Reply-To: <1257289019.24428.7.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/11/3 Ng Oon-Ee <ngoonee@gmail.com>:
> Please bottom-post when posting to a ML. Fixed your mail for this.
>
> On Tue, 2009-11-03 at 22:45 +0000, Pedro Ribeiro wrote:
>> 2009/11/3 Ng Oon-Ee <ngoonee@gmail.com>:
>> > On Tue, 2009-11-03 at 14:40 +0000, Pedro Ribeiro wrote:
>> >> Hello all,
>> >>
>> >> I'm interested in using both the -rt patchset and the TuxOnIce fo=
r hibernation.
>> >> If you're not aware, TuxOnIce is a patch to enable "proper"
>> >> hibernation in Linux, IMO much superior to the one provided by th=
e
>> >> base kernel.
>> >>
>> >> Anyway, there is a collision in fork.c which is easily solvable, =
but
>> >> apart from that the patches don't collide. However, when I try to
>> >> hibernate the computer just hangs up. I brought this up on the
>> >> TuxOnIce mailing list and the main developer told me to contact y=
ou
>> >> first. He also told me that we would like to work with you to sol=
ve
>> >> this problem, since TOX is also =A0going to be slowly integrated =
in the
>> >> mainline kernel over time.
>> >>
>> >> The problem is that the computer hangs and I have no way to captu=
re
>> >> the output. The only thing I could do was to take some photos of =
the
>> >> screen. The first photo is what appears immediately after the
>> >> beggining of the hibernation process. After a few seconds, a rapi=
d
>> >> succession of text appears and it captured partially on the secon=
d
>> >> (crappy) photo of the screen. On the 3rd photo shows how the syst=
em
>> >> stays indefinitely, and must be restarted by pressing the power b=
utton
>> >> for 3 secs.
>> >>
>> >> I know the material I provided is a bit crap, but please let me k=
now
>> >> how can I help you.
>> >>
>> >> The zipped file containing the photos is here
>> >> http://www.2shared.com/file/8900964/61ee7898/rt-crashtar.html
>> >>
>> >> Thanks in advance,
>> >> Pedro Ribeiro
>> >
>> > Hi, I do have RT and ToI working together on Arch Linux here. Do y=
ou by
>> > any chance use an nVidia card? Your issue sounds like an issue wit=
h
>> > hibernating with stock nVidia drivers without the ToI workarounds.=
=2E. You
>> > need to add "procsetting extra_pages_allowance 7500" to common.con=
f or
>> > something like that.
>> >
>> > I know I did a single successful hibernate and restart with my RT =
and
>> > ToI hybrid (am currently using BFS/ToI for daily use) for testing
>> > purposes, so it does work, for me at least.
>> Hi,
>> are you using the 31.4-rt14 kernel? Because I had it working before
>> with the 29.4-rt22!
>>
>> To answer your question, I have a Intel X4500 integrated video card.=
=2E.
>> so no nVidia drivers here.
>>
>> Pedro
>
> I'm using 2.6.31.4-rt14. I would still look at your graphics card for
> issues, honestly. Have you tried a 'dry-run' hibernate, or are you ju=
st
> doing a 'force' from the gnome menus?
>
> In any case, this is (probably) not rt-related, so unless you know th=
at
> having a ToI only kernel works and the only difference is RT (you may
> have tested this already, you haven't specifically mentioned it thoug=
h)
> it doesn't yet belong on this ML.
>
>

Yes the ToI works by itself, but the graphics card does have some
issues when restoring - X doesn't restore correctly, I have to change
to a VT and back to X after resume for it to restore properly - but
apart from this the hibernate/resume cycle is fine with ToI alone.

Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
