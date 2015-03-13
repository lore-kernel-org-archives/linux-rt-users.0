From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 00/39] Linux 3.14.34-rt32-rc1
Date: Fri, 13 Mar 2015 11:24:23 -0400
Message-ID: <20150313112423.7badad50@gandalf.local.home>
References: <20150312191307.081068717@goodmis.org>
 <1426222153.17611.4.camel@gmail.com>
 <20150313151134.GF3042@home.goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150313151134.GF3042@home.goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 13 Mar 2015 11:11:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, Mar 13, 2015 at 05:49:13AM +0100, Mike Galbraith wrote:
> > On Thu, 2015-03-12 at 15:13 -0400, Steven Rostedt wrote:
> > > Dear RT Folks,
> > > 
> > > This is the RT stable review cycle of patch 3.14.34-rt32-rc1.
> > > 
> > > Please scream at me if I messed something up.
> > 
> > Hm, in both 12/14 series, 21/N went on a walkabout.
> 

I missed the error message about these. For some reason this patch
causes the following errors:


<linux-kernel@vger.kernel.org>: host vger.kernel.org[209.132.180.67]
said: 550 5.7.1 Content-Policy reject msg: Wrong MIME labeling on 8-bit
character texts. BF:<H 0>; S932171AbbCMPPW (in reply to end of DATA
command)

<linux-rt-users@vger.kernel.org>: host vger.kernel.org[209.132.180.67]
said: 550 5.7.1 Content-Policy reject msg: Wrong MIME labeling on 8-bit
character texts. BF:<H 0>; S932171AbbCMPPW (in reply to end of DATA
command)

My other series will be missing them too.

-- Steve
