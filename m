From: Nick Piggin <npiggin@suse.de>
Subject: Re: [RT] 2.6.33.3-rt19: WARNING: at fs/namespace.c:648
 commit_tree+0xf1/0x10b()
Date: Wed, 5 May 2010 00:27:56 +1000
Message-ID: <20100504142756.GB5905@laptop>
References: <20100504140443.GF4309@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: john stultz <johnstul@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40848 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416Ab0EDO2K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 May 2010 10:28:10 -0400
Content-Disposition: inline
In-Reply-To: <20100504140443.GF4309@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 04, 2010 at 11:04:44AM -0300, Luis Claudio R. Goncalves wrote:
> John,
> 
> As the backtrace seems to be closely related to what has been discussed on
> the thread "2.6.33.3-rt16: WARNING: at fs/namespace.c:1197", I copied the
> same people on this message.
> 
> As a side note, this time I just see the warning, there is no system freeze
> involved.
> 
> 
> ------------[ cut here ]------------
> WARNING: at fs/namespace.c:648 commit_tree+0xf1/0x10b()

I don't have the -rt tree at hand; can you copy a few lines of code
around line 648 of fs/namespace.c, please?

