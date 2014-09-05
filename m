From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Sat, 6 Sep 2014 00:47:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1409060046530.5472@nanos>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com> <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com> <CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com> <CAKohpokc+PiviEt3_2h0JjiH-XUuxiR5Tt6=NnJqTrCL_i98sA@mail.gmail.com>
 <CAKudYbOMKp437Sqq-A8m4A-d-rLHCGLXM5cH3ep13vp11ocJyg@mail.gmail.com> <CAKudYbPyN0GZ1pMPLQMd_Ks0hELBhE35SN8A1hi3_v8MMPVAjg@mail.gmail.com> <CAKohpokeUufzx7so6FcEd8rAg-MPw+2c9Aug9L_vXdu_4MvNOA@mail.gmail.com> <CAKudYbP09tc8JbBt82pOSy5nfQ42BVv=4knEUhHzz6nbs03SvQ@mail.gmail.com>
 <CAKohpokO6+=5LMr99CVyZYbTHRaUvgkAhHLkgfRaV3LJSfgpkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Harry van Haaren <harryhaaren@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Carsten Emde <cbe@osadl.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35100 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaIEWrj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Sep 2014 18:47:39 -0400
In-Reply-To: <CAKohpokO6+=5LMr99CVyZYbTHRaUvgkAhHLkgfRaV3LJSfgpkg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 5 Sep 2014, Viresh Kumar wrote:

> On 5 September 2014 17:36, Harry van Haaren <harryhaaren@gmail.com> wrote:
> > The down_read_trylock() fails, the other checks are fine.
> 
> So my initial guess was correct :)
> 
> > If i'm understanding correctly, the cpufreq_rwsem locks the module
> > from being unloaded during critical sections while writing to CPU
> > speed etc?
> 
> Its not about changing speed, but its more of a lock for critical sections
> only.. So, yes its required..
> 
> > Would that mean that an un-matched pair of down_read() up_write()
> > could cause the failure of changing CPU speed?
> 
> Probably yes, but why doesn't that happen without rt?

I think Carsten had looked into this.

