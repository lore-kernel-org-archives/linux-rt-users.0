From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 00/25][RFC 3.0.23-rt39-rc1] [ANNOUNCE]
 3.0.23-rt39-rc1 release cycle
Date: Tue, 06 Mar 2012 17:20:33 -0500
Message-ID: <1331072433.25686.401.camel@gandalf.stny.rr.com>
References: <20120306161636.491172179@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4255 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030811Ab2CFWUg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 17:20:36 -0500
In-Reply-To: <20120306161636.491172179@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-03-06 at 11:16 -0500, Steven Rostedt wrote:

> 
> Changes from 3.0.23-rt38:
> 
> ---
> 
> 
> Andy Lutomirski (2):
>       x86-64-remove-vsyscall-number-3
>       x86-64-emulate-legacy-vsyscalls
> 
> Steven Rostedt (11):
>       revert-convert-xtime_lock-to-raw_seqlock
>       revert-seqlock-create-raw_seqlock
>       revert-seqlock-use-seqcount
>       revert-seqlock-remove-unused-functions

Note, in order to apply Thomas's seqlock patches, I had to revert 4 -rt
patches, and apply two (Andy's) patches from mainline.

-- Steve




