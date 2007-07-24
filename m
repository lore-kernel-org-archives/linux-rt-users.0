From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.22.1-rt5
Date: Tue, 24 Jul 2007 21:10:27 +0200
Message-ID: <20070724191027.GA13268@elte.hu>
References: <20070724120436.GA14466@elte.hu> <200707241156.03149.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Gene Heskett <gene.heskett@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51211 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbXGXTKf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 15:10:35 -0400
Content-Disposition: inline
In-Reply-To: <200707241156.03149.gene.heskett@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Gene Heskett <gene.heskett@gmail.com> wrote:

> The above stanza still needs some tlc.  I built a 2.6.22.1-rt6 (rt5 
> wouldn't build) using the same old config that a make oldconfig didn't 
> fuss about, but the reboot never completed, see the attached, heavily 
> smunched camera shot of the panic.
> 
> Kinda looks like hda/sda confusion, with rt3 (this boot), its hda*, 
> what is it now?  fstab or kernel config error?

yeah, as long as your filesystems are created with a proper label, all 
that you need to do is to change all 'hda' to 'sda' in the new kernel's 
/etc/grub.conf entry. (or enable the old IDE code in the .config, under 
CONFIG_IDE)

	Ingo
