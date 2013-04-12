From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Fri, 12 Apr 2013 15:31:18 +0200
Message-ID: <20130412133118.GC2368@pd.tnic>
References: <1365705214.9609.58.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365705214.9609.58.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Apr 11, 2013 at 02:33:34PM -0400, Steven Rostedt wrote:
> Comments?

I don't have a problem with it except with the yelling - I think I've
gone deaf. And for Rostedt code it is pretty clean and even *I* can
understand it :-).

Tony?

Steve, stupid question: since this is -rt only, why even push it
upstream?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
