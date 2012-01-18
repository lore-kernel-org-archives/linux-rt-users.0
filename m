From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/4] wait-simple: Simple waitqueue implementation
Date: Wed, 18 Jan 2012 10:39:25 -0500
Message-ID: <1326901165.17534.78.camel@gandalf.stny.rr.com>
References: <20120118034531.335521323@goodmis.org>
	 <20120118034700.245278561@goodmis.org>
	 <1326878928.7482.2.camel@marge.simson.net>
	 <1326890703.17534.76.camel@gandalf.stny.rr.com>
	 <1326894017.12502.7.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:33119 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2ARPj1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 10:39:27 -0500
In-Reply-To: <1326894017.12502.7.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-18 at 14:40 +0100, Mike Galbraith wrote:

> I saw compiler warning go zinging by, stopped the build and added the

Thanks, I didn't look for warnings. I'll add the module.h.

> include.  Trying to use the posted patches doesn't work without digging
> out the signature damage, so it was easier to make my own.. and I too

Hmm, I'll stop posting these with gpg sigs.

-- Steve

> just spanked the non-existent include :)


