From: Mark Knecht <markknecht@gmail.com>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 07:43:14 -0800
Message-ID: <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
References: <hcs6dr$235$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:56434 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbZKDPnK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 10:43:10 -0500
Received: by pxi9 with SMTP id 9so4691011pxi.4
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2009 07:43:15 -0800 (PST)
In-Reply-To: <hcs6dr$235$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 4, 2009 at 7:25 AM, Tim Blechmann <tim@klingt.org> wrote:
> hi all,
>
> having read the howto build an rt-application, i am trying to think o=
f a
> way to handle disk i/o in my application.
>
> the howto suggest to avoid file i/o in non-rt helper threads, but to
> move them to another process. while the howto suggests using network
> socket, i'm curious, if other ipc primitives like shared memory would
> give better throughput? or would i experience any issues, like is it
> possible to lock shared memory to physical ram?
>
> thanks, tim
>
> --
> tim@klingt.org
> http://tim.klingt.org
>
> Art is either a complaint or do something else
> =C2=A0John Cage quoting Jasper Johns
>

Tim,
   I'm not a developer and cannot really address your specific
question but for my use of the rt-kernel I put important rt-audio
files on a 1394 drive and give the 1394 driver higher priorities using
the IRQ scheduling tools. I don't have any trouble running 2 or 3 1394
drives recording and playing back 48 channels in Ardour.

   While I agree you should do everything the right way technically in
the code maybe part of your solution is outside of the app you are
writing and in the use of these support tools?

Take care,
Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
