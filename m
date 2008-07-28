From: Michal Schmidt <mschmidt@redhat.com>
Subject: Re: PCI: MSI interrupts masked using prohibited method
Date: Mon, 28 Jul 2008 11:59:10 +0200
Message-ID: <20080728115910.46f0669e@brian.englab.brq.redhat.com>
References: <4860D09D.4060801@csr.com>
	<48807166.9010006@csr.com>
	<20080722155629.1160635e@brian.englab.brq.redhat.com>
	<200807221052.26879.jbarnes@virtuousgeek.org>
	<20080725152918.43bf3100@brian.englab.brq.redhat.com>
	<20080725134252.GG6701@parisc-linux.org>
	<20080725155329.79821436@brian.englab.brq.redhat.com>
	<488A015D.4040107@csr.com>
	<20080725165655.GC17093@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Vrabel <david.vrabel@csr.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080725165655.GC17093@parisc-linux.org>
Sender: linux-pci-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 25 Jul 2008 10:56:55 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Jul 25, 2008 at 05:37:49PM +0100, David Vrabel wrote:
> > The spec says that system software should enable MSI before setting 
> > message address and data (PCI 3.0 section 6.8.3.1 MSI
> > configuration). The kernel doesn't do this.
> 
> I think you meant "disable"?  I can't find anything in 6.8.3.1 of 3.0
> that refers to this.
> 
> > I really don't think we should be enabling/disabling MSI while 
> > interrupts might be being generated.  There are cases where
> > interrupts will be lost.  Consider PCIe where we might end up with
> > a situation where MSI is disabled and then enabled sufficiently
> > quickly that no periodic line interrupt message is sent by the
> > device.
> 
> I don't think there's a difference here between PCIe and conventional
> PCI.  A device raising a line based interrupt is perfectly equivalent
> to a device sending an INTx message.
> 
> > The message address and data should only be modified while the
> > vector is masked (to avoid the aforementioned 'tearing').  This
> > means that setting IRQ affinity cannot be done on devices without
> > per-vector mask bits.  I don't think this is a problem.
> 
> I agree.  I think it's fine to have this limitation.

I can imagine this being a problem e.g. for people wanting to isolate
selected CPUs from interrupts for realtime tasks.

> > In vague psuedo-code, set_affinity() should be something like this:
> > 
> > int did_mask = msi_mask_vector();
> > if (!did_mask) {
> >     return -ENOTSUPP;
> > }
> > /* fiddle with address and mask now */
> > msi_unmask_vector();
> 
> Yes, something like that.
