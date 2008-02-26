From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [(RT RFC) PATCH v2 5/9] adaptive real-time lock support
Date: Tue, 26 Feb 2008 08:03:43 -0700
Message-ID: <47C3E3FF.BA47.005A.0@novell.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
 <20080225160103.11268.25579.stgit@novell1.haskins.net>
 <20080225220313.GG2659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <a.p.zijlstra@chello.nl>, <mingo@elte.hu>, <bill.huey@gmail.com>,
	<rostedt@goodmis.org>, <kevin@hilman.org>, <tglx@linutronix.de>,
	<cminyard@mvista.com>, <dsingleton@mvista.com>,
	<dwalker@mvista.com>, "Moiz Kohari" <MKohari@novell.com>,
	"Peter Morreale" <PMorreale@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>, <dsaxena@plexity.net>,
	<acme@redhat.com>, <ak@suse.de>, <gregkh@suse.de>,
	<npiggin@suse.de>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: "Pavel Machek" <pavel@ucw.cz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:25623 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbYBZPLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2008 10:11:06 -0500
In-Reply-To: <20080225220313.GG2659@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Feb 25, 2008 at  5:03 PM, in message
<20080225220313.GG2659@elf.ucw.cz>, Pavel Machek <pavel@ucw.cz> wrote: 

>> +static inline void
>> +prepare_adaptive_wait(struct rt_mutex *lock, struct adaptive_waiter 
> *adaptive)
> ...
>> +#define prepare_adaptive_wait(lock, busy) {}
> 
> This is evil. Use empty inline function instead (same for the other
> function, there you can maybe get away with it).
> 

I went to implement your suggested change and I remembered why I did it this way:  I wanted a macro so that the "struct adaptive_waiter" local variable will fall away without an #ifdef in the main body of code.  So I have left this logic alone for now.
