From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/3] Make rt_down_read_trylock() behave like
 down_read_trylock()
Date: Thu, 9 Apr 2009 15:47:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904091546290.21577@localhost.localdomain>
References: <20090407235853.309888494@suse.de> <20090407235902.196040156@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51421 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbZDINrw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 09:47:52 -0400
In-Reply-To: <20090407235902.196040156@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 8 Apr 2009, Jan Blunck wrote:

> This patch removes the stupid "Read locks within the self-held write lock
> succeed" behaviour. This is breaking in mm_take_all_locks() since it is quite
> common to ensure that a lock is taken with BUG_ON(down_read_trylock(&mm->mmap_sem)).

Good catch. There are some more oddballs in that file, which we missed
when we moved from 26 to 29 - we dropped the rwlocks stuff and that
cleaned up that area.

Thanks,

	tglx
