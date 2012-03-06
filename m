From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt16
Date: Tue, 06 Mar 2012 08:50:18 -0500
Message-ID: <1331041818.25686.375.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203061118050.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3366 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2CFNuU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 08:50:20 -0500
In-Reply-To: <alpine.LFD.2.02.1203061118050.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-03-06 at 11:20 +0100, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.2.9-rt16 release.
> 
> Changes vs. 3.2.9-rt15:
> 
>   * cpu hotplug lock init fix [ Steven ]
> 
>   * seqlock fix CONFIG typo
> 

Note, yesterday while running some stress tests I hit a live lock here:

static inline struct dentry *dentry_kill(struct dentry *dentry, int ref)
        __releases(dentry->d_lock)
{
        struct inode *inode;
        struct dentry *parent;

        inode = dentry->d_inode;
        if (inode && !spin_trylock(&inode->i_lock)) {
relock:
                seq_spin_unlock(&dentry->d_lock);
                cpu_relax();
                return dentry; /* try again with same dentry */
        }
        if (IS_ROOT(dentry))
                parent = NULL;
        else
                parent = dentry->d_parent;
        if (parent && !seq_spin_trylock(&parent->d_lock)) {
                if (inode)
                        spin_unlock(&inode->i_lock);
                goto relock;
        }


When it fails to grab either the inode->i_lock or the parent->d_lock it
returns back to dput() and dput() will retry. We get into another one of
these cases where we can spin blocking the holder of the locks.

I experimented with adding a grab lock of the inode->i_lock or
parent->d_lock if they existed (required initializing parent to NULL),
which seemed to help a lot, but then eventually it locked up. As I'm not
sure its safe to grab them straight here even after we release the
dentry->d_lock. I'll have to enable full lockdep to see if this breaks
the ordering.

I haven't looked too deeply into this code yet, but I'm assuming that
dput() can be called where we can't just take the inode or parent lock?

-- Steve


