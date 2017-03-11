From: Mike Galbraith <efault@gmx.de>
Subject: Re: oops with 4.9.13-rt12 under mild load (and no rt-tasks active)
Date: Sat, 11 Mar 2017 06:51:14 +0100
Message-ID: <1489211474.19578.14.camel@gmx.de>
References: <20170310194717.GE32625@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbdCKFvZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Mar 2017 00:51:25 -0500
In-Reply-To: <20170310194717.GE32625@osadl.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-03-10 at 19:47 +0000, Nicholas Mc Guire wrote:

>  Has anyone seen 4.9.13-rt12 oopses related to ext4 or vfs in general ?

FWIW, here it's seen quite a bit of hefty use on boxen large and small
with no trouble.  That said, @stable has a large pile queued for 4.9, 8
for ext4, some of which don't sound all that benign.

	-Mike
