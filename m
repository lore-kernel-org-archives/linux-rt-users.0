From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH -rt 0/6] misc. ARM fixup and compile fixes
Date: Mon, 16 Jul 2007 14:24:19 -0700
Message-ID: <1184621059.32422.7.camel@vence.hilman.org>
References: <20070713175214.336577416@mvista.com>
	 <1184517119.12353.355.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:45579 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759137AbXGPVYW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 17:24:22 -0400
In-Reply-To: <1184517119.12353.355.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-07-15 at 18:31 +0200, Thomas Gleixner wrote:
> On Fri, 2007-07-13 at 10:52 -0700, Kevin Hilman wrote:
> > Thomas, Ingo,
> > 
> > Here's a handful of small fixes for -rt3.  They are either ARM-related
> > fixups or compile fixes for various .config combinations.
> > 
> > The first couple I already reported, but here they're all together.
> 
> Kevin, please check your mailer, editor or whatever involved. Most of
> your patches are white space damaged. Fixed them up manually.

Hmm, strange.  Just used 'quilt mail' as usual, including a
'--strip-trailing-whitespace' in ~/.quiltrc's QUILT_REFRESH_ARGS

will investigate.

Sorry,

Kevin
