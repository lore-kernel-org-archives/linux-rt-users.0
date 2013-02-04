From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] OF: Fixup resursive locking code paths
Date: Mon, 4 Feb 2013 11:48:24 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041147420.11905@ionos>
References: <1359138107-14159-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359138107-14159-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 25 Jan 2013, Paul Gortmaker wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no real reason to use a rwlock for devtree_lock. It even
> could be a mutex, but unfortunately it's locked from cpu hotplug
> paths which can't schedule :(
> 
> So it needs to become a raw lock on rt as well.  The devtree_lock would
> be the only user of a raw_rw_lock, so we are better off cleaning up the
> recursive locking paths which allows us to convert devtree_lock to a
> read_lock.

Hmm. It's already a rw_lock. For RT we want to change that thing to a
raw_spinlock.

Thanks,

	tglx
