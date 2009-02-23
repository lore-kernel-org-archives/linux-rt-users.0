From: Dan <danstowell+rt@gmail.com>
Subject: Re: Arm me with info - root != real-time
Date: Mon, 23 Feb 2009 22:41:53 +0000
Message-ID: <286e6b7c0902231441v1edc44cfj22014309216cba03@mail.gmail.com>
References: <5bdc1c8b0902231429r320efb5by507f3cb26c2d5162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14913 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZBWWl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 17:41:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so22767fgg.17
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 14:41:53 -0800 (PST)
In-Reply-To: <5bdc1c8b0902231429r320efb5by507f3cb26c2d5162@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Well from what I read ( http://tapas.affenbande.org/wordpress/ ), an
important advantage of -rt is that you can choose the priorities of
all your threads including IRQs (e.g. to make sure the audio doesn't
glitch when interrupts come in), which you can't do even as root on a
normal kernel.

Dan


2009/2/23 Mark Knecht <markknecht@gmail.com>:
> Hi Ingo, Steven, Thomas and other RT developers,
> =A0As always, thanks for what you do. I've been subscribed here for a
> few years. Don't say much. Do read a lot.
>
> =A0 As a user type I've run the RT kernels for years now. 5 years ago
> it was really crucial for my music work. I still use it faithfully.
> However on many lists now I'm seeing new people say there's no need
> for the RT kernel because they run their applications as root and fee=
l
> they get the 'same' or 'good enough' results. I wonder how they know
> if they don't run both and compare but that's their business. I'm
> suspect but not technically deep enough in this subject to have a
> conversation so I thought I'd ask for a little simple (if possible)
> education.
>
> I PROCLAIM - Running an application as root on the standard kernel is
> not as real time capable as running the same application as a normal
> user with proper priorities & permissions on the RT kernel.
>
> True or false?
>
> =A0 Is there a source of measured data to show this is true or false?
>
> =A0 I know a lot of what you've done over the years is now mainline b=
ut
> I don't know how much of it is turned on by default.
>
> =A0 Clearly, I think folks don't have their head screwed on tight if
> they are running development apps as root, but people are doing it.
> They don't seem to care about security or the obvious fact that
> running as root might allow an app to erase their hard drive, etc.
> Their minds will change when something goes wrong, but in the meantim=
e
> what can I tell them about this subject to get them to use the RT
> kernel and be as happy as I am with it.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
http://www.mcld.co.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
