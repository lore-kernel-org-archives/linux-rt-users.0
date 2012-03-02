From: John Kacur <jkacur@redhat.com>
Subject: Re: traceback on 3.2.7-rt13
Date: Fri, 2 Mar 2012 12:29:20 +0100
Message-ID: <CAONaPpFGL6wMzij1obwL6x8SWbcXsOnRcruG48DVem-Dg66ObA@mail.gmail.com>
References: <20120225105502.0f4553a3@gmail.com>
	<alpine.LFD.2.02.1203011619530.2742@ionos>
	<CAONaPpFqas6RK1PNbiuzCg=LcVf1J9DuBxqxZDc2gHPgbDU91g@mail.gmail.com>
	<alpine.LFD.2.02.1203021134340.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33950 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965041Ab2CBL3V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 06:29:21 -0500
Received: by qaeb19 with SMTP id b19so160118qae.19
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Mar 2012 03:29:20 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1203021134340.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 2, 2012 at 11:41 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Thu, 1 Mar 2012, John Kacur wrote:
>> On Thu, Mar 1, 2012 at 4:23 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>> > That's why I asked to revert the
>> >
>> > =A0 =A0 =A0 acpi-make-gbl-hardware-lock-raw.patch
>> > =A0 =A0 =A0 acpi-make-ec-lock-raw-as-well.patch
>> >
>> > patches, so we can get that information.
>> >
>> > It might be a non issue on 3.2 and only a 3.0 problem, but as I ca=
n't
>> > find anything I'm going to drop those patches from the next 3.2
>> > release and wait for proper bugreports coming again :)
>> >
>>
>> FWIW
>> I believe the latter comes from here: https://lkml.org/lkml/2011/12/=
3/53
>
> And how does that help? I know that the ec lock conversion was a
> follow up to the gbl hardware lock conversion, but I need to see the
> backtrace again which made us convert gbl lock.
>

So, if I can read between the lines here, you're saying the posted
traceback in the ml link wouldn't occur without the the gbl lock?
Unfortunately I don't think the original backtrace was posted on the
ml, otherwise somebody could have hunted it down. Ok, FWIW turned out
to be not much.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
