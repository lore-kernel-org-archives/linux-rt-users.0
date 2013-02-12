From: =?iso-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Tue, 12 Feb 2013 13:53:12 +0100
Message-ID: <7E3E5777-3AD4-4A87-B27D-6B3D152DE296@bj-ig.de>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de> <CADkTA4MNMCm-6T7rN+9-kujpO4hUmXJmR7hTOkVy2y4xGWX5BQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpgate.bj-ig.de ([194.127.182.6]:55367 "EHLO smtp.bj-ig.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933099Ab3BLMxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2013 07:53:25 -0500
In-Reply-To: <CADkTA4MNMCm-6T7rN+9-kujpO4hUmXJmR7hTOkVy2y4xGWX5BQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Am 11.02.2013 um 18:08 schrieb Bruce Ashfield:

> On Mon, Feb 11, 2013 at 10:54 AM, Ralf M=FCller <ralf@bj-ig.de> wrote=
:
>>=20
>> I've got a problem with a box at a customer, where about once a day =
(overall 20 events in 16 days) a realtime thread blocks for 3 to 4.5 se=
conds. ... It basically is a loop that wakes up every milli second ... =
It does this quite well - except for these random multi second sleeps.
>=20
> Since you mentioned BIOS, I assume that you are running on a x86 plat=
form.

It's x86 - yes.

> I noted that you didn't mention if SMIs have been ruled out as a caus=
e of the
> latency issues. You've probably already ruled this out, but I figured=
 I'd ask
> anyway :)

The question is a good one. What I read about SMI when I started this p=
roject, said that expected latencies from SMI would be something from s=
ome micro- to a maximum of some milliseconds. As my latency constraints=
 are relatively weak - I can perfectly live with 50 microseconds and I =
would not be happy, but could at least deal with 10 milliseconds every =
now and then - I did not follow that trail very far. When SMI can reall=
y create 3 to 4 seconds blocks I will have to look into that deeper ...=
 anyway - I will have a look at SMI the next days. Thanks a lot for tha=
t hint.

BTW: Are there any links to SMI events in a multi second range? What in=
 a system is done within such a long time span?=20

Best regards
Ralf

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
