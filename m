From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: [PATCH 00/11] [ANNOUNCE] 3.0.12-rt30-rc2
Date: Sun, 4 Dec 2011 21:13:36 +0100
Message-ID: <201112042113.37047.tim01@vlsi.informatik.tu-darmstadt.de>
References: <20111204185444.411298317@goodmis.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:58502 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755307Ab1LDUen (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Dec 2011 15:34:43 -0500
In-Reply-To: <20111204185444.411298317@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven
> This is the RT stable review cycle of patch 3.0.12-rt30-rc2.
> 
> Please scream at me if I messed something up. Please test the patches too.
Ok, this is a nearly blind shot, but i was expieriencing strange idle time 
behaviour with this Ingo Molnar patch. The idle time was never incremented as 
read from /proc/stat for several minutes. The system itself was behaving fine
and had definetly not 100% load which was also verified with top.

I hadn't had the time to investigate further and my tests where with an ealier 
release with the Ingo Molnar Tasklet patch on top.

Hopefully i will find some time to test this stuff further but it will 
probably tuesday CET.

Best regards
Tim
