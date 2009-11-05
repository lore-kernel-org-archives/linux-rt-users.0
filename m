From: Mark Knecht <markknecht@gmail.com>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 20:14:36 -0800
Message-ID: <5bdc1c8b0911042014s3abb39c9p74f3d0c1fb13b599@mail.gmail.com>
References: <hcs6dr$235$1@ger.gmane.org>
	 <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
	 <4AF1A327.3040103@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:39931 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZKEEOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 23:14:31 -0500
Received: by pzk26 with SMTP id 26so5182288pzk.4
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2009 20:14:36 -0800 (PST)
In-Reply-To: <4AF1A327.3040103@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 4, 2009 at 7:52 AM, Tim Blechmann <tim@klingt.org> wrote:
>> =C2=A0 =C2=A0I'm not a developer and cannot really address your spec=
ific
>> question but for my use of the rt-kernel I put important rt-audio
>> files on a 1394 drive and give the 1394 driver higher priorities usi=
ng
>> the IRQ scheduling tools. I don't have any trouble running 2 or 3 13=
94
>> drives recording and playing back 48 channels in Ardour.
>>
>> =C2=A0 =C2=A0While I agree you should do everything the right way te=
chnically in
>> the code maybe part of your solution is outside of the app you are
>> writing and in the use of these support tools?
>
> well, if i understand the rt howto correctly, _no_ disc access is
> allowed, neither from rt nor from non-rt threads, since it may produc=
e
> page faults, which introduce latencies ...
> according to this definition, ardour is not an rt-safe application ..=
=2E
> as for rt-safety, i prefer analyzing the latency hotspots instead of
> relying on test results
>
> tim
>
> --
> tim@klingt.org
> http://tim.klingt.org
>
> Avoid the world, it's just a lot of dust and drag and means nothing i=
n
> the end.
> =C2=A0Jack Kerouac

In the limit you may be right. Possibly unbounded disk IO would never
be real-time safe. However in practice I see xruns when I use normal
priorities and none when I give my 1394 driver higher priorities.

Logically it doesn't make sense to me that *no* disk access is
allowed. I think the rt-threads just do their work and the drives
catch up when they can. Apps like Ardour are reading and writing the
hard drive all the time. Lots of files are open and streaming, in my
case maybe 40 files running for hours.

I think that disk access in an rt-thread make no sense at it cannot
response real-time, but non-rt disk activity just gets interrupted
like any other non-rt process, right?

Good luck with what you are up to.

Cheers,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
