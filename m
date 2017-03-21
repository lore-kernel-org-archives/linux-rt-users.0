From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] tty: serial: st-asc: Make the locking RT aware
Date: Tue, 21 Mar 2017 16:15:33 -0400
Message-ID: <20170321161533.44c4df87@vmware.local.home>
References: <1490112340-29772-1-git-send-email-lionel.debieve@st.com>
        <20170321144437.569440c2@vmware.local.home>
        <alpine.DEB.2.20.1703211950040.3776@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: lionel.debieve@st.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1703211950040.3776@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 21 Mar 2017 19:51:47 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 21 Mar 2017, Steven Rostedt wrote:
> > >  	/*
> > >  	 * Disable interrupts so we don't get the IRQ line
> > > bouncing  
> > 
> > I'm nervous about the above comment, which in full is:
> > 
> > 	/*
> > 	 * Disable interrupts so we don't get the IRQ line bouncing
> > 	 * up and down while interrupts are disabled.
> > 	 */
> > 
> > I'm not sure if disabling interrupts helps on an SMP system. This
> > patch does change what happens when port->sysrq is set. But I'm not
> > sure we care.  
> 
> It disables interrupts at the device level which obviously helps
> whether on SMP or not.
>

OK, so this has nothing to do with the local_irq_save() that is being
removed, which would be fine then.


-- Steve
