From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Fix Bug messages
Date: Thu, 31 Jul 2008 10:01:06 -0500
Message-ID: <4891D3B2.2000108@redhat.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>	<alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>	<alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>	<200807301101.32417.j.mell@t-online.de>	<20080730171842.GB3420@linux.vnet.ibm.com>	<20080731100023.0221ec2b@bull.net>	<520f0cf10807310313q45599221q3db1b6fd7e7c722f@mail.gmail.com>	<20080731132336.362bd487@bull.net>	<520f0cf10807310649l1083e29bmf0f704e13dee96c@mail.gmail.com>	<1217512907.8157.91.camel@twins> <20080731163515.4a992060@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Kacur <jkacur@gmail.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	J?rgen Mell <j.mell@t-online.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Triplett <josht@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbYGaPS7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 11:18:59 -0400
In-Reply-To: <20080731163515.4a992060@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sebastien Dugue wrote:
>   This does indeed seem to fix the problem, no more BUGs appearing
> on the console with 2.6.26-rt1 now.
> 
>   Thanks,
> 
>   Sebastien.

Sebastien,

Would you send me your config? I'm running -rt1 on my laptop and am not seeing any of
the messages you listed earlier. It's bound to be that I turned off something that
you're using, so I'd like to see what that is.

Thank,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiR07IACgkQHyuj/+TTEp2LgACfTK3sNyABEtR+BDc29L3DdP/c
KKsAoM0RvuG4EHLyfHJUnfERhXbWuZY4
=1eZ6
-----END PGP SIGNATURE-----
