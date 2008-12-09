From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Subject: Re: [ANNOUNCE] The -rt git tree
Date: Tue, 9 Dec 2008 19:37:58 +0100
Message-ID: <c62985530812091037k2ee4f5f3u1f3965c4f994bc98@mail.gmail.com>
References: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>
	 <c62985530812090908i38c5a7bflcbbcce6c8b9cd2f9@mail.gmail.com>
	 <alpine.DEB.1.10.0812091248020.19115@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
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
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50095 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbYLISiA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Dec 2008 13:38:00 -0500
Received: by qyk4 with SMTP id 4so231565qyk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Dec 2008 10:37:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0812091248020.19115@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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


I see... A lot is done with the scripts. I think I will follow closely
what happens on this tree :-)
Thanks!
