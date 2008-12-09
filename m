From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [ANNOUNCE] The -rt git tree
Date: Tue, 9 Dec 2008 21:06:34 +0100
Message-ID: <3efb10970812091206l2e6a17a6tc475a57b942cd28f@mail.gmail.com>
References: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>
	 <c62985530812090908i38c5a7bflcbbcce6c8b9cd2f9@mail.gmail.com>
	 <alpine.DEB.1.10.0812091248020.19115@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>,
	"Gregory Haskins" <ghaskins@novell.com>,
	"Darren Hart" <dvhltc@us.ibm.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:43981 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbYLIUGf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Dec 2008 15:06:35 -0500
Received: by qyk4 with SMTP id 4so280724qyk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Dec 2008 12:06:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0812091248020.19115@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

It all sounds good!

But, I was wondering, why using the scripts to convert the spinlocks
over and over, instead of pushing only the new lock API to mainline
asap? That would save a lot of conversion complexity and sounds like
migrating the RT patch to mainline much easier. It sounds to me like a
major rename action, and as long as there is only a spinlock behind
the new API, there is a very low risk in breaking things.
Later on the rt-mutex can be integrated behind the new API. In the
mean time everybody can get used to the new locking API.
That would save complexity and improve stability of the rt-patchset,
because it does not need to be figured out over and over if there are
new locks in new code that need to be converted back to spinlocks...
(In fact we only need to focus from there on new code that use the
spinlock API, and if it is really required to use that.)

Kind Regards,

Remy

2008/12/9 Steven Rostedt <rostedt@goodmis.org>:
>
> On Tue, 9 Dec 2008, Fr?d?ric Weisbecker wrote:
>>
>> Hi Steve.
>>
>> That's a good news.
>>
>> But after converting these spinlocks into lock_t, how will you synchronize with
>> the mainline on each release? You will have a huge amount of conflicts
>> at every merges...
>
> This is why master is separate from rt-master. The rt-master will grow
> like tip/master does. But the master will be recreated each time.
> Basically, the creation of master is this:
>
>
> git checkout master
> git reset --hard rt-master
> ./scripts/convert-spinlocks
> git commit -a -m 'Convert all spinlocks to lock_t'
> ./scripts/convert-locks
> git commit -a -m 'Convert some locks back to spinlock_t'
>
> Thus we do not need to worry about the conflicts caused by the lock
> conversion. That will be done automatically each time we create a new
> master.
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
