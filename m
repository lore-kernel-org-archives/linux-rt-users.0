From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH][PCI]: Introduce pci_find_capability_cached and make MSI use it
Date: Fri, 16 May 2008 10:44:34 -0700
Message-ID: <200805161044.34938.jbarnes@virtuousgeek.org>
References: <20080515160426.GD14846@ghostprotocols.net> <20080515170407.GM9921@parisc-linux.org> <20080515171003.GF14846@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760156AbYEPRpX@vger.kernel.org>
In-Reply-To: <20080515171003.GF14846@ghostprotocols.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday, May 15, 2008 10:10 am Arnaldo Carvalho de Melo wrote:
> Em Thu, May 15, 2008 at 11:04:07AM -0600, Matthew Wilcox escreveu:
> > On Thu, May 15, 2008 at 01:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 	So I implemented pci_find_capability_cached and made MSI use it
> > > for good measure, please consider applying.
> >
> > As I told you on IRC, this is just the MSI code being complete crap.
> > It should be caching the offset itself.  We shouldn't have this extra
> > array in the struct pci_dev just because MSI is broken.
>
> Well, we can certainly do that, its just that I did this first and
> thought that perhaps there could be some other users, but I see that 44
> extra bytes per pci_dev can be a pain if the only one to reap benefits
> is MSI, can't you think of any other users? I couldn't detect any so far
> in my admitedly limited testing.

There are a few other common cap checks, but I don't think they compare to MSI 
in terms of latency sensitivity (though I didn't audit all the CAP_ID_EXP 
checks, there are quite a few of those).

Since we know MSI is a problem, let's just go with fixing that for now.  If we 
find that other caps are also causing problems we can revisit caching all of 
them; the patch is simple enough.

Thanks,
Jesse
