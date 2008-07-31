From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 0/3] powerpc - Make the irq reverse mapping tree
 lockless
Date: Thu, 31 Jul 2008 12:12:18 +0200
Message-ID: <20080731121218.5a07596a@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
To: linuxppc-dev@ozlabs.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53443 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYGaKLs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 06:11:48 -0400
In-Reply-To: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  OK, I goofed up with git-format-patch, forgot the --numbered option.

  The patches subjects should read:

	[PATCH 1/3] powerpc - Initialize the irq radix tree earlier
	[PATCH 2/3] powerpc - Separate the irq radix tree insertion and lookup
	[PATCH 3/3] powerpc - Make the irq reverse mapping radix tree lockless

  Sorry for that.

  Sebastien.
