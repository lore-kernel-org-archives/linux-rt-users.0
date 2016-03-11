From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Fri, 11 Mar 2016 08:43:30 -0800
Message-ID: <20160311164330.GB6303@kroah.com>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48642 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbcCKQnb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 11:43:31 -0500
Content-Disposition: inline
In-Reply-To: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 11, 2016 at 11:34:36AM +0100, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

I can not accept a patch without a changelog entry, especially for
something like this that is not "trivial".

greg k-h
