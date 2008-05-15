From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH][PCI]: Introduce pci_find_capability_cached and make MSI use it
Date: Thu, 15 May 2008 11:04:07 -0600
Message-ID: <20080515170407.GM9921@parisc-linux.org>
References: <20080515160426.GD14846@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:44317 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYEOREI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2008 13:04:08 -0400
Content-Disposition: inline
In-Reply-To: <20080515160426.GD14846@ghostprotocols.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 15, 2008 at 01:04:26PM -0300, Arnaldo Carvalho de Melo wrote:
> 	So I implemented pci_find_capability_cached and made MSI use it
> for good measure, please consider applying.

As I told you on IRC, this is just the MSI code being complete crap.
It should be caching the offset itself.  We shouldn't have this extra
array in the struct pci_dev just because MSI is broken.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
