From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 11:01:16 -0700
Message-ID: <20170322110116.4b14dafd@vmware.local.home>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
        <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lionel Debieve <lionel.debieve@st.com>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:51161 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965388AbdCVSBZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 14:01:25 -0400
In-Reply-To: <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 22 Mar 2017 12:37:59 -0500
Julia Cartwright <julia@ni.com> wrote:

> Which kernel were you testing on, here?  From what I can tell, this
> should have been fixed with Thomas's commit:
> 
>    2a1d3ab8986d ("genirq: Handle force threading of irqs with primary
> and thread handler")

Thanks Julia for looking into this. I just looked at the code, and saw
that it does very little with the lock held, and was fine with the
conversion. But if that interrupt handler should be in a thread, we
should see if that's the issue first.

> 
> Which landed in 4.4.  It forces the primary handler to be threaded as
> well.
> 

Lionel,

Can you check if this is an issue with 4.4 too?

-- Steve
