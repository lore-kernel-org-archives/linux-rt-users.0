From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] tasklets: fix __tasklet_hi_schedule()
Date: Thu, 11 Sep 2008 10:03:07 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0809111002560.22104@gandalf.stny.rr.com>
References: <20080911140008.05addc59@bull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux-rt <linux-rt-users@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Tim Chavez <tinytim@us.ibm.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:57007 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYIKODK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Sep 2008 10:03:10 -0400
In-Reply-To: <20080911140008.05addc59@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 11 Sep 2008, Sebastien Dugue wrote:

> From b5ae1d4954394b05c17a87403e7584c7f90e457a Mon Sep 17 00:00:00 2001
> From: Sebastien Dugue <sebastien.dugue@bull.net>
> Date: Thu, 11 Sep 2008 13:47:40 +0200
> Subject: [PATCH 1/1] tasklets: fix __tasklet_hi_schedule()
> 
>   fix __tasklet_hi_schedule() which incorrectly puts the tasklet to be
> scheduled on the wrong list (tasklet_vec instead of tasklet_hi_vec).
> 
>   This broke rebooting a box with the ehea driver.
> 
> Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>

Thanks, applied.

-- Steve
