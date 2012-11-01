From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: [PATCH RT 3/4] net: netfilter: Serialize xt_write_recseq sections
 on RT
Date: Thu, 1 Nov 2012 15:30:42 -0700
Message-ID: <CAN8Q1Ecq9T5HC60_ta8Xr9kKyAe8Fjrd8znV9MpDTYqkSSptOw@mail.gmail.com>
References: <20121031003258.811955127@goodmis.org>
	<20121031003314.763160265@goodmis.org>
	<CAN8Q1EcVfzJJh+XMeXMMk33kwyyyRoEWsuEbSQqVW0Vz3i3Vuw@mail.gmail.com>
	<alpine.LFD.2.02.1211012213460.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1211012213460.2756@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Nov 1, 2012 at 2:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Cough. You are missing a boat load of crucial fixes. There is a damned
> good reason why 3.0.stable got 12 updates and the -rt version 14.

I don't doubt there are.  But we've only experienced one problem
between 3.0.36-rt58 and 3.0.48-rt72.  Indeed, it might be easier to
evaluate the risk if all the changelogs were readily available.  So
far, however, we haven't discovered any other issues that give us any
concerns.

> Your risk assessment is definitley interesting.

We have specifically tested 3.0.36-rt58 for performance in our
application.  Moving to 3.0.48-rt72 poses risk about whether would
still be able to meet our performance requirements.  And with regard
to stability, the only issue we've had since our earlier moved to
3.0.36-rt58 was the netfilter problem.  We initially only saw the
problem on PPP related interfaces, so we reverted to 3.0.3 (non-rt)
for PPP related issues.

Now, if you think there are some issues that should raise eyebrows, or
can point me to a list of changelogs, I'd be happy to evaluate them.

Thanks,
Pete
