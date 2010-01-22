From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Best gcc flags?
Date: Fri, 22 Jan 2010 14:58:52 -0800
Message-ID: <5bdc1c8b1001221458j74d36fdbl3f154f8b539791dd@mail.gmail.com>
References: <5bdc1c8b1001221054g406baa9cp226a478be7342c0e@mail.gmail.com>
	 <520f0cf11001221409t2eda34e6kae393afde012d6fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:59579 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0AVW6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2010 17:58:53 -0500
Received: by pzk28 with SMTP id 28so424636pzk.4
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2010 14:58:52 -0800 (PST)
In-Reply-To: <520f0cf11001221409t2eda34e6kae393afde012d6fc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 22, 2010 at 2:09 PM, John Kacur <jkacur@redhat.com> wrote:
> On Fri, Jan 22, 2010 at 7:54 PM, Mark Knecht <markknecht@gmail.com> w=
rote:
>> Hi,
>> =C2=A0 I've got a new Intel Core i5-661 machine that I'm loading Gen=
too
>> on. I wonder if anyone here has any strong opinion son the best gcc
>> options for this sort of machine and specifically what makes for the
>> best rt performance?
>>
>
> AFAIK, there are no -rt specific requirements for gcc, just use what =
you
> would normally use.
>
> John
>

Yes that's my understanding also, but this is a brand new machine to
me, Gentoo based where I can set all my gcc flags pretty easily, and
for the Core i5-661 I'm not finding much info on what's recommended
for gcc. -march=3Dnative? Or maybe use specific settings such as those
for an i7?

I'm just grasping around for ideas mostly.

Thanks!

- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
