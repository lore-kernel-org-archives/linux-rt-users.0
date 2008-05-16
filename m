From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH][PCI]: Introduce pci_find_capability_cached and make MSI use it
Date: Fri, 16 May 2008 12:01:48 -0700
Message-ID: <200805161201.48644.jbarnes@virtuousgeek.org>
References: <20080515160426.GD14846@ghostprotocols.net> <200805161044.34938.jbarnes@virtuousgeek.org> <20080516183356.GA7307@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760417AbYEPTCV@vger.kernel.org>
In-Reply-To: <20080516183356.GA7307@ghostprotocols.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday, May 16, 2008 11:33 am Arnaldo Carvalho de Melo wrote:
> > There are a few other common cap checks, but I don't think they compare
> > to MSI in terms of latency sensitivity (though I didn't audit all the
> > CAP_ID_EXP checks, there are quite a few of those).
> >
> > Since we know MSI is a problem, let's just go with fixing that for now. 
> > If we find that other caps are also causing problems we can revisit
> > caching all of them; the patch is simple enough.
>
> Do you want me to submit another patch or can you cook up one?

I can hack it up, probably not until Monday though (I'll be out of town this 
weekend).

Jesse
