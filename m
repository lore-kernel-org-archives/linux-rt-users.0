From: Greg KH <greg@kroah.com>
Subject: Re: [stable]  Patch for 2.6.33
Date: Wed, 18 May 2011 16:53:42 -0700
Message-ID: <20110518235342.GA2736@kroah.com>
References: <alpine.LFD.2.00.1105141740040.29326@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@suse.de, Thomas Gleixner <tglx@linutronix.de>,
	stable@kernel.org, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34261 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753661Ab1ESAQi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 May 2011 20:16:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1105141740040.29326@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, May 14, 2011 at 05:47:25PM +0200, John Kacur wrote:
> 
> I merging the latest 2.6.33.13 stable branch into the real-time kernel and 
> using a distro with a make 3.82, and needed to cherry-pick the following 
> commit in order to compile. Please consider picking it up for 2.6.33.y 
> stable.

Now applied, thanks.

greg k-h
