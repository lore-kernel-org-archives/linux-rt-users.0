From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 2/3] kvm: convert spin-locks to raw_spinlock_t
Date: Thu, 9 Apr 2009 15:48:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904091547540.21577@localhost.localdomain>
References: <20090407235853.309888494@suse.de> <20090407235902.400480759@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51465 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbZDINsT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 09:48:19 -0400
In-Reply-To: <20090407235902.400480759@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 8 Apr 2009, Jan Blunck wrote:

> This patch converts some KVM spin-locks to be of type raw_spinlock_t.

Applied. Thanks,

	 tglx
