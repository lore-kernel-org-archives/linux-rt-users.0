From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/11] [ANNOUNCE] 3.0.12-rt30-rc2
Date: Sun, 4 Dec 2011 21:46:31 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112042145440.2735@ionos>
References: <20111204185444.411298317@goodmis.org> <201112042113.37047.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52853 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335Ab1LDUqe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Dec 2011 15:46:34 -0500
In-Reply-To: <201112042113.37047.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sun, 4 Dec 2011, Tim Sander wrote:

> Hi Steven
> > This is the RT stable review cycle of patch 3.0.12-rt30-rc2.
> > 
> > Please scream at me if I messed something up. Please test the patches too.
> Ok, this is a nearly blind shot, but i was expieriencing strange idle time 
> behaviour with this Ingo Molnar patch. The idle time was never incremented as 
> read from /proc/stat for several minutes. The system itself was behaving fine
> and had definetly not 100% load which was also verified with top.

Did some other time accounting increase instead ?
