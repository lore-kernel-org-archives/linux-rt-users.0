From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH RT] tasklet/rt: Prevent tasklets from going into infinite
 spin in RT
Date: Wed, 30 Nov 2011 12:24:47 -0200
Message-ID: <20111130142447.GA5271@uudg.org>
References: <1322618120.17003.104.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52944 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab1K3OZA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 09:25:00 -0500
Content-Disposition: inline
In-Reply-To: <1322618120.17003.104.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 29, 2011 at 08:55:20PM -0500, Steven Rostedt wrote:
=2E..
| I booted this patch against 3.0-rt stable, and it didn't crash ;)
| Could you apply it and see if it fixes the hang that you've been seei=
ng.

Steven,

I have a test box that would present the issue every 2 or 3 reboots,
consistently. Using your patch I have already rebooted the box 30 times
successfuly. And the test keeps going on... I feel confident to add my:

Tested-by: Luis Claudio R. Gon=E7alves <lgoncalv@redhat.com>

Cheers,
Luis

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
