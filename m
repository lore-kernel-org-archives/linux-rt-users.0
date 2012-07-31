From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 05/12] slab: Prevent local lock deadlock
Date: Mon, 30 Jul 2012 21:22:35 -0400
Message-ID: <1343697755.27983.17.camel@gandalf.stny.rr.com>
References: <20120718223910.898476857@goodmis.org>
	 <20120718223957.856443728@goodmis.org> <5011DD9B.1030901@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, chris.pringle@miranda.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: frank.rowand@am.sony.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5011DD9B.1030901@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-07-26 at 17:15 -0700, Frank Rowand wrote:

> 
> Config is from arch/arm/configs/omap2plus_defconfig
> plus:
> 
>    CONFIG_USB_EHCI_HCD=y
>    CONFIG_USB_NET_SMSC95XX=y
>    CONFIG_PREEMPT_RT_FULL=y
> 

Interesting, I just booted my panda board against 3.0.36-rt58 with that
config and these three set, and I didn't get this error.

-- Steve
