From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.22.1-rt5
Date: Wed, 25 Jul 2007 09:52:47 +0200
Message-ID: <20070725075247.GB5125@elte.hu>
References: <20070724120436.GA14466@elte.hu> <200707241156.03149.gene.heskett@gmail.com> <20070724191027.GA13268@elte.hu> <200707242136.21457.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Gene Heskett <gene.heskett@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:55286 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbXGYHxA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 03:53:00 -0400
Content-Disposition: inline
In-Reply-To: <200707242136.21457.gene.heskett@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Gene Heskett <gene.heskett@gmail.com> wrote:

> Changing the "root (hd0,0)" to (sd0,0) failed.  Grub can't parse the 
> (sd0,0).

that (hd0,0) is a BIOS identification and needs no changing.

could you send me your grub.conf?

	Ingo
