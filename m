From: Rasmus Ahlberg <rasmus.ahlberg@electrolux.com>
Subject: Re: Blocked kworker in single core RT system
Date: Fri, 16 Dec 2016 15:40:52 +0000
Message-ID: <DB6PR0601MB2423189A098A40B238F7C452E09C0@DB6PR0601MB2423.eurprd06.prod.outlook.com>
References: <DB6PR0601MB24234A8580A50FC97001DD46E0870@DB6PR0601MB2423.eurprd06.prod.outlook.com>,<20161209222009.GJ1335@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0130.outbound.protection.outlook.com ([104.47.2.130]:29216
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933447AbcLQAOm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Dec 2016 19:14:42 -0500
In-Reply-To: <20161209222009.GJ1335@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry for taking my time replying. Really appreciate you answering!

> Is the workqueue usage that is problematic in the tty core?  Or, is it
> in a specific driver?  This is a more generic problem with most of the
> deferred work mechanisms that the kernel offers.
>
> Any work deferral system that doesn't map work units one-to-one with
> threads suffers the problem where the units cannot independently be
> prioritized amongst other system tasks.

It's in the tty core. Some work queue usage in the driver also, but it seem=
s to only be at open or close.

> Everyone always asks "is there a kernel config option that magically
> fixes my problem?", and the answer is almost always "no" :).
>
> Without having more information about the case you are looking at, I
> think it will be difficult to prescribe a potential solution.  If the
> workqueue is being used to defer work from interrupt context, then the
> use of request_threaded_irq() and pushing the work to thread context
> would be better.

I see. Hm, there is some IRQ thread, but not exactly sure if it's the kind =
you mean, or just a smaller handler. Luckily, we found a patch that convert=
s tty core to using its own kthreads (http://www.spinics.net/lists/linux-se=
rial/msg17783.html). Looking into it right now. It does seem promising.

Regards,
Rasmus Ahlberg
This email and any attached files is for the attention of the intended reci=
pient. The email and any attachments may contain material that is confident=
ial, privileged and/or attorney work product. If you are not the intended r=
ecipient: (a) contact the sender immediately and delete from your system al=
l copies of the email including any attachments. (b) do not read, print, re=
tain, copy or disseminate this message or any part of it. Any such unauthor=
ized use may be unlawful. E-mail transmission cannot be guaranteed to be se=
cure or error-free as information could be intercepted, corrupted, lost, de=
stroyed, arrive late or incomplete, or contain viruses. The sender therefor=
e can not accept liability for any errors or omissions in the contents of t=
his message, which arise as a result of e-mail transmission. If verificatio=
n is required please request a hard-copy version. The Electrolux Group www.=
electrolux.com
