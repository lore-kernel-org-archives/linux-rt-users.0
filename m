From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Fri, 24 Mar 2017 09:38:20 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703240935250.3688@nanos>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com> <20170322173759.GK10423@jcartwri.amer.corp.natinst.com> <20170322110116.4b14dafd@vmware.local.home> <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
 <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lionel Debieve <lionel.debieve@st.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 22 Mar 2017, Julia Cartwright wrote:
> On Wed, Mar 22, 2017 at 01:30:12PM -0500, Grygorii Strashko wrote:
> > It will not be threaded because there are IRQF_ONESHOT used.
> > 
> > 	ret = devm_request_threaded_irq(&pdev->dev, irq,
> > 					sti_mbox_irq_handler,
> > 					sti_mbox_thread_handler,
> > 					IRQF_ONESHOT, mdev->name, mdev);
> 
> Indeed.  I had skipped over this important detail when I was skimming
> through the code.
> 
> Thanks for clarifying!
> 
> Is IRQF_ONESHOT really necessary for this device?  The primary handler
> invokes sti_mbox_disable_channel() on the interrupting channel, which I
> would hope would acquiesce the pending interrupt at the device-level?

Well, this is a typical case of well done split into primary and threaded
handler. There is no advantage on RT to force this into double threaded
handling. Making the lock raw is definitely the proper solution here.

Thanks,

	tglx
