From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [ANNOUNCE] 2.6.31.2-rt13
Date: Tue, 13 Oct 2009 17:46:48 +0200
Message-ID: <3efb10970910130846h2f9d4dbdk755f211fe8d43d4d@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>
	 <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain>
	 <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain>
	 <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain>
	 <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <3efb10970910061123k2b6826bci11f0f42509173b26@mail.gmail.com>
	 <alpine.LFD.2.00.0910062122230.5950@localhost.localdomain>
	 <alpine.LFD.2.00.0910062202590.5950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760369AbZJMPr6@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0910062202590.5950@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

2009/10/6 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 6 Oct 2009, Thomas Gleixner wrote:
>
>> On Tue, 6 Oct 2009, Remy Bohmer wrote:
>> > But I was wondering if you missed this one:
>> > http://patchwork.kernel.org/patch/50044/
>>
>> Yup, slipped through. Queued for the next release.
>
> Correction. I dropped the patch as it is just a sloppy work around.
> Why creating the thread in the first place ? Real fix below.

Well, I noticed a few minutes ago that the sirq-hrtimer is
periodically being scheduled (every 50msec here)
It does not do much, but it still it does something... (no idea what though)

So, is it really right to prevent it from starting up?

Remy
