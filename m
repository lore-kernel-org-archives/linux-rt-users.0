From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] cyclictest: avoid using libnuma cpumask parsing
 functions
Date: Tue, 19 Apr 2016 09:30:21 -0400
Message-ID: <20160419093021.0a61742e@redhat.com>
References: <20160413153700.7a930369@sluggy.hsv.redhat.com>
	<20160414103018.3a07cf27@redhat.com>
	<alpine.LFD.2.20.1604191514540.9751@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1604191514540.9751@riemann>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 Apr 2016 15:17:33 +0200 (CEST)
John Kacur <jkacur@redhat.com> wrote:

> On Thu, 14 Apr 2016, Luiz Capitulino wrote:
> 
> > On Wed, 13 Apr 2016 15:37:00 -0500
> > Clark Williams <williams@redhat.com> wrote:
> >   
> > > John,
> > > 
> > > I ran into issues with parsing cpu masks when trying to run this command:
> > > 
> > > sudo ./cyclictest -i100 -qmu -h 2000 -p95 -t1 -a3
> > > 
> > > I had previously booted a 4-core system with these boot options:
> > > 
> > > 	isolcpus=3 nohz_full=3 rcu_nocbs=3
> > > 
> > > The intent was to run loads on cpus 0-2 while running cyclictest on the isolated cpu 3. 
> > > 
> > > Unfortunately, the libnuma function numa_parse_cpumask() (which we use when it's available) seems to check the current affinity mask and fails the parse if any of the cpus in the input string are not in the current affinity mask. I find this "unhelpful" when trying to place a measurement thread on an isolated cpu. 
> > > 
> > > This patch removes the wrapper function which uses libnuma cpumask parsing functions and instead uses the parser function we wrote for when libnuma is not available.   
> > 
> > There's an alternative solution that I was working on some time ago,
> > which is having a simple configure script. This is usually done
> > by simple projects that don't need a full blown autoconf machinery.
> > 
> > The patch below adds such a script. It detects librt, libpthread and
> > libnuma. It solves the problem you mention and it removes hardcoded
> > lib details from the Makefile.
> > 
> > If there's interest for this solution I can finish it and post for
> > inclusion.  
> 
> I find this interesting, maybe for the coming new devel system, I wouldn't 
> want to stick it in now right before a stable release though.

Makes sense.

> Also, I 
> like this much better than full blown auto-tools, but I don't want to lose control over 
> the compiling process either. In otherwords, there should be some way to 
> override what the script detects.

We could implement command-line options.
