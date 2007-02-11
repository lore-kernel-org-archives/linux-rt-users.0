From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 16:57:28 +0100
Message-ID: <1171209448.3661.10.camel@chaos>
References: <45CEF997.3020101@grandegger.com>
	 <20070211112933.GN29553@pengutronix.de>  <45CF0E90.2080806@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40590 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750706AbXBKP5X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 10:57:23 -0500
In-Reply-To: <45CF0E90.2080806@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Wolfgang,

On Sun, 2007-02-11 at 13:39 +0100, Wolfgang Grandegger wrote:
> As I see it, 2.6.20-rt3 has the same issues (have now attached the 
> missing make output). I fixed them manually and are now able to boot and 
> run the 2.6.20-rt5 on my Icecube board. Nevertheless, cyclictest returns 
> high values of around 8000-10000 (8-10ms). The fact that the unknown 
> field 'is_continuous' in arch/powerpc/kernel/time.c is still present 
> gives me the impression, that the code in there is not up-to-date. See 
> you next week on the Embedded World.

Yup, I did not come around to do the fixups. Is top on my todo list
though.

	tglx
