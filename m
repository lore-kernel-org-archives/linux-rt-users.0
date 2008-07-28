From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: PCI: MSI interrupts masked using prohibited method
Date: Mon, 28 Jul 2008 15:04:08 -0700
Message-ID: <200807281504.08235.jbarnes@virtuousgeek.org>
References: <4860D09D.4060801@csr.com> <20080725165655.GC17093@parisc-linux.org> <20080728115910.46f0669e@brian.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthew Wilcox <matthew@wil.cx>,
	David Vrabel <david.vrabel@csr.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Michal Schmidt <mschmidt@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757960AbYG1WEa@vger.kernel.org>
In-Reply-To: <20080728115910.46f0669e@brian.englab.brq.redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> > I agree.  I think it's fine to have this limitation.
>
> I can imagine this being a problem e.g. for people wanting to isolate
> selected CPUs from interrupts for realtime tasks.

And they'll still be able to do this; they'll just need to use hardware that 
supports proper masking or make sure their interrupts are targetted at the 
right CPU from the start.

Jesse
