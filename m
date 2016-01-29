From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Fri, 29 Jan 2016 13:55:24 -0500
Message-ID: <20160129185523.GZ8889@windriver.com>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1453992270-4688-3-git-send-email-daniel.wagner@bmw-carit.de>
 <56AB5867.6020405@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AB5867.6020405@bmw-carit.de>
Sender: linux-kbuild-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible pointer check into error] On 29/01/2016 (Fri 13:17) Daniel Wagner wrote:

> On 01/28/2016 03:44 PM, Daniel Wagner wrote:
> > +# enforce correct pointer usage
> > +KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
> > +
> 
> As it turns out there are a few fallouts by that one. I'll send fixes
> for it.

Did you try non-x86 builds with this applied?   I'd be really surprised
if there were just a few, once you did allyesconfig/allmodconfig for
ARM, MIPS, PPC, etc.

P.
--
