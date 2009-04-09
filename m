From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] kvm: wake up waitqueue before calling get_cpu()
Date: Thu, 9 Apr 2009 15:48:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904091548190.21577@localhost.localdomain>
References: <20090407235853.309888494@suse.de> <20090407235902.542493610@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51478 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbZDINso (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 09:48:44 -0400
In-Reply-To: <20090407235902.542493610@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 8 Apr 2009, Jan Blunck wrote:

> This moves the get_cpu() call down to be called after we wake up the
> waiters. Therefore the waitqueue locks can savely be rt mutex.

Applied. Thanks,

	 tglx
