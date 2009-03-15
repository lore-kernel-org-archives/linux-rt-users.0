From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: rt application question with rs232 communication
Date: Sun, 15 Mar 2009 03:07:13 +0100
Message-ID: <c384c5ea0903141907o79ccd790h7b48605feaeba107@mail.gmail.com>
References: <f96d234e0903091434xafaedcamc68023ebce5c7799@mail.gmail.com>
	 <f96d234e0903100544p5bc17143l8916aefd49d78562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:41849 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbZCOCHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Mar 2009 22:07:16 -0400
Received: by ewy25 with SMTP id 25so3040756ewy.37
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Mar 2009 19:07:13 -0700 (PDT)
In-Reply-To: <f96d234e0903100544p5bc17143l8916aefd49d78562@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Cliff,

On Tue, Mar 10, 2009 at 1:44 PM, Cliff Brake <cliff.brake@gmail.com> wr=
ote:
> Clarification, I don't have the RT patch applied, just CONFIG_PREEMPT
> from Linus's kernel. =A0Reviewing my notes from several years ago, I =
ran
> into a similar issue and the RT patch fixed it, so now to figure out
> the best way to get a recent RT patched ARM kernel ...
>
>> timing. =A0However, it seems that the system has trouble receiving t=
he
>> response in a timely fashion. =A0I often observe that it takes at le=
ast
>> 10ms for the application to receive the response data after the data
>> has appeared on the rs232 bus. =A0Is the RT patch something that wou=
ld

We are running a real-time RS-485 protocol where the time window is 1
ms and only under heavy load we got deadline misses > 1 ms.
Unfortunately I didn't measure the max latency then, but 10 ms sounds
like excessive latency to me.

Under 2.6.24.7-rt24 (or whatever -rtxy in that series) we have never
missed the 1 ms deadline.

That's on XScale IXP4xx @533 MHz,

Regards,
--=20
Leon
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
