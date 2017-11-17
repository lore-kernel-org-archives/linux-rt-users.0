From: Julia Cartwright <julia@ni.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Fri, 17 Nov 2017 11:38:20 -0600
Message-ID: <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Pavel V. Panteleev" <panteleev_p@mcst.ru>,
        <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:53946 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752783AbdKQRiw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 12:38:52 -0500
Content-Disposition: inline
In-Reply-To: <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 16, 2017 at 05:08:37PM +0100, Sebastian Andrzej Siewior wrote:
> + Steven & Julia
>
> On 2017-11-07 12:47:27 [+0300], Pavel V. Panteleev wrote:
> > Thanks, it works.
>
> Okay, good to hear.
>
> Steven + Julia:
> We need to decide what are going to do about this stable-wise. The bug
> was reported against 3.14.79-rt85 and the devel tree is not affected*.
> The thread starts at
>   https://www.spinics.net/lists/linux-rt-users/msg17560.html

Your proposed patch seems reasonable to me to pull back into the
relevant releases.  Can you send a proper patch against the latest
affected tree (4.9?) and the stable team will pull it back?  It looks
like it will need some minor massaging on it's way back, but that
shouldn't be a problem.

Thanks,
   Julia
