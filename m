From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Tue, 26 Feb 2013 21:52:14 -0500
Message-ID: <CAP=VYLqJHWpFjDdKW331WTfvyyUs1vuAk=4xapO+JsKsXKdFog@mail.gmail.com>
References: <1361551010.32441.50.camel@marge.simpson.net> <1361913901.11373.59.camel@gandalf.local.home>
 <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
 <1361932359.11373.62.camel@gandalf.local.home> <1361932513.11373.65.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52472 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3B0Cwp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 21:52:45 -0500
Received: by mail-wg0-f46.google.com with SMTP id fg15so59722wgb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Feb 2013 18:52:44 -0800 (PST)
In-Reply-To: <1361932513.11373.65.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 26, 2013 at 9:35 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2013-02-26 at 21:32 -0500, Steven Rostedt wrote:
>
>> Bah! As I looked in my history I see I did the following:
>>
>>   git show v3.0:include/linux/sched.h
>>   git show v3.2:include/linux/sched.h
>>   git show v3.4:include/linux/sched.h
>>
>> I forgot the '-rt" on each one of them :-p
>
> That said...
>
> Only v3.0-rt has it. I'm barely supporting that now, and I'm only doing

Yeah -- I'm not surprised.  The only reason I'd checked myself is
that I'd recalled another thread where Mike said he'd been on v3.0,
and so I was reasonably sure it would be there in the 3.0 tree.

I'm all for deleting obsolete crap in mainline, so don't expect me
to argue against you and ask for supporting old releases on RT.   :)

Paul.
--
