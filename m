From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning
 instead
Date: Tue, 11 Jun 2013 13:42:21 +0200
Message-ID: <51B70D1D.2000709@linutronix.de>
References: <1369154725.6828.131.camel@gandalf.local.home> <CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com> <1370637266.9844.95.camel@gandalf.local.home> <51B35727.6040907@osadl.org> <51B46AC0.7050502@osadl.org> <CALqGcGoeGSN8tJ3AmRFeoysWEZdHA2c8X3Ebjn4GHOX=naK_Ww@mail.gmail.com> <20130610222215.GA27391@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christoph Mathys <eraserix@gmail.com>,
	Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33653 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab3FKLmc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Jun 2013 07:42:32 -0400
In-Reply-To: <20130610222215.GA27391@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/11/2013 12:22 AM, Paul Gortmaker wrote:
> This thread reminded me of the i915 compile warning I'd seen earlier
> today.  Fixing the warning does actually change the code produced.
> 
> I'll let you guys who have the actual hardware have the joy of reading
> the asm and deciding whether the change is significant or not...

This warning looks like the open-coded some of the functions which are
different on RT. In the v3.8 RT I removed the open-coded crap.

> 
> Paul.

Sebastian
