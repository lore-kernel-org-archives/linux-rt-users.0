From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: [PATCH RT 3/4] net: netfilter: Serialize xt_write_recseq sections
 on RT
Date: Wed, 31 Oct 2012 11:25:02 -0700
Message-ID: <CAN8Q1EcVfzJJh+XMeXMMk33kwyyyRoEWsuEbSQqVW0Vz3i3Vuw@mail.gmail.com>
References: <20121031003258.811955127@goodmis.org>
	<20121031003314.763160265@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121031003314.763160265@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 30, 2012 at 5:33 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The netfilter code relies only on the implicit semantics of
> local_bh_disable() for serializing wt_write_recseq sections. RT breaks
> that and needs explicit serialization here.
>
> Reported-by: Peter LaDow <petela@gocougs.wsu.edu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

> diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> index f1804a3..a5eea5d 100644

> diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
> index 32cddf7..bed90da2 100644

> diff --git a/net/netfilter/core.c b/net/netfilter/core.c
> index 899b71c..5db16ea 100644

I'm trying these out right now.  We've applied these patches to
3.0.36-rt58 (rather than pull in the full 3.0.48-rt72 -- too much risk
for us right now to do a full kernel change).  I am setting up a
3.0.48-rt72-rc1 fixture as well to test the release candidate.

Thanks,
Pete
