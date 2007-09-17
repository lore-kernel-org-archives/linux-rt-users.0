From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 21:00:03 +0200
Message-ID: <200709172100.03279.ak@suse.de>
References: <200709172012.21102.ak@suse.de> <200709172046.50850.ak@suse.de> <1190055244.3253.95.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:55710 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbXIQTAG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 15:00:06 -0400
In-Reply-To: <1190055244.3253.95.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> Since it's all got "__" in the front, not good to use this method all
> over .. If you just need a real spinlock best to use
> DEFINE_RAW_SPINLOCK() unless your a special situation ..

Oopsing is a special situation. Nobody knows if all the fancy infrastructure
lurking inside the other macros still works.

-Andi
