From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Sat, 26 May 2007 18:08:29 +0200
Message-ID: <1180195709.4264.7.camel@chaos>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>
	 <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu>
	 <46574DE4.2080900@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:58554 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752772AbXEZQIZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 26 May 2007 12:08:25 -0400
In-Reply-To: <46574DE4.2080900@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-05-25 at 21:58 +0100, Rui Nuno Capela wrote:
> Is there anything I can do better to help myself figuring out this
> issue? As this is a  modern laptop such things like a serial console are
> unavailable, but it would be nice to track things up over netconsole
> perhaps?
> 
> I just need some bright and nice directions now ;) Hope someone finds
> this worth of attention too. Meanwhile, I'll be happy with 2.6.21-rt1 :)

Can you boot with "hpet=disable" on the command line ?

If that does not help, please provide the output of /proc/timer_list.

Thanks,

	tglx
