From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] msi: skip calling pci_find_capability from msi_set_mask_bits
Date: Mon, 19 May 2008 13:11:45 -0700
Message-ID: <200805191311.46162.jbarnes@virtuousgeek.org>
References: <20080515160426.GD14846@ghostprotocols.net> <200805161044.34938.jbarnes@virtuousgeek.org> <48310691.9050706@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-mail-33.bluehost.com ([69.89.18.153]:53795 "HELO
	outbound-mail-33.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757623AbYESUL4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 16:11:56 -0400
In-Reply-To: <48310691.9050706@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sunday, May 18, 2008 9:48 pm Hidetoshi Seto wrote:
> Jesse Barnes wrote:
> > Since we know MSI is a problem, let's just go with fixing that for now. 
> > If we find that other caps are also causing problems we can revisit
> > caching all of them; the patch is simple enough.
>
> Humm...
> I suppose it can be more simple. How about this patch?
>
> > everytime handle_edge_irq is called it needs to mask and unmask MSI, and
> > that leads to a series of very expensive calls to pci_find_capability
>
> The position of MSI capability is already cached in the msi_desc when
> we enter the msi_set_mask_bits().  Use it instead.
>
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Yeah, this looks really nice.  It should also fix Arnaldo's latency problem, 
and really looks like a bug fix for the MSI code more than anything.

Arnaldo, can you take a look & test and ack/nack?

Thanks,
Jesse
